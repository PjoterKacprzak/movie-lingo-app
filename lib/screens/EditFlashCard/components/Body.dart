import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/controller/TokenController.dart';
import 'package:movie_lingo_app/model/FlashCard.dart';
import 'package:movie_lingo_app/model/Language.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:movie_lingo_app/model/UserFlashCardSheet.dart';
import 'package:http/http.dart' as http;
import 'DropDownSearchWidget.dart';
import 'dynamic_flash_card_remake.dart';

class Body extends StatefulWidget {
  UserFlashCardSheet userFlashCardSheet;

  Body(this.userFlashCardSheet);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
//region variables

  TextEditingController _flashCardNameController = TextEditingController();
  Language _selectedLanguageTranslation;
  Language _selectedLanguage;

  List<DynamicFlashCardRemake> dynamicFlashCards = [];

  callbackDeleteFlashCard(index) {
    setState(() {
      widget.userFlashCardSheet.flashCards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedLanguageTranslation = Language(
        language: widget.userFlashCardSheet.targetLanguage,
        languageCode: widget.userFlashCardSheet.targetLanguage);
    _selectedLanguage = Language(
        language: widget.userFlashCardSheet.sourceLanguage,
        languageCode: widget.userFlashCardSheet.sourceLanguage);
    _flashCardNameController.text = widget.userFlashCardSheet.flashCardName;
    return PlatformScaffold(
      backgroundColor: Color(0xff0a043c),
      material: (_, __) => MaterialScaffoldData(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: "btn1",
                child: Icon(CupertinoIcons.envelope),
                onPressed: () {
                  setState(() {
                    editData(
                      widget.userFlashCardSheet.id,
                        _flashCardNameController.text,
                        _selectedLanguage.languageCode,
                        _selectedLanguageTranslation.languageCode);
                  });
                },
              ),
              // FloatingActionButton(
              //   heroTag: "btn2",
              //   child: Icon(
              //     CupertinoIcons.xmark,
              //     size: ScreenSizeConfig.blockSizeVertical * 4,
              //   ),
              //   backgroundColor: Colors.redAccent,
              //   onPressed: () {
              //     //cancelDynamic();
              //   },
              // ),
              FloatingActionButton(
                heroTag: "btn3",
                child: Icon(Icons.add),
                backgroundColor: Colors.green,
                onPressed: () {
                  addDynamic();
                },
              ),
            ],
          ),
        ),
      ),
      cupertino: (_, __) => CupertinoPageScaffoldData(
          body: Scaffold(
              floatingActionButton: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
            FloatingActionButton(
              child: Icon(CupertinoIcons.envelope),
              onPressed: () {},
            ),
            FloatingActionButton(
              child: Icon(Icons.cancel),
              backgroundColor: Colors.redAccent,
              onPressed: () {
                //  cancelDynamic();
              },
            ),
            FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              onPressed: () {
                // addDynamic();
              },
            ),
          ]))),
      appBar: PlatformAppBar(
        backgroundColor: Color(0xff0a043c),
        material: (_, __) => MaterialAppBarData(
          toolbarHeight: 0,
          leading: Container(
            width: 0,
            height: 50,
          ),
        ),
        cupertino: (_, __) => CupertinoNavigationBarData(),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.only(
            bottom: ScreenSizeConfig.blockSizeVertical * 3,
            left: ScreenSizeConfig.blockSizeVertical * 2,
            right: ScreenSizeConfig.blockSizeVertical * 2,
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: ScreenSizeConfig.blockSizeVertical * 3,
                left: ScreenSizeConfig.blockSizeHorizontal * 5,
                right: ScreenSizeConfig.blockSizeHorizontal * 5,
              ),
              child: Theme(
                data: new ThemeData(
                  primaryColor: beigeColor,
                  primaryColorDark: beigeColor,
                ),
                child: TextField(

                    controller: _flashCardNameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: beigeColor,
                        //contentPadding: Edge,
                        border:  OutlineInputBorder(
                            borderRadius:BorderRadius.circular(40),
                            borderSide: BorderSide(color: beigeColor,
                              width: 0,
                              style: BorderStyle.none,),


                        ))),
              ),
            ),
            SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
            SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.userFlashCardSheet.sourceLanguage.toUpperCase(),
                  style: TextStyle(
                      fontSize: ScreenSizeConfig.blockSizeHorizontal * 5,
                      fontWeight: FontWeight.bold,
                      color: beigeColor),
                ),
                Text(
                  '  -  ',
                  style: TextStyle(
                      fontSize: ScreenSizeConfig.blockSizeHorizontal * 5,
                      fontWeight: FontWeight.bold,
                      color: beigeColor),
                ),
                Text(
                  widget.userFlashCardSheet.targetLanguage.toUpperCase(),
                  style: TextStyle(
                      fontSize: ScreenSizeConfig.blockSizeHorizontal * 5,
                      fontWeight: FontWeight.bold,
                      color: beigeColor),
                )
              ],
            ),
            SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: widget.userFlashCardSheet.flashCards.length,
                itemBuilder: (BuildContext context, int index) {
                  dynamicFlashCards.add(DynamicFlashCardRemake(
                      widget.userFlashCardSheet.flashCards[index],
                      index,
                      callbackDeleteFlashCard));

                  return dynamicFlashCards[index];
                }
                )
          ],
        ),
      ),
    );
  }

  swap() {
    Language temp;
    setState(() {
      temp = _selectedLanguage;
      _selectedLanguage = _selectedLanguageTranslation;
      _selectedLanguageTranslation = temp;
    });
  }

  addDynamic() {
    if (widget.userFlashCardSheet.flashCards.length == 0) {
      widget.userFlashCardSheet.flashCards = [];
    }
    setState(() {
      widget.userFlashCardSheet.flashCards
          .add(FlashCard(sourceWord: '', translatedWord: ''));
    });
    if (widget.userFlashCardSheet.flashCards.length >= 40) {
      return;
    }
  }

  editData(int id,String flashCardName, String sourceLanguage,
      String targetLanguage) async {
    List<FlashCard> flashcards = List();
    dynamicFlashCards.forEach((widget) => flashcards.add(FlashCard(
        sourceWord: widget.word.text, translatedWord: widget.translated.text)));
    UserFlashCardSheet userFlashCardSheet = new UserFlashCardSheet(
        id: id,
        email: "",
        flashCardName: flashCardName,
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
        flashCards: flashcards);

    String token = await TokenController().retrieveToken("token");
    String flashCardJson = jsonEncode(userFlashCardSheet);
    final http.Response response = await http.patch(
        'http://10.0.2.2:8080/api/user/edit-flash-card',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: flashCardJson);
  }

}
