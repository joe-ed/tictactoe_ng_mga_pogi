import 'package:flutter/material.dart';
import '../models/player.dart';

class GameCell extends StatelessWidget {
  const GameCell({
    super.key,
    required this.player,
    required this.onTap,
  });

  final Player? player;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Center(
          child: Text(
            player == null ? '' : (player == Player.x ? 'X' : 'O'),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: player == Player.x ? Colors.blue : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
