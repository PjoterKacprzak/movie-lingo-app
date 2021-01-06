import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_lingo_app/model/UserFlashCardSheet.dart';

class HorizontalListItem extends StatelessWidget {
  HorizontalListItem(this.item);
  final UserFlashCardSheet item;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 160.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              child: Text(''),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.flashCardName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}