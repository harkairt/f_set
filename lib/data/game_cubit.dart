import 'package:bloc/bloc.dart';
import 'package:f_set/set.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_cubit.freezed.dart';

@freezed
class GameState with _$GameState {
  const GameState._();
  const factory GameState({
    @Default(<SetCard>[]) List<SetCard> deck,
    @Default(<SetCard?>[]) List<SetCard?> board,
    @Default(<List<SetCard>>[]) List<List<SetCard>> foundSets,
  }) = _SetCubitState;

  List<List<SetCard>> get setsOnBoard => board.sets;
  List<SetCard> get relevantCards => setsOnBoard.flattened.toList();
  List<SetCard>? get lastFoundSetOrNull => foundSets.lastOrNull;
  bool get canDraw3Extra => board.effectiveLength == 12 && deck.length >= 3;
}

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState());

  void initializeGame() {
    final deck = newDeck()..shuffle();
    final board = deck.draw(12)..shuffle();

    emit(state.copyWith(
      deck: deck,
      board: board,
      foundSets: [],
    ));
  }

  void draw3Extra() {
    if (!state.canDraw3Extra) {
      return;
    }

    final newDeck = [...state.deck];
    final extraCards = newDeck.draw(3);

    emit(state.copyWith(
      deck: newDeck,
      board: [...state.board, ...extraCards],
    ));
  }

  void checkSet(List<SetCard?> cards) {
    if (cards.isSet) {
      _handleSet(cards.cast<SetCard>());
    }
  }

  void _handleSet(List<SetCard> setCards) {
    final newDeck = [...state.deck];
    final newBoard = [...state.board];

    final had15CardsOnBoard = newBoard.effectiveLength == 15;

    setCards.forEach((setCard) {
      if (had15CardsOnBoard) {
        newBoard.replaceItemWithNull(setCard);
      } else {
        final newCard = newDeck.draw(1).firstOrNull;
        newBoard.replaceItemWith(setCard, newCard);
      }
    });

    newBoard.removeWhere((card) => card == null);

    emit(state.copyWith(
      deck: newDeck,
      board: newBoard,
      foundSets: [...state.foundSets, setCards],
    ));
  }
}
