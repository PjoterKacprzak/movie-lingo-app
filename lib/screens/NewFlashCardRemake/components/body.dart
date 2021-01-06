




import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/controller/TokenController.dart';
import 'package:movie_lingo_app/model/FlashCard.dart';
import 'package:movie_lingo_app/model/Language.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:movie_lingo_app/model/UserFlashCardSheet.dart';
import 'package:movie_lingo_app/screens/NewFlashCardRemake/components/DropDownSearchWidget.dart';
import 'package:movie_lingo_app/screens/NewFlashCardRemake/components/dynamic_flash_card_remake.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  //region variables
  List<DynamicFlashCardRemake> dynamicFlashCards = [];
  List<String> words = [];
  List<String> translatedWords = [];
  TextEditingController _flashCardNameController = TextEditingController();
  List<Language> _languageList;
  Language _selectedLanguage = Language(language: 'English',languageCode: 'en');
  Language _selectedLanguageTranslation = Language(language: 'English',languageCode: 'en');
  int _flashCardIndex = 0;



  //endregion


  callbackLanguage(language)
  {
    setState(() {
      _selectedLanguage = language;
    });
  }
  callbackLanguageToTranslate(language)
  {
    setState(() {
      _selectedLanguageTranslation = language;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData()async{
     getGoogleSupportedLanguages();
  }


  @override
  Widget build(BuildContext context) {
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
                  getGoogleSupportedLanguages();
                  submitData(_flashCardNameController.text,_selectedLanguage.languageCode,_selectedLanguageTranslation.languageCode);
                },
              ),
              FloatingActionButton(
                heroTag: "btn2",
                child: Icon(
                  CupertinoIcons.xmark,
                  size: ScreenSizeConfig.blockSizeVertical * 4,
                ),
                backgroundColor: Colors.redAccent,
                onPressed: () {
                  cancelDynamic();
                },
              ),
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
                        cancelDynamic();
                      },
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: Colors.green,
                      onPressed: () {
                        addDynamic();
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
                      hintText: 'Enter flashcard name',
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
            Container(
              height: ScreenSizeConfig.blockSizeVertical * 8,
                width: ScreenSizeConfig.safeBlockHorizontal * 2,
                child: DropDownSearchWidget(_languageList,callbackLanguage,_selectedLanguage)),
            SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
            Container(
                height: ScreenSizeConfig.blockSizeVertical * 8,
                width: ScreenSizeConfig.safeBlockHorizontal * 2,
                child: DropDownSearchWidget(_languageList,callbackLanguageToTranslate,_selectedLanguageTranslation)),
            SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: dynamicFlashCards.length,
                itemBuilder: (_, index) => dynamicFlashCards[index]),
          ],
        ),
      ),
    );
  }


  swap()
  {
    Language temp;
    setState(() {

      temp = _selectedLanguage;
      _selectedLanguage= _selectedLanguageTranslation;
      _selectedLanguageTranslation =temp;
    });
  }
  addDynamic() {
    if (words.length != 0) {
      // floatingIcon = new Icon(Icons.add);
      words = [];
      translatedWords = [];
      dynamicFlashCards = [];
    }
    setState(() {
      _flashCardIndex += 1;
    });
    if (dynamicFlashCards.length >= 40) {
      return;
    }
    dynamicFlashCards.add(new DynamicFlashCardRemake(_selectedLanguage.languageCode,_selectedLanguageTranslation.languageCode, _flashCardIndex));
  }

  cancelDynamic() {
    dynamicFlashCards.removeLast();
    setState(() {
      _flashCardIndex -= 1;
    });
  }



  submitData(String flashCardName,String sourceLanguage, String targetLanguage) async{

    List<FlashCard> flashcards = List();
    dynamicFlashCards.forEach((widget) => flashcards.add(FlashCard(sourceWord:widget.word.text, translatedWord:widget.translated.text)));

    UserFlashCardSheet userFlashCardSheet = new UserFlashCardSheet(email:"", flashCardName: flashCardName,sourceLanguage: sourceLanguage, targetLanguage: targetLanguage,flashCards: flashcards);

    String token = await TokenController().retrieveToken("token");

    String flashCardJson = jsonEncode(userFlashCardSheet);
    print(flashCardJson);

    final http.Response response = await http.post(
        'http://10.0.2.2:8080//api/user/new-flash-card',
        headers: {'Content-Type': 'application/json',
          'Authorization': token},
        body: flashCardJson);

  }
  Future<void> getGoogleSupportedLanguages() async {
    final http.Response response = await http
        .get('http://10.0.2.2:8080/translation-api/supported-languages');

    final jsonResponse = json.decode(response.body);

    if(response.statusCode==200)
      {
        setState(() {
          _languageList = Language.fromJsonList(jsonResponse);
        });
        return Language.fromJsonList(jsonResponse);
      }


  }


}
