import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:movie_lingo_app/model/UserFlashCardSheet.dart';

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item);
  final UserFlashCardSheet item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
          ? Slidable.of(context)?.open()
          : Slidable.of(context)?.close(),
      child: Card(
      color: beigeColor,
            shape: RoundedRectangleBorder(
            side: BorderSide(color: beigeColor, width: 3),
            borderRadius: BorderRadius.circular(33),
    ),
        child: ListTile(
          subtitle: Text(item.sourceLanguage.toUpperCase()+ ' - '+ item.targetLanguage.toUpperCase()),
          leading: Icon(Icons.accessible_forward_rounded),
          //tileColor: beigeColor,
          title: Text(item.flashCardName,
            style:  TextStyle(fontSize: ScreenSizeConfig.safeBlockHorizontal * 5),
        ),
      ),
      ),
    );
  }
}