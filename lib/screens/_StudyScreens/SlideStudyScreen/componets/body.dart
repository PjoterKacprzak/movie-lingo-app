





import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intervalprogressbar/intervalprogressbar.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:movie_lingo_app/model/UserFlashCardSheet.dart';
import 'package:movie_lingo_app/screens/_StudyScreens/SlideStudyScreen/componets/background.dart';
import 'package:movie_lingo_app/screens/_StudyScreens/SlideStudyScreen/componets/display_slidable_flash_card.dart';
import 'package:tcard/tcard.dart';

class Body extends StatefulWidget {

  final UserFlashCardSheet _userFlashCardSheet;
  Body(this._userFlashCardSheet);

  @override
  _BodyState createState() => _BodyState();


}

class _BodyState extends State<Body> {
  TCardController _controller = TCardController();
  int _index=0;
  List<DisplaySlidableFlashCard> _listOfSlidableFlashCards;

  @override
  void initState() {
    _listOfSlidableFlashCards =  List.generate(widget._userFlashCardSheet.flashCards.length, (int index){
      return DisplaySlidableFlashCard(widget._userFlashCardSheet.flashCards[index]);
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           IntervalProgressBar(
          direction: IntervalProgressDirection.horizontal,
          max: _listOfSlidableFlashCards.length,
          progress: _index,
          intervalSize: 1,
          size: Size(
            ScreenSizeConfig.blockSizeVertical * 30,
            ScreenSizeConfig.blockSizeHorizontal *5
          ),
          highlightColor: Color(0xff6a040f),
          defaultColor: Color(0xff5e60ce),
          intervalColor: Colors.black,
          intervalHighlightColor: Colors.black,
          reverse: false,
          radius: 3,
             intervalDegrees:  300.0,
           ),
            SizedBox(height: ScreenSizeConfig.blockSizeVertical * 5,),
            //SizedBox(height: ScreenSizeConfig.blockSizeVertical * 5),
            TCard(

              cards: _listOfSlidableFlashCards,
              controller: _controller,
              onForward: (index, info) {
                print(_index);
               // _index = index;
                print(info.direction);
                setState(() {});
              },
              onBack: (index) {
                print(_index);
               // _index = index;
                setState(() {});
              },
              onEnd: () {
                print('end');
              },
            ),
           // SizedBox(height: ScreenSizeConfig.blockSizeVertical * 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: ScreenSizeConfig.blockSizeHorizontal *30,
                  height: ScreenSizeConfig.blockSizeVertical *5,
                  child: FlatButton(
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    color: yellowTheemeColor,
                    onPressed: () {_controller.back();},
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.navigate_before),
                        Text(
                          'Back',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:ScreenSizeConfig.blockSizeVertical * 2 ),),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenSizeConfig.blockSizeHorizontal *30,
                  height: ScreenSizeConfig.blockSizeVertical *5,
                  child: FlatButton(

                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    color: yellowTheemeColor,
                    onPressed: () {_controller.reset();
                    setState(() {
                      _index = 0;
                    });

                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize:ScreenSizeConfig.blockSizeVertical * 2 ),),
                  ),
                ),

                SizedBox(
                  width: ScreenSizeConfig.blockSizeHorizontal *30,
                  height: ScreenSizeConfig.blockSizeVertical *5,
                  child: FlatButton(

                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    color: yellowTheemeColor,
                    onPressed: () {_controller.forward();

                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:ScreenSizeConfig.blockSizeVertical * 2 ),),
                        Icon(Icons.navigate_next)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
