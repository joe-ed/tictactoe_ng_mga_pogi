import 'package:flutter/material.dart';
import '../models/player.dart';

Future<void> showGameResultDialog(
  BuildContext context, {
  required Player? winner,
  required bool isDraw,
  required VoidCallback onPlayAgain,
}) {
  String title;
  if (isDraw) {
    title = "It's a Draw!";
  } else {
    title = winner == Player.x ? 'X Wins!' : 'O Wins!';
  }

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Home'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onPlayAgain();
            },
            child: const Text('Play Again'),
          ),
        ],
      );
    },
  );
}
