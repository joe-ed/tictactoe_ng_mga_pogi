import 'package:flutter/material.dart';

import '../models/difficulty.dart';
import '../models/game_mode.dart';
import '../models/player.dart';

class GameScreenArgs {
  const GameScreenArgs({
    required this.mode,
    required this.difficulty,
    required this.firstPlayer,
  });

  final GameMode mode;
  final Difficulty difficulty;
  final Player firstPlayer;
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.args});

  static const String routeName = '/game';

  final GameScreenArgs args;

  String get _title {
    if (args.mode == GameMode.localMultiplayer) {
      return 'Local 1v1';
    }

    return args.difficulty == Difficulty.easy
        ? 'Human vs AI - Easy'
        : 'Human vs AI - Hard';
  }

  String get _firstTurnText {
    return args.firstPlayer == Player.x ? 'First turn: X' : 'First turn: O';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(_firstTurnText),
              const SizedBox(height: 16),
              const Text(
                'Game screen placeholder. The board and rules will be added next.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
