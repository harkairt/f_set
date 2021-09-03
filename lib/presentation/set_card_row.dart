import 'package:f_set/data/game_cubit.dart';
import 'package:f_set/presentation/set_card_widget.dart';
import 'package:f_set/set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SetCardRow extends StatelessWidget {
  const SetCardRow({
    Key? key,
    required this.cards,
    this.isSet = false,
  }) : super(key: key);

  final List<SetCard?> cards;
  final bool isSet;

  @override
  Widget build(BuildContext context) {
    assert(cards.length <= 3, 'More than 3 cards were given.');

    return AnimationLimiter(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: AnimationConfiguration.toStaggeredList(
          childAnimationBuilder: (child) => Flexible(
            child: CardAppearAnimation(
              child: child,
            ),
          ),
          children: List.generate(
            3,
            (index) => Builder(
              builder: (context) {
                if (cards.length <= index || cards[index] == null) {
                  return AspectRatio(
                    aspectRatio: 2.5 / 3.5,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.transparent),
                    ),
                  );
                }

                return SetCardWidget(
                  card: cards[index]!,
                  highlight: isSet,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CardAppearAnimation extends StatelessWidget {
  const CardAppearAnimation({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScaleAnimation(
      scale: 0.95,
      duration: Duration(milliseconds: 750),
      curve: Curves.easeOutCubic,
      child: FadeInAnimation(
        curve: Curves.easeOutCubic,
        child: child,
      ),
    );
  }
}
