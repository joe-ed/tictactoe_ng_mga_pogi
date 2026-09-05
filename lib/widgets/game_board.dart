import 'package:flutter/material.dart';
import '../models/player.dart';
import 'game_cell.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    super.key,
    required this.board,
    required this.onCellTap,
  });

  final List<Player?> board;
  final Function(int index) onCellTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GameCell(
            player: board[index],
            onTap: () => onCellTap(index),
          );
        },
      ),
    );
  }
}
