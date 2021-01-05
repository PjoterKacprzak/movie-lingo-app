import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_lingo_app/components/rounded_input_field.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';


class DynamicFlashCardRemake extends StatefulWidget {

  int _flashCardIndex;
  String _hint;
  String _sourceLanguage;
  String _targetLanguage;
  final TextEditingController word = new TextEditingController();
  final TextEditingController translated = new TextEditingController();

  DynamicFlashCardRemake(String sourceLanguage, String targetLanguage, int flashCardIndex) {
    this._flashCardIndex = flashCardIndex;
    this._sourceLanguage = sourceLanguage;
    this._targetLanguage = targetLanguage;
  }

  @override
  _DynamicFlashCardRemakeState createState() => _DynamicFlashCardRemakeState();
}

class _DynamicFlashCardRemakeState extends State<DynamicFlashCardRemake> {

  List<String> test;
  http.Response response;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.all(ScreenSizeConfig.blockSizeVertical * 1),
          decoration:BoxDecoration(
            border: new Border.all(
                color: yellowTheemeColor,
                width: 1.0,
                style: BorderStyle.solid
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),

          ),
//      margin: new EdgeInsets.all(8.0),
          child: ListBody(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    //padding: EdgeInsets.fromLTRB( ScreenSizeConfig.blockSizeVertical * 1,  ScreenSizeConfig.blockSizeVertical * 1,  ScreenSizeConfig.blockSizeVertical * 1, 0),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.all( ScreenSizeConfig.blockSizeVertical * 2),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              "${widget._flashCardIndex}.",
                              style: TextStyle(fontSize: ScreenSizeConfig.blockSizeVertical * 3, color: Color(0xffFFA400)),
                            ),
                          ),
                        ),
                        Container(
                          height:  ScreenSizeConfig.blockSizeVertical * 8 ,
                          width: ScreenSizeConfig.blockSizeHorizontal * 70,
                          child: RoundedInputField(
                            style: TextStyle(
                                fontSize: ScreenSizeConfig.blockSizeHorizontal * 4,
                                fontWeight: FontWeight.w700
                            ),
                            hintText: 'Enter word',
                            icon: Icons.flag,
                            controller: widget.word,
                          ),
                        ),
                        Positioned(
                          right: ScreenSizeConfig.blockSizeHorizontal*15,
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: GestureDetector(
                                onTap: ()async{
                                  response = await translateSingleWord(widget._sourceLanguage,widget._targetLanguage, widget.word.text);
                                  setState(() {
                                    if(response.statusCode==200)
                                      widget._hint= response.body;
                                    else
                                      widget._hint= ' ';
                                  });
                                },
                                child: Icon(
                                  Icons.search,
                                )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    height:  ScreenSizeConfig.blockSizeVertical * 8 ,
                    width: ScreenSizeConfig.blockSizeHorizontal * 70,
                    // padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: new RoundedInputField(
                      controller: widget.translated,
                      hintText: displayHintText(widget._hint),
                      //controller:,
                      icon: Icons.flag,

                      onChanged:(text){

                      },
                    ),
                  ),

                ],
              )
            ],

          ),

        ),
        SizedBox(height: ScreenSizeConfig.blockSizeVertical * 0.5,)
      ],
    );
  }

  Future<http.Response> translateSingleWord(String sourceLanguage, String targetLanguage,String word)async
  {
    var newJson = {};

    newJson["sourceLanguage"] = sourceLanguage;
    newJson["targetLanguage"] = targetLanguage;
    newJson["word"] = word;

    String singleWordTranslation = json.encode(newJson);

    final http.Response response = await http.post(
        'http://10.0.2.2:8080/translation-api/single-word-translation',
        headers: {'Content-Type': 'application/json'},
        body: singleWordTranslation);

    //List<String> test = json.decode(response.body);

    return response;
  }

  String displayHintText(String hint)
  {
    if(hint == null)
      return '';
    else
      return hint;
  }

}
