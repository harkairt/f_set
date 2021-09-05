import 'package:f_set/presentation/card_grid.dart';
import 'package:f_set/presentation/set_card_widget.dart';
import 'package:f_set/set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SetCardRow extends StatelessWidget {
  const SetCardRow({
    Key? key,
    required this.cards,
  }) : super(key: key);

  final List<SetCard?> cards;

  @override
  Widget build(BuildContext context) {
    assert(cards.length <= 3, 'More than 3 cards were given.');

    return AnimationLimiter(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: AnimationConfiguration.toStaggeredList(
          childAnimationBuilder: (child) => Flexible(
            child: CardAppearAnimation(child: child),
          ),
          children: List.generate(
            3,
            (index) => Builder(
              builder: (context) {
                if (cards.length <= index || cards[index] == null) {
                  return const EmptyCard();
                }

                return SetCardWidget(
                  card: cards[index]!,
                  highlight: cards.isSet,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
