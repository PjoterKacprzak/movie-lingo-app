import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_lingo_app/components/rounded_input_field.dart';
import 'package:movie_lingo_app/model/LanguaagePicker.dart';

import 'package:movie_lingo_app/screens/NewFlashCard/components/dynamic_flash_card.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FocusNode myFocusNode;

  List<DynamicFlashCard> dynamicFlashCards = [];
  List<String> words = [];
  List<String> translatedWords = [];

  int _selectedCountry;
  int _selectedCountryToTranslate;
  int _flashCardIndex = 0;
  static List<String> _cities = [
    "Polish",
    "English",
    "Italian",
    "French",
    "Ukrainian",
    "Russian",
    "Portuguese"
  ];

  List<DropdownMenuItem<String>> _dropdownMenuItems;

  // List<LanguagePicker> _cities =
  //     LanguagePicker(Country, language)

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
      title: const Text('Next page'),
    ),
      backgroundColor: Color(0xff0a043c),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.09,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(80.0),
                  color: kPrimaryLightColor,
                  // border: Border.all()
                ),
                padding: EdgeInsets.all(10.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: (value) {
                      setState(() {
                        _selectedCountry = value;
                      });
                    },
                    value: _selectedCountry,
                    items: [
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("Polish",textAlign: TextAlign.center,)), value: 1,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("English",textAlign: TextAlign.center,)), value: 2,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("Italian",textAlign: TextAlign.center,)), value: 3,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("French",textAlign: TextAlign.center,)), value: 4,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("Ukrainian",textAlign: TextAlign.center,)), value: 5,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("Russian",textAlign: TextAlign.center,)), value: 6,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("Portuguese",textAlign: TextAlign.center,)), value: 7,),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap:() {swapLanguage(); },
                child:  Container(
                    width: 80.0,
                    height: 40.0,
                    child: Icon(Icons.compare_arrows_rounded, color: Color(0xffFFA400),)),
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  color: kPrimaryLightColor,
                  // border: Border.all()
                ),
                padding: EdgeInsets.all(10.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: (value) {
                      setState(() {
                        _selectedCountryToTranslate = value;
                      });
                    },
                    value: _selectedCountryToTranslate,
                    items: [
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("Polish",textAlign: TextAlign.center,)), value: 1,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("English",textAlign: TextAlign.center,)), value: 2,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("Italian",textAlign: TextAlign.center,)), value: 3,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("French",textAlign: TextAlign.center,)), value: 4,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("Ukrainian",textAlign: TextAlign.center,)), value: 5,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("Russian",textAlign: TextAlign.center,)), value: 6,),
                      DropdownMenuItem(child: SizedBox( width: 100, child: Text("Portuguese",textAlign: TextAlign.center,)), value: 7,),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          //RoundedInputField(),
          Flexible(
            child: ListView.builder(
                itemCount: dynamicFlashCards.length,
                itemBuilder: (_, index) => dynamicFlashCards[index]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.green,
                    onPressed: () {
                      addDynamic();
                    },
                  ),
                  FloatingActionButton(
                    child: Icon(CupertinoIcons.envelope),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  addDynamic() {
    if (words.length != 0) {
      // floatingIcon = new Icon(Icons.add);
      words = [];
      translatedWords = [];
      dynamicFlashCards = [];
    }
    setState(() {
      _flashCardIndex +=1;
    });
    if (dynamicFlashCards.length >= 40) {
      return;
    }
    dynamicFlashCards.add(new DynamicFlashCard(myFocusNode,_flashCardIndex));
  }

  swapLanguage()
  {
    int temporaryCountry;
    setState(() {

      temporaryCountry = _selectedCountry;
      _selectedCountry = _selectedCountryToTranslate;
      _selectedCountryToTranslate = temporaryCountry;


    });
  }
  submitData() {
    dynamicFlashCards.forEach((widget) => print(widget.word.text));
    dynamicFlashCards.forEach((widget) => print(widget.translated.text));
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = List();
    for (String cities in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(cities),
          value: cities,
        ),
      );
    }
    return items;
  }
}
