import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  const ResultWidget({Key key, this.win, this.onReboot}) : super(key: key);

  final bool win;
  final Function onReboot;

  Color _getColor() {
    if (win == null)
      return Colors.yellow;
    else if (!win)
      return Colors.red[300];
    else
      return Colors.green[300];
  }

  Icon _getIcon() {
    if (win == null)
      return Icon(Icons.sentiment_satisfied);
    else if (!win)
      return Icon(Icons.sentiment_very_dissatisfied);
    else
      return Icon(Icons.sentiment_very_satisfied);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        child: SafeArea(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: _getColor(),
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      icon: _getIcon(),
                      color: Colors.black,
                      iconSize: 35,
                      onPressed: () {},
                    ),
                  ),
                  RaisedButton(
                    color: Colors.grey[200],
                    onPressed: onReboot,
                    child: Text('Reiniciar'),
                  ),
                ],
              )),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(150);
}
