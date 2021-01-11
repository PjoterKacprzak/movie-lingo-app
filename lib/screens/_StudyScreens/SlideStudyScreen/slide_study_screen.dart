







import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/model/UserFlashCardSheet.dart';
import 'package:movie_lingo_app/screens/_StudyScreens/SlideStudyScreen/componets/background.dart';
import 'package:movie_lingo_app/screens/_StudyScreens/SlideStudyScreen/componets/body.dart';

class SlideStudyScreen extends StatelessWidget {


  final UserFlashCardSheet _userFlashCardSheet;

  SlideStudyScreen(this._userFlashCardSheet);


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Body(_userFlashCardSheet));

  }
}
