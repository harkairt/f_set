import 'package:f_set/presentation/set_card_row.dart';
import 'package:f_set/presentation/set_card_widget.dart';
import 'package:f_set/set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CardGrid extends HookWidget {
  const CardGrid({
    Key? key,
    required this.cards,
    required this.selectedCards,
    required this.onCardSelected,
    this.hideCards = const <SetCard>[],
  }) : super(key: key);

  final List<SetCard?> cards;
  final List<SetCard?> selectedCards;
  final List<SetCard>? hideCards;
  final Function(SetCard) onCardSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        clipBehavior: Clip.none,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        shrinkWrap: true,
        childAspectRatio: 2 / 3,
        crossAxisCount: 3,
        children: List.generate(
          cards.length,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: Duration(milliseconds: 250),
              delay: Duration(milliseconds: 100),
              columnCount: 3,
              child: CardAppearAnimation(
                child: Builder(
                  builder: (context) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onCardSelected(cards[index]!);
                      },
                      child: Builder(
                        builder: (context) {
                          final card = cards[index];

                          if (card == null) {
                            return AspectRatio(
                              aspectRatio: 2.5 / 3.5,
                              child: Container(
                                decoration: const BoxDecoration(color: Colors.transparent),
                              ),
                            );
                          }

                          return SetCardWidget(
                            card: card,
                            duration: Duration(milliseconds: 100),
                            highlight: selectedCards.contains(cards[index]!),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
