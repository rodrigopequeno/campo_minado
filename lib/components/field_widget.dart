import 'package:campo_minado/models/field.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    Key key,
    @required this.field,
    @required this.onOpen,
    @required this.onToggleMarking,
  }) : super(key: key);

  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onToggleMarking;

  _getContent() {
    int numberMines = field.numberMinesNeighborhood;
    if (field.open && field.mine && field.exploded) {
      return Image.asset('assets/images/bomb_0.jpeg');
    } else if (field.open && field.mine) {
      return Image.asset('assets/images/bomb_1.jpeg');
    } else if (field.open) {
      return Image.asset('assets/images/open_$numberMines.jpeg');
    } else if (field.marked) {
      return Image.asset('assets/images/flag.jpeg');
    } else
      return Image.asset('assets/images/closed.jpeg');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onToggleMarking(field),
      child: _getContent(),
    );
  }
}
