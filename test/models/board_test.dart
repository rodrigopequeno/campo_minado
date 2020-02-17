import 'package:campo_minado/models/board.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Board', () {
    test('Win game', () {
      Board board = Board(rows: 2, columns: 2, numberBombs: 0);
      board.fields[0].undermine();
      board.fields[3].undermine();

      board.fields[0].changeMarkup();
      board.fields[1].openUp();
      board.fields[2].openUp();
      board.fields[3].changeMarkup();

      expect(board.resolved, isTrue);
    });
  });
}
