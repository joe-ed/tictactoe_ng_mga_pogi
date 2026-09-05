import 'package:flutter/material.dart';

import '../game/easy_ai.dart';
import '../game/game_logic.dart';
import '../game/hard_ai.dart';
import '../models/difficulty.dart';
import '../models/game_mode.dart';
import '../models/player.dart';
import '../widgets/game_board.dart';
import '../widgets/game_result_dialog.dart';

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

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.args});

  static const String routeName = '/game';

  final GameScreenArgs args;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late TicTacToeGame _game;

  @override
  void initState() {
    super.initState();
    _game = TicTacToeGame(firstPlayer: widget.args.firstPlayer);

    // If AI goes first
    if (widget.args.mode == GameMode.vsAi &&
        _game.currentPlayer != Player.x) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _triggerAiMove();
      });
    }
  }

  void _onCellTap(int index) {
    if (_game.winner != null || _game.isDraw || _game.board[index] != null) {
      return;
    }

    setState(() {
      _game.makeMove(index);
    });

    if (_game.winner != null || _game.isDraw) {
      _showResult();
      return;
    }

    if (widget.args.mode == GameMode.vsAi) {
      _triggerAiMove();
    }
  }

  Future<void> _triggerAiMove() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    int? move;
    if (widget.args.difficulty == Difficulty.easy) {
      move = getEasyAiMove(_game);
    } else {
      move = getHardAiMove(_game);
    }

    if (move != null) {
      setState(() {
        _game.makeMove(move!);
      });

      if (_game.winner != null || _game.isDraw) {
        _showResult();
      }
    }
  }

  void _showResult() {
    showGameResultDialog(
      context,
      winner: _game.winner,
      isDraw: _game.isDraw,
      onPlayAgain: _resetGame,
    );
  }

  void _resetGame() {
    setState(() {
      _game.reset();
    });

    if (widget.args.mode == GameMode.vsAi &&
        _game.currentPlayer != Player.x) {
      _triggerAiMove();
    }
  }

  String get _title {
    if (widget.args.mode == GameMode.localMultiplayer) {
      return 'Local 1v1';
    }

    return widget.args.difficulty == Difficulty.easy
        ? 'Human vs AI - Easy'
        : 'Human vs AI - Hard';
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
                _game.winner != null
                    ? '${_game.winner == Player.x ? 'X' : 'O'} Wins!'
                    : _game.isDraw
                        ? "It's a Draw!"
                        : "Turn: ${_game.currentPlayer == Player.x ? 'X' : 'O'}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              GameBoard(
                board: _game.board,
                onCellTap: _onCellTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
