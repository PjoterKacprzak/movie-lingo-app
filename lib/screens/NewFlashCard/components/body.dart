import 'dart:convert';
import 'dart:core';

// import com.google.cloud.translate.*;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:http/http.dart' as http;
import 'package:movie_lingo_app/model/Language.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:movie_lingo_app/screens/NewFlashCard/components/dynamic_flash_card.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FocusNode myFocusNode;
  TextEditingController _flashCardNameController = TextEditingController();

  List<DynamicFlashCard> dynamicFlashCards = [];
  List<String> words = [];
  List<String> translatedWords = [];

  Language _selectedCountry;
  Language _selectedCountryToTranslate;
  int _flashCardIndex = 0;

  List<Language> supportedLanguages;

  @override
  void initState() {
    // getData();
    super.initState();
    myFocusNode = FocusNode();
  }

  void getData() async {
    supportedLanguages = await getGoogleSupportedLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getGoogleSupportedLanguages(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
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
                          submitData();
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
                  leading: Container(
                    width: 0,
                    height: 0,
                  ),
                ),
                cupertino: (_, __) => CupertinoNavigationBarData(),
              ),
              body: Container(
                child: ListView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _flashCardNameController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              fillColor: kPrimaryLightColor,
                              filled: true,
                              hintText: 'Enter flashcard name',
                              hintStyle: TextStyle(
                                  fontSize:
                                      ScreenSizeConfig.blockSizeHorizontal * 4),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              )),
                        )),
                    SizedBox(
                      height: ScreenSizeConfig.blockSizeHorizontal * 1,
                      //width: ScreenSizeConfig.blockSizeVertical * 55,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom:  ScreenSizeConfig.blockSizeHorizontal * 1),
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.5, color: Color(0xffffe3d8),),
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(

                              height: ScreenSizeConfig.blockSizeVertical * 6,
                              //width: ScreenSizeConfig.blockSizeHorizontal * 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),
                                color: kPrimaryLightColor,
                              ),
                              child: DropdownSearch<Language>(
                                maxHeight: ScreenSizeConfig.blockSizeVertical* 30,
                                selectedItem: _selectedCountry,
                                //items: [supportedLanguages.getLanguageList()],
                                searchBoxController:
                                    TextEditingController(text: ''),
                                mode: Mode.BOTTOM_SHEET,
                                isFilteredOnline: true,
                                showClearButton: false,
                                showSearchBox: true,
                                //label: 'Language',
                                dropdownSearchDecoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                ),
                                //autoValidateMode: AutovalidateMode.onUserInteraction,
                                // validator: (UserModel u) =>
                                // u == null ? "user field is required " : null,
                                onFind: (String s) =>
                                    getGoogleSupportedLanguages(),
                                onChanged: (Language data) {
                                  setState(() {
                                    _selectedCountry = data;
                                  });
                                  print(data);
                                },
                                dropdownBuilder: _customDropDownExample,
                                popupItemBuilder: _customPopupItemBuilderExample,

                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: ScreenSizeConfig.blockSizeVertical * 6,
                               //width: ScreenSizeConfig.blockSizeHorizontal * 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),
                                color: kPrimaryLightColor,
                              ),
                              child: DropdownSearch<Language>(
                                maxHeight: ScreenSizeConfig.blockSizeVertical* 50,

                                //items: [supportedLanguages.getLanguageList()],
                                searchBoxController:
                                    TextEditingController(text: ''),
                                mode: Mode.BOTTOM_SHEET,
                                isFilteredOnline: true,
                                showClearButton: false,
                                showSearchBox: true,
                                selectedItem: _selectedCountryToTranslate,
                                //label: 'Language',
                                dropdownSearchDecoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                ),
                                //autoValidateMode: AutovalidateMode.onUserInteraction,
                                // validator: (UserModel u) =>
                                // u == null ? "user field is required " : null,
                                onFind: (String s) =>
                                    getGoogleSupportedLanguages(),
                                onChanged: (Language data2) {
                                  setState(() {
                                    _selectedCountryToTranslate = data2;
                                  });
                                  print(data2);
                                },
                                dropdownBuilder: _customDropDownExample,
                                popupItemBuilder: _customPopupItemBuilderExample,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenSizeConfig.blockSizeHorizontal * 1,
                    ),
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
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
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
    dynamicFlashCards.add(new DynamicFlashCard(_selectedCountry.languageCode,_selectedCountryToTranslate.languageCode,myFocusNode, _flashCardIndex));
  }

  cancelDynamic() {
    dynamicFlashCards.removeLast();
    setState(() {
      _flashCardIndex -= 1;
    });
  }

  swapLanguage() {
    Language temporaryCountry;
    setState(() {
      print(_selectedCountry);
      print(_selectedCountryToTranslate);

      temporaryCountry = _selectedCountry;
      _selectedCountry = _selectedCountryToTranslate;
      _selectedCountryToTranslate = temporaryCountry;
    });
  }

  submitData() {
    dynamicFlashCards.forEach((widget) => print(widget.word.text));
    dynamicFlashCards.forEach((widget) => print(widget.translated.text));
  }

  Future<List<Language>> getGoogleSupportedLanguages() async {
    final http.Response response = await http
        .get('http://10.0.2.2:8080/translation-api/supported-languages');

    final jsonResponse = json.decode(response.body);

    return Language.fromJsonList(jsonResponse);
  }

  Widget _customDropDownExample(
      BuildContext context, Language item, String itemDesignation) {
    return Container(

      child: (item?.language == null)
          ? ListTile(
              //contentPadding: EdgeInsets.all(0),
              //leading: CircleAvatar(),
              title: Text(""),
            )
          : ListTile(

              title: Padding(
                padding: const EdgeInsets.all(0.0),
                child: AutoSizeText(item.language,maxLines: 1,

                 ),
              ),


               // softWrap: true,
              ),

            );

  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, Language item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.language,maxLines: 1,
          style: TextStyle(fontSize: 15),
        ),
        // subtitle: Text(item.language.toString()),
      ),
    );
  }
}
