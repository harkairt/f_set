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
    @Default(<SetCard?>[]) List<SetCard?> pickedCards,
    @Default(<List<SetCard>>[]) List<List<SetCard>> foundSets,
  }) = _SetCubitState;

  List<List<SetCard>> get setsOnBoard => board.sets;
  List<SetCard> get relevantCards => setsOnBoard.flattened.toList();
  int get boardSetCount => board.setCount;
  List<SetCard>? get lastFoundSetOrNull => foundSets.lastOrNull;
}

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState());

  void initialize() {
    final deck = newDeck()..safeRemoveRange(0, 18);
    final board = deck.draw(12)..shuffle();

    emit(state.copyWith(
      deck: deck,
      board: board,
    ));
  }

  void updatePickedCards(List<SetCard?> cards) {
    emit(state.copyWith(pickedCards: cards));
  }

  void checkSet() {
    if (state.pickedCards.isSet) {
      handleSet(state.pickedCards.cast<SetCard>());
    }
  }

  void handleSet(List<SetCard> setCards) {
    final newDeck = [...state.deck];
    final newBoard = [...state.board];

    print('_____ ${setCards.length}');
    setCards.forEach((setCard) {
      final newCard = newDeck.draw(1).firstOrNull;
      newBoard.replaceItemWith(setCard, newCard);
    });

    emit(state.copyWith(
      deck: newDeck,
      board: newBoard,
      foundSets: [...state.foundSets, setCards],
      // pickedCards: []
    ));
  }
}
