import 'package:f_set/data/game_cubit.dart';
import 'package:f_set/presentation/card_grid.dart';
import 'package:f_set/presentation/set_card_row.dart';
import 'package:f_set/presentation/set_card_widget.dart';
import 'package:f_set/presentation/theme/app_theme.dart';
import 'package:f_set/utils/extensions.dart';
import 'package:f_set/presentation/theme/scale.dart';
import 'package:f_set/set.dart';
import 'package:f_set/utils/type_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

class SetBoard extends HookWidget {
  const SetBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pickedCards = useState(<SetCard?>[]);

    void onCardPressed(SetCard card) {
      if (pickedCards.value.contains(card)) {
        final updatedItems = [...pickedCards.value]..replaceItemWithNull(card);
        pickedCards.value = updatedItems;
      } else {
        if (pickedCards.value.effectiveLength < 3) {
          pickedCards.value = [...pickedCards.value]..replaceFirstNullOrAdd(card);
        } else {
          pickedCards.value = [card];
        }
      }

      if (pickedCards.value.effectiveLength == 3) {
        context.read<GameCubit>().checkSet(pickedCards.value);
      }
    }

    return Container(
      padding: EdgeInsets.all(16.hs),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 8,
                  child: CardGrid(
                    cards: context.select((GameCubit cubit) => cubit.state.board),
                    selectedCards: pickedCards.value,
                    onCardPressed: onCardPressed,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => pickedCards.value = [],
                    child: _InfoPanel(requestHint: () {
                      final setCards = context.read<GameCubit>().state.setCards..shuffle();
                      if (setCards.effectiveLength > 0) {
                        pickedCards.value = [setCards.first];
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
          _PickedCardInfo(cards: pickedCards.value)
        ],
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({
    Key? key,
    required this.requestHint,
  }) : super(key: key);

  final Function() requestHint;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final boardSetCount = context.select((GameCubit cubit) => cubit.state.setsOnBoard.length);

        return Padding(
          padding: EdgeInsets.only(left: 8.hs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _DeckLengthWidget(),
              const Spacer(),
              SizedBox(height: 50.hs),
              TypeScale.body(
                Text(
                  '$boardSetCount ${boardSetCount == 1 ? 'set' : 'sets'} on board',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.hs),
              OutlinedButton(
                child: const Text('Hint'),
                onPressed: requestHint,
              ),
              SizedBox(height: 21.hs),
              const _Draw3ExtraButton(),
              SizedBox(height: 84.hs)
            ],
          ),
        );
      },
    );
  }
}

class _DeckLengthWidget extends StatelessWidget {
  const _DeckLengthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deckLength = context.select((GameCubit cubit) => cubit.state.deck.length);
    final downscaledDeckLength = (deckLength / 9).floor();

    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: [
          SizedBox(
            width: 60.hs,
            child: EmptyCard(
              child: Text(deckLength.toString()),
            ),
          ),
          ...List.generate(
            downscaledDeckLength,
            (index) => Positioned(
              child: SizedBox(
                width: 60.hs,
                child: EmptyCard(
                  child: Text(deckLength.toString()),
                ),
              ),
              left: (index * 5).hs,
            ),
          )
        ],
      ),
    );
  }
}

class _Draw3ExtraButton extends StatelessWidget {
  const _Draw3ExtraButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final canDraw = context.select((GameCubit cubit) => cubit.state.canDraw3Extra);

        return Align(
          child: AnimatedOpacity(
            duration: 400.milliseconds,
            opacity: canDraw ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(left: 8.hs),
              child: SizedBox(
                width: 50.hs,
                child: Transform.rotate(
                  angle: 10.degrees,
                  child: Stack(
                    children: [
                      Transform.rotate(
                        origin: Offset(0, 50.hs),
                        angle: -14.degrees,
                        child: const EmptyCard(borderColor: Colors.grey),
                      ),
                      Transform.rotate(
                        origin: Offset(0, 50.hs),
                        angle: -8.degrees,
                        child: const EmptyCard(borderColor: Colors.grey),
                      ),
                      AspectRatio(
                        aspectRatio: 2 / 3,
                        child: OutlinedButton(
                          onPressed: context.read<GameCubit>().draw3Extra,
                          child: const Text('+3'),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(2),
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PickedCardInfo extends StatelessWidget {
  const _PickedCardInfo({Key? key, this.cards = const []}) : super(key: key);

  final List<SetCard?> cards;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 8,
          child: SetCardRow(
            cards: cards,
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.only(left: 8.hs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PropertyInfo(
                  count: cards.colors,
                  singularName: 'color',
                  pluralName: 'colors',
                  colorize: cards.effectiveLength == 3,
                ),
                SizedBox(height: 10.hs),
                _PropertyInfo(
                  count: cards.shapes,
                  singularName: 'shape',
                  pluralName: 'shapes',
                  colorize: cards.effectiveLength == 3,
                ),
                SizedBox(height: 10.hs),
                _PropertyInfo(
                  count: cards.textures,
                  singularName: 'texture',
                  pluralName: 'textures',
                  colorize: cards.effectiveLength == 3,
                ),
                SizedBox(height: 10.hs),
                _PropertyInfo(
                  count: cards.count,
                  singularName: 'multiplicity',
                  colorize: cards.effectiveLength == 3,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _PropertyInfo extends StatelessWidget {
  const _PropertyInfo({
    Key? key,
    required this.count,
    required this.singularName,
    this.pluralName,
    required this.colorize,
  }) : super(key: key);

  final int count;
  final String singularName;
  final String? pluralName;
  final bool colorize;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    if (colorize) {
      if (count == 2) {
        color = Colors.red;
      } else {
        color = Colors.green;
      }
    }

    return RichText(
      text: TextSpan(children: [
        TextSpan(text: '$count ', style: AppTheme.of(context).bodyMono.copyWith(color: color)),
        TextSpan(
          text: count == 1 ? singularName : pluralName ?? singularName,
          style: AppTheme.of(context).bodyMono.copyWith(color: Colors.black),
        ),
      ]),
    );
  }
}
