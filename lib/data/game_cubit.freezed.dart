// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'game_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GameStateTearOff {
  const _$GameStateTearOff();

  _SetCubitState call(
      {List<SetCard> deck = const <SetCard>[],
      List<SetCard?> board = const <SetCard?>[],
      List<SetCard?> pickedCards = const <SetCard?>[],
      List<List<SetCard>> foundSets = const <List<SetCard>>[]}) {
    return _SetCubitState(
      deck: deck,
      board: board,
      pickedCards: pickedCards,
      foundSets: foundSets,
    );
  }
}

/// @nodoc
const $GameState = _$GameStateTearOff();

/// @nodoc
mixin _$GameState {
  List<SetCard> get deck => throw _privateConstructorUsedError;
  List<SetCard?> get board => throw _privateConstructorUsedError;
  List<SetCard?> get pickedCards => throw _privateConstructorUsedError;
  List<List<SetCard>> get foundSets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res>;
  $Res call(
      {List<SetCard> deck,
      List<SetCard?> board,
      List<SetCard?> pickedCards,
      List<List<SetCard>> foundSets});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res> implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  final GameState _value;
  // ignore: unused_field
  final $Res Function(GameState) _then;

  @override
  $Res call({
    Object? deck = freezed,
    Object? board = freezed,
    Object? pickedCards = freezed,
    Object? foundSets = freezed,
  }) {
    return _then(_value.copyWith(
      deck: deck == freezed
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as List<SetCard>,
      board: board == freezed
          ? _value.board
          : board // ignore: cast_nullable_to_non_nullable
              as List<SetCard?>,
      pickedCards: pickedCards == freezed
          ? _value.pickedCards
          : pickedCards // ignore: cast_nullable_to_non_nullable
              as List<SetCard?>,
      foundSets: foundSets == freezed
          ? _value.foundSets
          : foundSets // ignore: cast_nullable_to_non_nullable
              as List<List<SetCard>>,
    ));
  }
}

/// @nodoc
abstract class _$SetCubitStateCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$SetCubitStateCopyWith(
          _SetCubitState value, $Res Function(_SetCubitState) then) =
      __$SetCubitStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<SetCard> deck,
      List<SetCard?> board,
      List<SetCard?> pickedCards,
      List<List<SetCard>> foundSets});
}

/// @nodoc
class __$SetCubitStateCopyWithImpl<$Res> extends _$GameStateCopyWithImpl<$Res>
    implements _$SetCubitStateCopyWith<$Res> {
  __$SetCubitStateCopyWithImpl(
      _SetCubitState _value, $Res Function(_SetCubitState) _then)
      : super(_value, (v) => _then(v as _SetCubitState));

  @override
  _SetCubitState get _value => super._value as _SetCubitState;

  @override
  $Res call({
    Object? deck = freezed,
    Object? board = freezed,
    Object? pickedCards = freezed,
    Object? foundSets = freezed,
  }) {
    return _then(_SetCubitState(
      deck: deck == freezed
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as List<SetCard>,
      board: board == freezed
          ? _value.board
          : board // ignore: cast_nullable_to_non_nullable
              as List<SetCard?>,
      pickedCards: pickedCards == freezed
          ? _value.pickedCards
          : pickedCards // ignore: cast_nullable_to_non_nullable
              as List<SetCard?>,
      foundSets: foundSets == freezed
          ? _value.foundSets
          : foundSets // ignore: cast_nullable_to_non_nullable
              as List<List<SetCard>>,
    ));
  }
}

/// @nodoc

class _$_SetCubitState extends _SetCubitState {
  const _$_SetCubitState(
      {this.deck = const <SetCard>[],
      this.board = const <SetCard?>[],
      this.pickedCards = const <SetCard?>[],
      this.foundSets = const <List<SetCard>>[]})
      : super._();

  @JsonKey(defaultValue: const <SetCard>[])
  @override
  final List<SetCard> deck;
  @JsonKey(defaultValue: const <SetCard?>[])
  @override
  final List<SetCard?> board;
  @JsonKey(defaultValue: const <SetCard?>[])
  @override
  final List<SetCard?> pickedCards;
  @JsonKey(defaultValue: const <List<SetCard>>[])
  @override
  final List<List<SetCard>> foundSets;

  @override
  String toString() {
    return 'GameState(deck: $deck, board: $board, pickedCards: $pickedCards, foundSets: $foundSets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetCubitState &&
            (identical(other.deck, deck) ||
                const DeepCollectionEquality().equals(other.deck, deck)) &&
            (identical(other.board, board) ||
                const DeepCollectionEquality().equals(other.board, board)) &&
            (identical(other.pickedCards, pickedCards) ||
                const DeepCollectionEquality()
                    .equals(other.pickedCards, pickedCards)) &&
            (identical(other.foundSets, foundSets) ||
                const DeepCollectionEquality()
                    .equals(other.foundSets, foundSets)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(deck) ^
      const DeepCollectionEquality().hash(board) ^
      const DeepCollectionEquality().hash(pickedCards) ^
      const DeepCollectionEquality().hash(foundSets);

  @JsonKey(ignore: true)
  @override
  _$SetCubitStateCopyWith<_SetCubitState> get copyWith =>
      __$SetCubitStateCopyWithImpl<_SetCubitState>(this, _$identity);
}

abstract class _SetCubitState extends GameState {
  const factory _SetCubitState(
      {List<SetCard> deck,
      List<SetCard?> board,
      List<SetCard?> pickedCards,
      List<List<SetCard>> foundSets}) = _$_SetCubitState;
  const _SetCubitState._() : super._();

  @override
  List<SetCard> get deck => throw _privateConstructorUsedError;
  @override
  List<SetCard?> get board => throw _privateConstructorUsedError;
  @override
  List<SetCard?> get pickedCards => throw _privateConstructorUsedError;
  @override
  List<List<SetCard>> get foundSets => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SetCubitStateCopyWith<_SetCubitState> get copyWith =>
      throw _privateConstructorUsedError;
}
