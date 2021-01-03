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


class DynamicFlashCard extends StatefulWidget {

  FocusNode focusNode;
  int _flashCardIndex;
  String _hint;
  String _sourceLanguage;
  String _targetLanguage;
  final TextEditingController word = new TextEditingController();
  final TextEditingController translated = new TextEditingController();



  DynamicFlashCard(String sourceLanguage, String targetLanguage,FocusNode focusNode, int flashCardIndex) {
    this.focusNode = focusNode;
    this._flashCardIndex = flashCardIndex;
    this._sourceLanguage = sourceLanguage;
    this._targetLanguage = targetLanguage;
  }

  @override
  _DynamicFlashCardState createState() => _DynamicFlashCardState();
}

class _DynamicFlashCardState extends State<DynamicFlashCard> {

  List<String> test;
  String _translatedWord;
  http.Response response;

  void initState() {
    super.initState();
    // Start listening to changes.
  }


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
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                               alignment: AlignmentDirectional.centerStart,
                               child: Text(
                                 "${widget._flashCardIndex}.",
                                 style: TextStyle(fontSize: ScreenSizeConfig.blockSizeVertical * 3, color: Color(0xffFFA400)),
                               ),
                             ),
                          ),
                        RoundedInputField(
                             style: TextStyle(
                               fontSize: ScreenSizeConfig.blockSizeHorizontal * 5,
                               fontWeight: FontWeight.w700
                             ),
                             icon: Icons.flag,
                             focusNode: widget.focusNode,
                             controller: widget.word,
                           ),
                         Positioned(
                      right: ScreenSizeConfig.blockSizeHorizontal*11,
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


  Widget _customDropDownExample(
      BuildContext context, String item, String itemDesignation) {
    return Container(
      child: (item?.isEmpty == null)
          ? ListTile(
        //contentPadding: EdgeInsets.all(0),
        //leading: CircleAvatar(),
        title: Text(""),
      )
          : ListTile(

        title: Text(item,maxLines: 1,
            textAlign: TextAlign.center
          // softWrap: true,
        ),

      ),
    );
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, String item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme
            .of(context)
            .primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        title: Text(item, maxLines: 1,
          style: TextStyle(fontSize: 15),
        ),
        // subtitle: Text(item.language.toString()),
      ),
    );
  }
}
