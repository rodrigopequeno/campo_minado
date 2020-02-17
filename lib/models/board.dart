import 'dart:math';

import 'package:flutter/foundation.dart';

import 'field.dart';

class Board {
  final int rows;
  final int columns;
  final int numberBombs;

  final List<Field> _fields = [];

  Board({
    @required this.rows,
    @required this.columns,
    @required this.numberBombs,
  }) {
    _createFields();
    _relateNeighbors();
    _drawMines();
  }

  List<Field> get fields => _fields;

  void revealBombs() => _fields.forEach((c) => c.revealBomb());

  bool get resolved => _fields.every((c) => c.resolved);

  void reboot() {
    _fields.forEach((c) => c.reset());
    _drawMines();
  }

  void _createFields() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(row: r, column: c));
      }
    }
  }

  void _relateNeighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void _drawMines() {
    int drawn = 0;

    if (numberBombs > rows * columns) {
      return;
    }
    while (drawn < numberBombs) {
      int index = Random().nextInt(_fields.length);
      if (!_fields[index].mine) {
        drawn++;
        _fields[index].undermine();
      }
    }
  }
}
