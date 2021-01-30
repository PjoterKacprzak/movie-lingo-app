

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/model/FlashCard.dart';
import 'package:movie_lingo_app/model/Language.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:http/http.dart' as http;

import 'DropDownSearchWidget.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
class _BodyState extends State<Body> {

  ButtonState stateTextWithIcon = ButtonState.idle;

  String _selectedSeason;
  String _selectedEpisode;
  String _selectedDifficulty;

  Language _selectedLanguage = Language(language: 'Polish',languageCode: 'pl');
  Language _selectedLanguageTranslation = Language(language: 'English',languageCode: 'en');

  bool movieCheckBox = true;
  bool seriesCheckBox = false;
  double movieCheckBoxOpacity = 1.0;
  double seriesCheckBoxOpacity = 0.6;
  final List<String> data = new List<String>.generate(
      40, (index) => (index + 1).toString());
  final List<String> _difficulty = ["easy", "medium", "hard"];
  List<Language> _supportedLanguage;
  final TextEditingController movieNameController = new TextEditingController();

  List<FlashCard> listOfMovieFlashCards;



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
      appBar: PlatformAppBar(
        backgroundColor: Color(0xff0a043c),
        material: (_, __) =>
            MaterialAppBarData(
              toolbarHeight: 0,
              leading: Container(
                width: 0,
                height: 50,
              ),
            ),
        cupertino: (_, __) => CupertinoNavigationBarData(),
      ),
      backgroundColor: Color(0xff0a043c),
      material: (_, __) => MaterialScaffoldData(resizeToAvoidBottomInset: false),
      cupertino: (_, __) => CupertinoPageScaffoldData(resizeToAvoidBottomInset: false),
      body: Container(
        child: Center(

          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: ScreenSizeConfig.safeBlockVertical * 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenSizeConfig.blockSizeVertical * 5),
                    child: TextFormField(
                      controller: movieNameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: yellowTheemeColor,
                          hintText: "Enter Movie/Series name or IMDB ID",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(30)
                            ),
                          )
                      ),
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.black,
                      ),

                    ),
                  ),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         width: ScreenSizeConfig.blockSizeHorizontal * 40,
                  //         child: DropdownButton(
                  //           dropdownColor: darkBlueThemeColor,
                  //           isExpanded: true,
                  //           hint: Text(
                  //             'Select language', style: TextStyle(color: beigeColor),),
                  //           // Not necessary for Option 1
                  //           value: _selectedSourceLanguage,
                  //           onChanged: (newValue) {
                  //             setState(() {
                  //               _selectedSourceLanguage = newValue;
                  //             });
                  //           },
                  //           items: _supportedLanguage.map((location) {
                  //             return DropdownMenuItem(
                  //               child: Center(
                  //                   child: Text(
                  //                     location, textAlign: TextAlign.center,
                  //                     style: TextStyle(color: beigeColor,),)),
                  //               value: location,
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: ScreenSizeConfig.blockSizeHorizontal * 5,),
                  //       Container(
                  //         width: ScreenSizeConfig.blockSizeHorizontal * 40,
                  //         child: DropdownButton(
                  //           dropdownColor: darkBlueThemeColor,
                  //           isExpanded: true,
                  //           hint: Text(' Select language',
                  //             style: TextStyle(color: beigeColor),),
                  //           // Not necessary for Option 1
                  //           value: _selectedTargetLanguage,
                  //           onChanged: (newValue) {
                  //             setState(() {
                  //               _selectedTargetLanguage = newValue;
                  //             });
                  //           },
                  //           items: _supportedLanguage.map((location) {
                  //             return DropdownMenuItem(
                  //
                  //               child: Center(
                  //                   child: Text(
                  //                     location, textAlign: TextAlign.center,
                  //                     style: TextStyle(color: beigeColor,),)),
                  //               value: location,
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ]
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                             height: ScreenSizeConfig.blockSizeVertical * 8,
                            // width: ScreenSizeConfig.safeBlockHorizontal * 2,
                            child: DropDownSearchWidget(_supportedLanguage,callbackLanguage,_selectedLanguage)),
                      ),

                      Expanded(

                        child: Container(
                            // height: ScreenSizeConfig.blockSizeVertical * 8,
                            // width: ScreenSizeConfig.safeBlockHorizontal * 2,
                            child: DropDownSearchWidget(_supportedLanguage,callbackLanguageToTranslate,_selectedLanguageTranslation)),
                      ),

                    ],
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: ScreenSizeConfig.blockSizeHorizontal * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Opacity(
                            opacity: movieCheckBox==true? 1.0 : 0.6,
                            child: Container(
                              // padding:  EdgeInsets.symmetric(vertical: 0,horizontal: ScreenSizeConfig.blockSizeHorizontal * 10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal:
                                  ScreenSizeConfig.blockSizeHorizontal * 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27),
                                  color: yellowTheemeColor,
                                  border: Border.all(color: Colors.black)),
                              // color: yellowTheemeColor,
                              child: CheckboxListTile(
                                // checkColor: yellowTheemeColor,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal:
                                    ScreenSizeConfig.blockSizeHorizontal * 5),
                                //secondary: const Icon(Icons.ac_unit),
                                title: const Text(
                                  'Movie',
                                  style: TextStyle(color: Colors.black),
                                ),
                                //subtitle: Text('sub demo mode'),
                                value: this.movieCheckBox,
                                selected: true,
                                onChanged: (bool value) {
                                  setState(() {
                                    movieCheckBox=value;
                                    seriesCheckBox=!value;
                                    seriesCheckBoxOpacity=0.6;
                                    movieCheckBoxOpacity=1.0;

                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenSizeConfig.blockSizeHorizontal * 3,
                        ),
                        Expanded(
                          child: Opacity(
                            opacity: seriesCheckBox==true? 1.0 : 0.6,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal:
                                  ScreenSizeConfig.blockSizeHorizontal * 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27),
                                  color: yellowTheemeColor,
                                  border: Border.all(color: Colors.black)),
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal:
                                    ScreenSizeConfig.blockSizeHorizontal * 5),
                                controlAffinity: ListTileControlAffinity
                                    .trailing,
                                // secondary: const Icon(Icons.ac_unit),
                                title: const Text(
                                  'Series',
                                  style: TextStyle(color: Colors.black),
                                ),
                                // subtitle: Text('sub demo mode'),
                                value: this.seriesCheckBox,
                                onChanged: (bool value) {
                                  setState(() {
                                    seriesCheckBox=value;
                                    movieCheckBox=!value;
                                    movieCheckBoxOpacity=0.6;
                                    seriesCheckBoxOpacity=1.0;

                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: seriesCheckBox == true,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenSizeConfig.blockSizeHorizontal * 25,
                            child: DropdownButton(
                              dropdownColor: darkBlueThemeColor,
                              isExpanded: true,
                              hint: Text(
                                'Season', style: TextStyle(color: beigeColor),),
                              // Not necessary for Option 1
                              value: _selectedSeason,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedSeason = newValue;
                                });
                              },
                              items: data.map((location) {
                                return DropdownMenuItem(
                                  child: Center(
                                      child: Text(
                                        location, textAlign: TextAlign.center,
                                        style: TextStyle(color: beigeColor,),)),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            width: ScreenSizeConfig.blockSizeHorizontal * 5,),
                          Container(
                            width: ScreenSizeConfig.blockSizeHorizontal * 25,
                            child: DropdownButton(
                              dropdownColor: darkBlueThemeColor,
                              isExpanded: true,
                              hint: Text('Episode',
                                style: TextStyle(color: beigeColor),),
                              // Not necessary for Option 1
                              value: _selectedEpisode,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedEpisode = newValue;
                                });
                              },
                              items: data.map((location) {
                                return DropdownMenuItem(

                                  child: Center(
                                      child: Text(
                                        location, textAlign: TextAlign.center,
                                        style: TextStyle(color: beigeColor,),)),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ]
                    ),
                  ),
                  Container(
                    width: ScreenSizeConfig.blockSizeHorizontal * 25,
                    child: DropdownButton(
                      dropdownColor: darkBlueThemeColor,
                      isExpanded: true,
                      hint: Text(
                        'Difficulty', style: TextStyle(color: beigeColor),),
                      value: _selectedDifficulty,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDifficulty = newValue;
                        });
                      },
                      items: _difficulty.map((difficulty) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(
                                difficulty, textAlign: TextAlign.center,
                                style: TextStyle(color: beigeColor,),)),
                          value: difficulty,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: ScreenSizeConfig.blockSizeVertical * 50,),
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenSizeConfig.blockSizeVertical * 30),
                    child: buildTextWithIcon(),
                  )),
            ],
          ),
        ),
      ),
    );
  }


  Future<http.Response> getFlashCardsFromOpenSubtitle(String movieOrSeriesName,bool isMovie,int selectedSeason,
      int selectedEpisode, String selectedDifficulty,String sourceLanguage, String targetLanguage)async {

    var prepareJson={};
    prepareJson["movieName"]="0112573";
    prepareJson["isMovie"]=isMovie;
    prepareJson["difficulty"]=selectedDifficulty;
    prepareJson["sourceLanguage"]=sourceLanguage;
    prepareJson["targetLanguage"]=targetLanguage;
    if(!isMovie)
    {
      prepareJson["season"]=selectedSeason;
      prepareJson["episode"]=selectedEpisode;
    }


    String preparedJson = json.encode(prepareJson);
    final http.Response response = await http.post(
        'http://10.0.2.2:8080/subtitle/new-subtitle',
        headers: {'Content-Type': 'application/json'},
        body: preparedJson);


    if(response.statusCode!=200)
      {
        return response;
      }
    else
   // listOfFMovieFlashCards = (json.decode(response.body) as List ).map((e) => FlashCard.fromJson(e)).toList();
    setState(() {
      listOfMovieFlashCards = (json.decode(response.body) as List ).map((e) => FlashCard.fromJson(e)).toList();
      print(listOfMovieFlashCards);
    });


    return response;
  }


  Widget buildTextWithIcon() {
    return ProgressButton.icon(
        iconedButtons: {
          ButtonState.idle: IconedButton(
              text: "Send",
              icon: Icon(Icons.send, color: Colors.white),
              color: Colors.deepPurple.shade500),
          ButtonState.loading:
          IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
          ButtonState.fail: IconedButton(
              text: "No subtitles found",
              icon: Icon(Icons.cancel, color: Colors.white),
              color: Colors.red.shade300),
          ButtonState.success: IconedButton(
              text: "Success",
              icon: Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              color: Colors.green.shade400)
        },
        onPressed: () async {
          await onPressedIconWithText();
          //FocusScope.of(context).requestFocus(FocusNode());

          if (stateTextWithIcon == ButtonState.success) {
            Future.delayed(Duration(seconds: 1), () {
              //Navigator.pop(context);
            });
          }
        },
        state: stateTextWithIcon);
  }

  Future<void> onPressedIconWithText() async {
    http.Response response;
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        setState(() {
          stateTextWithIcon = ButtonState.loading;
        });
          if(!movieCheckBox)
            response =  await getFlashCardsFromOpenSubtitle(movieNameController.text,movieCheckBox,
             int.parse(_selectedSeason),int.parse(_selectedEpisode),_selectedDifficulty,_selectedLanguage.languageCode,_selectedLanguageTranslation.languageCode);
          else
            response = await getFlashCardsFromOpenSubtitle(movieNameController.text,movieCheckBox,
              0,0,_selectedDifficulty,_selectedLanguage.languageCode,_selectedLanguageTranslation.languageCode);

        if (response.statusCode == 200) {
          setState(() {
            stateTextWithIcon = ButtonState.success;
          });
          break;
        } else {
         // Toast.show("No subtitles found", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          setState(() {
            stateTextWithIcon = ButtonState.fail;
          });

          break;
        }

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }


  Future<void> getGoogleSupportedLanguages() async {
    final http.Response response = await http
        .get('http://10.0.2.2:8080/translation-api/supported-languages');

    final jsonResponse = json.decode(response.body);

    if(response.statusCode==200)
    {
      setState(() {
        _supportedLanguage = Language.fromJsonList(jsonResponse);
      });
      return Language.fromJsonList(jsonResponse);
    }


  }

}
