import 'package:auto_route/auto_route.dart';
import 'package:f_set/presentation/screens/game_screen.dart';
import 'package:f_set/presentation/screens/high_scores_screen.dart';
import 'package:f_set/presentation/screens/instructions_screen.dart';
import 'package:f_set/presentation/screens/menu_screen.dart';

late StackRouter stackRouter;

@CustomAutoRouter(
  transitionsBuilder: TransitionsBuilders.fadeIn,
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(initial: true, page: MenuScreen),
    AutoRoute<void>(page: InstructionsScreen),
    AutoRoute<void>(page: GameScreen),
    AutoRoute<void>(page: HighScoresScreen),
  ],
)
class $AppAutoRouter {}
