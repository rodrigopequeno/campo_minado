import 'package:flutter/foundation.dart';
import 'explosion_exception.dart';

class Field {
  final int row;
  final int column;
  final List<Field> neighbors = [];

  bool _open = false;
  bool _marked = false;
  bool _mine = false;
  bool _exploded = false;

  Field({
    @required this.row,
    @required this.column,
  });

  bool get mine => _mine;

  bool get exploded => _exploded;

  bool get marked => _marked;

  bool get open => _open;

  bool get resolved => _mine && _marked || !mine && open;

  bool get safeNeighborhood => neighbors.every((v) => !v.mine);

  int get numberMinesNeighborhood => neighbors.where((v) => v.mine).length;

  void addNeighbor(Field neighbor) {
    final deltaRow = (row - neighbor.row).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaRow == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaRow <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void openUp() {
    if (_open) {
      return;
    }
    _open = true;
    if (_mine) {
      _exploded = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      neighbors.forEach((v) => v.openUp());
    }
  }

  void revealBomb() {
    if (_mine) {
      _open = true;
    }
  }

  void undermine() {
    _mine = true;
  }

  void changeMarkup() {
    _marked = !_marked;
  }

  void reset() {
    _open = false;
    _marked = false;
    _mine = false;
    _exploded = false;
  }
}
