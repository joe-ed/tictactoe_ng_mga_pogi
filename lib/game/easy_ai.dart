import 'dart:math';
import 'game_logic.dart';

int? getEasyAiMove(TicTacToeGame game) {
  final availableMoves = <int>[];
  for (int i = 0; i < game.board.length; i++) {
    if (game.board[i] == null) {
      availableMoves.add(i);
    }
  }

  if (availableMoves.isEmpty) return null;

  return availableMoves[Random().nextInt(availableMoves.length)];
}
