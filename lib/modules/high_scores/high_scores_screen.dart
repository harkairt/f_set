import 'package:f_set/modules/high_scores/data/high_scores_cubit.dart';
import 'package:f_set/presentation/hero.dart';
import 'package:f_set/presentation/theme/scale.dart';
import 'package:f_set/utils/type_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:f_set/utils/extensions.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HighScoresScreen extends HookWidget {
  const HighScoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final highScores = context.select((HighScoresCubit cubit) => cubit.state);

    useEffect(() {
      context.read<HighScoresCubit>().fetchHighScores();
    }, []);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 32.hs),
            const MaterialHero(
              tag: 'yes',
              child: TypeScale.h3(
                Text('High scores'),
              ),
            ),
            SizedBox(height: 32.hs),
            highScores.when(
              unavailable: () => const SizedBox(),
              fetching: (oldValue) => const Center(child: CircularProgressIndicator()),
              available: (highScores) {
                return AnimationLimiter(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.hs),
                    shrinkWrap: true,
                    itemCount: highScores.length,
                    itemBuilder: (context, index) {
                      final score = highScores[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: FadeInAnimation(
                          child: ListTile(
                            title: Text(score.name),
                            subtitle: Text(score.time.formatDurationSimple()),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              error: (error) => Text(error?.message ?? 'Oops'),
            )
          ],
        ),
      ),
    );
  }
}
