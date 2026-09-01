import 'package:flutter/material.dart';

import '../models/game_mode.dart';
import '../models/player.dart';

Future<Player?> gameChooseFirstTurn(
  BuildContext context, {
  required GameMode mode,
}) {
  final subtitle = mode == GameMode.vsAi
      ? 'Choose who takes the first move against the AI.'
      : 'Choose who takes the first move in local 1v1.';

  return showDialog<Player>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Choose First Turn'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(subtitle),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, Player.x);
              },
              child: const Text('X goes first'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, Player.o);
              },
              child: const Text('O goes first'),
            ),
          ],
        ),
      );
    },
  );
}
