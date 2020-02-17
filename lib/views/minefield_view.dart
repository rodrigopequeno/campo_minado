import 'package:campo_minado/components/board_widget.dart';
import 'package:campo_minado/components/result_widget.dart';
import 'package:campo_minado/models/board.dart';
import 'package:campo_minado/models/field.dart';
import 'package:flutter/material.dart';

class MinefieldView extends StatefulWidget {
  MinefieldView({Key key}) : super(key: key);

  @override
  _MinefieldViewState createState() => _MinefieldViewState();
}

class _MinefieldViewState extends State<MinefieldView> {
  bool _win;
  Board _board;

  Board _getBoard(double height, double width) {
    if (_board == null) {
      int numberColumns = 15;
      double sizeField = width / numberColumns;
      int numberRows = (height / sizeField).floor();

      _board = Board(
          rows: numberRows, columns: numberColumns, numberBombs: numberRows);
    }
    return _board;
  }

  _reboot() {
    setState(() {
      _win = null;
      _board.reboot();
    });
  }

  _open(Field field) {
    if (_win != null) {
      return;
    }
    setState(() {
      try {
        field.openUp();
        if (_board.resolved) {
          _win = true;
        }
      } catch (ExplosionException) {
        _win = false;
        _board.revealBombs();
      }
    });
  }

  _toggleMarking(Field field) {
    if (_win != null) {
      return;
    }
    setState(() {
      field.changeMarkup();
      if (_board.resolved) {
        _win = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultWidget(
          win: _win,
          onReboot: _reboot,
        ),
        body: Container(
            color: Colors.grey,
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return BoardWidget(
                  board: _getBoard(constraints.maxHeight, constraints.maxWidth),
                  onOpen: _open,
                  onToggleMarking: _toggleMarking,
                );
              },
            )),
      ),
    );
  }
}
