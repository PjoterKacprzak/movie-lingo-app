





import 'package:flutter/cupertino.dart';
import 'package:movie_lingo_app/model/FlashCard.dart';
import 'package:movie_lingo_app/model/UserFlashCardSheet.dart';
import 'package:movie_lingo_app/screens/EditFlashCard/components/Body.dart';
import 'package:movie_lingo_app/screens/EditFlashCard/components/dynamic_flash_card_remake.dart';



class EditFlashCard extends StatefulWidget {


  UserFlashCardSheet userFlashCardSheet;
  EditFlashCard(this.userFlashCardSheet);

  @override
  _EditFlashCardState createState() => _EditFlashCardState();

}

class _EditFlashCardState extends State<EditFlashCard> {
  @override
  Widget build(BuildContext context) {
    return Body(widget.userFlashCardSheet);
  }

}

