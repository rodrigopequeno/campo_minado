import 'package:campo_minado/models/field.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Field', () {
    test('Open field with explosion', () {
      Field c = Field(row: 0, column: 0);
      c.undermine();

      expect(c.openUp, throwsException);
    });

    test('Open field without explosion', () {
      Field c = Field(row: 0, column: 0);
      c.openUp();

      expect(c.open, isTrue);
    });

    test('Add not neighbor', () {
      Field c1 = Field(row: 0, column: 0);
      Field c2 = Field(row: 1, column: 3);
      c1.addNeighbor(c2);

      expect(c1.neighbors.isEmpty, isTrue);
    });

    test('Add neighbor', () {
      Field c1 = Field(row: 3, column: 3);
      Field c2 = Field(row: 3, column: 4);
      Field c3 = Field(row: 2, column: 2);
      Field c4 = Field(row: 4, column: 4);

      c1.addNeighbor(c2);
      c1.addNeighbor(c3);
      c1.addNeighbor(c4);

      expect(c1.neighbors.length, 3);
    });

    test('Mines in the neighborhood', () {
      Field c1 = Field(row: 3, column: 3);
      Field c2 = Field(row: 3, column: 4);
      c2.undermine();
      Field c3 = Field(row: 2, column: 2);
      Field c4 = Field(row: 4, column: 4);
      c4.undermine();

      c1.addNeighbor(c2);
      c1.addNeighbor(c3);
      c1.addNeighbor(c4);

      expect(c1.numberMinesNeighborhood, 2);
    });
  });
}
