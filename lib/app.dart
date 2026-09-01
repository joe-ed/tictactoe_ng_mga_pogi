import 'package:flutter/material.dart';

import 'models/difficulty.dart';
import 'models/game_mode.dart';
import 'models/player.dart';
import 'screens/game_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'theme.dart';

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: (settings) {
        if (settings.name == GameScreen.routeName) {
          final args = settings.arguments;

          if (args is GameScreenArgs) {
            return MaterialPageRoute<void>(
              builder: (_) => GameScreen(args: args),
            );
          }

          return MaterialPageRoute<void>(
            builder: (_) => const GameScreen(
              args: GameScreenArgs(
                mode: GameMode.localMultiplayer,
                difficulty: Difficulty.easy,
                firstPlayer: Player.x,
              ),
            ),
          );
        }

        if (settings.name == SettingsScreen.routeName) {
          return MaterialPageRoute<void>(
            builder: (_) => const SettingsScreen(),
          );
        }

        return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
      },
    );
  }
}
