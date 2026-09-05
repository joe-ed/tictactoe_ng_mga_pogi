import '../models/player.dart';

class TicTacToeGame {
  TicTacToeGame({required this.firstPlayer}) {
    board = List.filled(9, null);
    currentPlayer = firstPlayer;
  }

  final Player firstPlayer;
  late List<Player?> board;
  late Player currentPlayer;
  Player? winner;
  bool isDraw = false;

  bool makeMove(int index) {
    if (index < 0 || index >= 9 || board[index] != null || winner != null || isDraw) {
      return false;
    }

    board[index] = currentPlayer;
    _checkGameState();

    if (winner == null && !isDraw) {
      currentPlayer = (currentPlayer == Player.x) ? Player.o : Player.x;
    }

    return true;
  }

  void _checkGameState() {
    const winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Cols
      [0, 4, 8], [2, 4, 6],             // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] != null &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[0]] == board[pattern[2]]) {
        winner = board[pattern[0]];
        return;
      }
    }

    if (!board.contains(null)) {
      isDraw = true;
    }
  }

  void reset() {
    board = List.filled(9, null);
    currentPlayer = firstPlayer;
    winner = null;
    isDraw = false;
  }

  TicTacToeGame copy() {
    final copy = TicTacToeGame(firstPlayer: firstPlayer);
    copy.board = List.from(board);
    copy.currentPlayer = currentPlayer;
    copy.winner = winner;
    copy.isDraw = isDraw;
    return copy;
  }
}
