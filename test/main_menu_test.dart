import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe_ng_mga_pogi/app.dart';

void main() {
  testWidgets('main menu shows the basic navigation options', (tester) async {
    await tester.pumpWidget(const TicTacToeApp());

    expect(find.text('Main Menu'), findsOneWidget);
    expect(find.text('Play vs AI'), findsOneWidget);
    expect(find.text('Play with Friend'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('main menu opens the easy AI placeholder game screen', (
    tester,
  ) async {
    await tester.pumpWidget(const TicTacToeApp());

    await tester.tap(find.text('Play vs AI'));
    await tester.pumpAndSettle();

    expect(find.text('Easy'), findsOneWidget);
    expect(find.text('Hard'), findsOneWidget);

    await tester.tap(find.text('Easy'));
    await tester.pumpAndSettle();

    expect(find.text('Choose First Turn'), findsOneWidget);

    await tester.tap(find.text('X goes first'));
    await tester.pumpAndSettle();

    expect(find.text('Human vs AI - Easy'), findsWidgets);
    expect(find.text('First turn: X'), findsOneWidget);
  });

  testWidgets('main menu asks who goes first for local multiplayer', (
    tester,
  ) async {
    await tester.pumpWidget(const TicTacToeApp());

    await tester.tap(find.text('Play with Friend'));
    await tester.pumpAndSettle();

    expect(find.text('Choose First Turn'), findsOneWidget);

    await tester.tap(find.text('O goes first'));
    await tester.pumpAndSettle();

    expect(find.text('Local 1v1'), findsWidgets);
    expect(find.text('First turn: O'), findsOneWidget);
  });

  testWidgets('main menu opens the settings placeholder screen', (
    tester,
  ) async {
    await tester.pumpWidget(const TicTacToeApp());

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Theme'), findsOneWidget);
    expect(find.text('Sound Effects'), findsOneWidget);
    expect(find.text('Default AI Difficulty'), findsOneWidget);
  });
}
