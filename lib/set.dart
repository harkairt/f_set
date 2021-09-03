import 'package:trotter/trotter.dart';
import 'dart:math';
import 'package:collection/collection.dart';

enum ShapeType { diamond, squiggly, pill }
enum TextureType { outline, banded, filled }
enum ColorType { red, green, blue }

class SetCard {
  final TextureType texture;
  final ShapeType shape;
  final ColorType color;
  final int count;

  SetCard(this.texture, this.shape, this.color, this.count);
}

extension ListExtensions<T> on List<T?> {
  void replaceFirstNullOrAdd(T item) {
    final index = indexWhere((element) => element == null);
    if (index > -1) {
      removeAt(index);
      insert(index, item);
    } else {
      add(item);
    }
  }

  void replaceItemWith(T item, T? newItem) {
    final index = indexOf(item);
    if (index > -1) {
      removeAt(index);
      insert(index, newItem);
    }
  }

  void replaceItemWithNull(T item) => this.replaceItemWith(item, null);

  List<T> draw(int count) {
    final result = take(count).cast<T>().toList();
    safeRemoveRange(0, count);
    return result;
  }

  void safeRemoveRange(int start, int end) {
    removeRange(start, min(length, end));
  }

  int get effectiveLength => where((e) => e != null).length;
}

extension NullableSetCardIterableExtensions on Iterable<SetCard?> {
  bool get isSet {
    if (this.length != 3 || this.any((element) => element == null)) {
      return false;
    }

    final nonNullable = this.cast<SetCard>();
    return nonNullable.isSet;
  }

  List<List<SetCard>> get sets {
    final cards = this.where((element) => element != null).toList().cast<SetCard>();
    return cards.sets;
  }

  int get colors {
    final cards = this.where((element) => element != null).toList().cast<SetCard>();
    return cards.toList().groupListsBy((i) => i.color).length;
  }

  int get shapes {
    final cards = this.where((element) => element != null).toList().cast<SetCard>();
    return cards.toList().groupListsBy((i) => i.shape).length;
  }

  int get count {
    final cards = this.where((element) => element != null).toList().cast<SetCard>();
    return cards.toList().groupListsBy((i) => i.count).length;
  }

  int get textures {
    final cards = this.where((element) => element != null).toList().cast<SetCard>();
    return cards.toList().groupListsBy((i) => i.texture).length;
  }

  int get setCount => sets.length;
}

extension SetCardIterableExtensions on Iterable<SetCard> {
  bool get isSet {
    if (this.length != 3) {
      return false;
    }

    Set shapes = Set<ShapeType>();
    Set textures = Set<TextureType>();
    Set colors = Set<ColorType>();
    Set counts = Set<int>();

    for (SetCard c in this) {
      shapes.add(c.shape);
      textures.add(c.texture);
      colors.add(c.color);
      counts.add(c.count);
    }

    return (shapes.length == 1 || shapes.length == 3) &&
        (textures.length == 1 || textures.length == 3) &&
        (colors.length == 1 || colors.length == 3) &&
        (counts.length == 1 || counts.length == 3);
  }

  List<List<SetCard>> get sets {
    List<List<SetCard>> result = [];

    final combinations = Combinations(3, this.toList());
    for (final possibleSet in combinations()) {
      final isSet = possibleSet.isSet;
      if (isSet) {
        result.add(possibleSet);
      }
    }

    return result;
  }

  int get colors {
    return toList().groupListsBy((i) => i.color).length;
  }

  int get shapes {
    return toList().groupListsBy((i) => i.shape).length;
  }

  int get count {
    return toList().groupListsBy((i) => i.count).length;
  }

  int get textures {
    return toList().groupListsBy((i) => i.texture).length;
  }

  int get setCount => sets.length;
}

void getAllSets(int index, List<SetCard> currentSet, List<SetCard> cards, List<List<SetCard>> allSets) {
  for (int i = index; i < cards.length; i++) {
    List<SetCard> potentialSet = currentSet + [cards[i]];
    if (potentialSet.length == 3) {
      if (potentialSet.isSet) {
        allSets.add(potentialSet);
      }
    } else {
      getAllSets(i + 1, potentialSet, cards, allSets);
    }
  }
}

bool doSetsOverlap(List<List<SetCard>> sets, List<SetCard> candidateSet) {
  List<SetCard> allCards = sets.expand((c) => c).toList() + candidateSet;
  List<List<SetCard>> possibleSets = [];
  getAllSets(0, [], allCards, possibleSets);
  return !(possibleSets.length == sets.length + 1);
}

void getNonOverlappingSets(
  List<SetCard> currentSet,
  int desiredSets,
  List<SetCard> allCards,
  List<List<SetCard>> results,
) {
  if (results.length == desiredSets) {
    return;
  }
  for (SetCard card in allCards) {
    if (!currentSet.contains(card)) {
      List<SetCard> potentialSet = currentSet + [card];
      if (potentialSet.length == 3) {
        if (potentialSet.isSet && !doSetsOverlap(results, potentialSet)) {
          results.add(potentialSet);
        }
      } else {
        getNonOverlappingSets(potentialSet, desiredSets, allCards, results);
      }
    }
  }
}

List<SetCard> newDeck() {
  List<SetCard> cards = [];
  for (ShapeType shape in ShapeType.values) {
    for (TextureType texture in TextureType.values) {
      for (ColorType color in ColorType.values) {
        for (int count = 1; count <= 3; count++) {
          cards.add(SetCard(texture, shape, color, count));
        }
      }
    }
  }
  return cards;
}
