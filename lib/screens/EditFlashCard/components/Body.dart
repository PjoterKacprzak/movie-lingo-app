



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
Language _selectedLanguage = Language(language: 'English',languageCode: 'en');
Language _selectedLanguageTranslation = Language(language: 'English',languageCode: 'en');
int _flashCardIndex = 0;

List<DynamicFlashCardRemake> dynamicFlashCards = [];

// callbackDeleteFlashCard(index)
// {
//   setState(() {
//     widget.userFlashCardSheet.flashCards.removeAt(index);
//   });
// }


@override
Widget build(BuildContext context) {
  _flashCardNameController.text=widget.userFlashCardSheet.flashCardName;
parseData();
  return PlatformScaffold(
    backgroundColor: Color(0xff0a043c),
    material: (_, __) => MaterialScaffoldData(
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
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
                  editData(_flashCardNameController.text,_selectedLanguage.languageCode,_selectedLanguageTranslation.languageCode);

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
        padding:  EdgeInsets.only(
          bottom:  ScreenSizeConfig.blockSizeVertical * 3,
          left: ScreenSizeConfig.blockSizeVertical * 2,
          right: ScreenSizeConfig.blockSizeVertical * 2,
        ),
        children: [
          Padding(
            padding:EdgeInsets.only(
              top:  ScreenSizeConfig.blockSizeVertical * 3,
              left: ScreenSizeConfig.blockSizeHorizontal * 5,
              right: ScreenSizeConfig.blockSizeHorizontal * 5,
            ),
            child: TextField(
                controller: _flashCardNameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: beigeColor,
                    //contentPadding: Edge,
                    enabledBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      borderSide: BorderSide(color:beigeColor),
                    )
                )
            ),
          ),
          SizedBox(
              height: ScreenSizeConfig.blockSizeVertical * 1),
          SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.userFlashCardSheet.sourceLanguage.toUpperCase(),
              style: TextStyle(
                fontSize: ScreenSizeConfig.blockSizeHorizontal * 5,
                fontWeight: FontWeight.bold,
                color: beigeColor
              ),
              ),
              Text('  -  ',
                style: TextStyle(
                    fontSize: ScreenSizeConfig.blockSizeHorizontal * 5,
                    fontWeight: FontWeight.bold,
                    color: beigeColor
                ),),
              Text(widget.userFlashCardSheet.targetLanguage.toUpperCase(),
                  style: TextStyle(
                  fontSize: ScreenSizeConfig.blockSizeHorizontal * 5,
                  fontWeight: FontWeight.bold,
                  color: beigeColor
              ),)
            ],
          ),
          SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: dynamicFlashCards.length,
             itemBuilder: (BuildContext context, int index) =>dynamicFlashCards[index]
            //itemBuilder: (_, index) => dynamicFlashCards[index],
          )
        ],
      ),
    ),
  );
}

parseData(){
  //widget.userFlashCardSheet.flashCards.forEach((widget) => tempFlashCards.add(Dynamic(sourceWord:widget.sourceWord, translatedWord:widget.translatedWord)));
  widget.userFlashCardSheet.flashCards.forEach((widget) =>
      dynamicFlashCards.add(DynamicFlashCardRemake(FlashCard(sourceWord: widget.sourceWord,translatedWord: widget.translatedWord))));


}

swap() {
  Language temp;
  setState(() {

    temp = _selectedLanguage;
    _selectedLanguage= _selectedLanguageTranslation;
    _selectedLanguageTranslation =temp;
  });
}
addDynamic() {
  if (widget.userFlashCardSheet.flashCards.length == 0) {
    widget.userFlashCardSheet.flashCards = [];
  }
  setState(() {
    widget.userFlashCardSheet.flashCards.add(FlashCard(sourceWord: '',translatedWord: ''));
  });
  if (widget.userFlashCardSheet.flashCards.length >= 40) {
    return;
  }
  //dynamicFlashCards.add(new DynamicFlashCardRemake(_selectedLanguage.languageCode,_selectedLanguageTranslation.languageCode, _flashCardIndex));
}
editData(String flashCardName,String sourceLanguage, String targetLanguage) async{

  List<FlashCard> flashcards = List();
  dynamicFlashCards.forEach((widget) => flashcards.add(FlashCard(sourceWord:widget.word.text, translatedWord:widget.translated.text)));
  print("here");
  print(flashcards);
  UserFlashCardSheet userFlashCardSheet = new UserFlashCardSheet(email:"", flashCardName: flashCardName,sourceLanguage: sourceLanguage, targetLanguage: targetLanguage,flashCards: flashcards);

  String token = await TokenController().retrieveToken("token");

  String flashCardJson = jsonEncode(userFlashCardSheet);
  print(flashCardJson);

  final http.Response response = await http.patch(
      'http://10.0.2.2:8080/api/user/edit-flash-card',
      headers: {'Content-Type': 'application/json',
        'Authorization': token},
      body: flashCardJson);

}
//make list of DynamicFlashCard





// Future<void> getGoogleSupportedLanguages() async {
//   final http.Response response = await http
//       .get('http://10.0.2.2:8080/translation-api/supported-languages');
//
//   final jsonResponse = json.decode(response.body);
//
//   if(response.statusCode==200)
//   {
//     setState(() {
//       _languageList = Language.fromJsonList(jsonResponse);
//     });
//     return Language.fromJsonList(jsonResponse);
//   }
//
//
// }


}
