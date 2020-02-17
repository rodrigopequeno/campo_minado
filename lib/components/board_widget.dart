import 'package:campo_minado/components/field_widget.dart';
import 'package:campo_minado/models/board.dart';
import 'package:campo_minado/models/field.dart';
import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key key, this.board, this.onOpen, this.onToggleMarking})
      : super(key: key);

  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onToggleMarking;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
      crossAxisCount: board.columns,
      children: board.fields
          .map((c) => FieldWidget(
                field: c,
                onOpen: onOpen,
                onToggleMarking: onToggleMarking,
              ))
          .toList(),
    ));
  }
}
