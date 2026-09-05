import '../models/player.dart';
import 'game_logic.dart';

int? getHardAiMove(TicTacToeGame game) {
  int bestScore = -1000;
  int? move;

  final aiPlayer = game.currentPlayer;
  final humanPlayer = (aiPlayer == Player.x) ? Player.o : Player.x;

  for (int i = 0; i < 9; i++) {
    if (game.board[i] == null) {
      game.board[i] = aiPlayer;
      int score = _minimax(game, 0, false, aiPlayer, humanPlayer);
      game.board[i] = null;
      if (score > bestScore) {
        bestScore = score;
        move = i;
      }
    }
  }
  return move;
}

int _minimax(TicTacToeGame game, int depth, bool isMaximizing, Player aiPlayer, Player humanPlayer) {
  final result = _checkWinnerForMinimax(game.board);
  if (result == aiPlayer) return 10 - depth;
  if (result == humanPlayer) return depth - 10;
  if (!game.board.contains(null)) return 0;

  if (isMaximizing) {
    int bestScore = -1000;
    for (int i = 0; i < 9; i++) {
      if (game.board[i] == null) {
        game.board[i] = aiPlayer;
        int score = _minimax(game, depth + 1, false, aiPlayer, humanPlayer);
        game.board[i] = null;
        if (score > bestScore) bestScore = score;
      }
    }
    return bestScore;
  } else {
    int bestScore = 1000;
    for (int i = 0; i < 9; i++) {
      if (game.board[i] == null) {
        game.board[i] = humanPlayer;
        int score = _minimax(game, depth + 1, true, aiPlayer, humanPlayer);
        game.board[i] = null;
        if (score < bestScore) bestScore = score;
      }
    }
    return bestScore;
  }
}

Player? _checkWinnerForMinimax(List<Player?> board) {
  const winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6],
  ];

  for (var pattern in winPatterns) {
    if (board[pattern[0]] != null &&
        board[pattern[0]] == board[pattern[1]] &&
        board[pattern[0]] == board[pattern[2]]) {
      return board[pattern[0]];
    }
  }
  return null;
}
