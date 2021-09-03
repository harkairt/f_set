import 'package:f_set/data/game_cubit.dart';
import 'package:f_set/presentation/card_grid.dart';
import 'package:f_set/presentation/set_card_row.dart';
import 'package:f_set/set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SetBoard extends HookWidget {
  const SetBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final board = context.select((GameCubit cubit) => cubit.state.board);
    final deck = context.select((GameCubit cubit) => cubit.state.deck);
    final pickedCards = context.select((GameCubit cubit) => cubit.state.pickedCards);
    debugPrint('____ board: ${board.length}, deck: ${deck.length}');

    void updatePickedCards(List<SetCard?> cards) => context.read<GameCubit>().updatePickedCards(cards);

    void onCardSelected(SetCard card) {
      var updatedCards = <SetCard?>[];

      if (pickedCards.contains(card)) {
        final updatedItems = [...pickedCards]..replaceItemWithNull(card);
        updatedCards = updatedItems;
      } else {
        if (pickedCards.effectiveLength < 3) {
          updatedCards = [...pickedCards]..replaceFirstNullOrAdd(card);
        } else {
          updatedCards = [card];
        }
      }

      updatePickedCards(updatedCards);
      if (updatedCards.effectiveLength == 3) {
        context.read<GameCubit>().checkSet();
      }
    }

    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardGrid(
                  cards: board,
                  selectedCards: pickedCards,
                  onCardSelected: onCardSelected,
                ),
                Spacer(),
                SetCardRow(cards: pickedCards, isSet: pickedCards.isSet)
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Builder(
              builder: (context) {
                final boardSetCount = context.select((GameCubit cubit) => cubit.state.boardSetCount);
                final foundSets = context.select((GameCubit cubit) => cubit.state.foundSets);
                final pickedCards = context.select((GameCubit cubit) => cubit.state.pickedCards);

                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 36, left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$boardSetCount ${boardSetCount == 1 ? 'set' : 'sets'} on board'),
                        Text('${foundSets.length} ${foundSets.length == 1 ? 'set' : 'sets'} found'),
                        Spacer(),
                        Align(
                          child: IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              Phoenix.rebirth(context);
                            },
                          ),
                        ),
                        Spacer(),
                        Text('Colors: ${pickedCards.colors}'),
                        Text('Shapes: ${pickedCards.shapes}'),
                        Text('Textures: ${pickedCards.textures}'),
                        Text('Count: ${pickedCards.count}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // void onCardSelected(ValueNotifier<List<SetCard?>> cards, SetCard card) {
  //   if (cards.value.contains(card)) {
  //     cards.value = [...cards.value]..replaceItemWithNull(card);
  //   } else {
  //     if (cards.value.effectiveLength < 3) {
  //       cards.value = [...cards.value]..replaceFirstNullOrAdd(card);
  //     } else {
  //       cards.value = [card];
  //     }
  //   }
  // }
}
