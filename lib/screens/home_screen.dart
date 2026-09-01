import 'package:flutter/material.dart';

import '../models/difficulty.dart';
import '../models/game_mode.dart';
import '../models/player.dart';
import '../widgets/game_choose_first_turn.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  void _startGame(
    BuildContext context, {
    required GameMode mode,
    required Difficulty difficulty,
    required Player firstPlayer,
  }) {
    Navigator.pushNamed(
      context,
      GameScreen.routeName,
      arguments: GameScreenArgs(
        mode: mode,
        difficulty: difficulty,
        firstPlayer: firstPlayer,
      ),
    );
  }

  Future<void> _chooseFirstTurnAndStartGame(
    BuildContext context, {
    required GameMode mode,
    required Difficulty difficulty,
  }) async {
    final firstPlayer = await gameChooseFirstTurn(context, mode: mode);

    if (firstPlayer == null || !context.mounted) {
      return;
    }

    _startGame(
      context,
      mode: mode,
      difficulty: difficulty,
      firstPlayer: firstPlayer,
    );
  }

  // Play vs AI na popup
  void _showAiDifficultyDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Play vs AI'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);

                  _chooseFirstTurnAndStartGame(
                    parentContext,
                    mode: GameMode.vsAi,
                    difficulty: Difficulty.easy,
                  );
                },
                child: const Text('Easy'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);

                  _chooseFirstTurnAndStartGame(
                    parentContext,
                    mode: GameMode.vsAi,
                    difficulty: Difficulty.hard,
                  );
                },
                child: const Text('Hard'),
              ),
            ],
          ),
        );
      },
    );
  }

  //Settings na popup
  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const SettingsScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tic-Tac-Toe')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Main Menu',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  _showAiDifficultyDialog(context);
                },
                child: const Text('Play vs AI'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  _chooseFirstTurnAndStartGame(
                    context,
                    mode: GameMode.localMultiplayer,
                    difficulty: Difficulty.easy,
                  );
                },
                child: const Text('Play with Friend'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  _showSettingsDialog(context);
                },
                child: const Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
