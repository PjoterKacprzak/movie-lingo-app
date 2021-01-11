


import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/model/FlashCard.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
class DisplaySlidableFlashCard extends StatefulWidget {

  final FlashCard _flashCard;
  DisplaySlidableFlashCard(this._flashCard);

  @override
  _DisplaySlidableFlashCardState createState() => _DisplaySlidableFlashCardState();
}

class _DisplaySlidableFlashCardState extends State<DisplaySlidableFlashCard> {
   AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlipCard(

             direction: FlipDirection.VERTICAL,
            front: Container(
            width:  ScreenSizeConfig.blockSizeVertical  * 60,
            height:  ScreenSizeConfig.blockSizeHorizontal * 60 ,


            decoration: BoxDecoration(
              color: yellowTheemeColor,
              borderRadius: BorderRadius.circular(44.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 17),
                  blurRadius: 3.0,
                  spreadRadius: -4.0,
                  color: Colors.black54,
                )
              ],
            ),
            child:
            ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                         Text(
                           widget._flashCard.sourceWord.toUpperCase(),
                           style:TextStyle(
                             fontSize: ScreenSizeConfig.blockSizeVertical * 8,
                           ) ,
                         ),
                  ],
                )
            ),
          ),
          back: Container(
            width:  ScreenSizeConfig.blockSizeVertical  * 60,
            height:  ScreenSizeConfig.blockSizeHorizontal * 60 ,


            decoration: BoxDecoration(
              color: yellowTheemeColor,
              borderRadius: BorderRadius.circular(44.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 17),
                  blurRadius: 3.0,
                  spreadRadius: -4.0,
                  color: Colors.black54,
                )
              ],
            ),
            child:

            ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(widget._flashCard.translatedWord.toUpperCase(),
                      style:TextStyle(
                        fontSize: ScreenSizeConfig.blockSizeVertical * 8,
                      ) ,
                    ),







                  ],
                )
            ),
          ),
        ),
        // Container(
        //     width:  ScreenSizeConfig.blockSizeVertical  * 60,
        //     height:  ScreenSizeConfig.blockSizeHorizontal * 60 ,
        //
        //
        //   decoration: BoxDecoration(
        //     color: yellowTheemeColor,
        //     borderRadius: BorderRadius.circular(44.0),
        //     boxShadow: [
        //       BoxShadow(
        //         offset: Offset(0, 17),
        //         blurRadius: 3.0,
        //         spreadRadius: -4.0,
        //         color: Colors.black54,
        //       )
        //     ],
        //   ),
        //   child:
        //
        //   ClipRRect(
        //     borderRadius: BorderRadius.circular(16.0),
        //     child: GestureDetector(
        //       onTap: (){
        //         print("tapped");
        //       },
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //
        //
        //         FlipCard(
        //         direction: FlipDirection.VERTICAL, // default
        //         front: Container(
        //           child: Center(
        //             child: Text(
        //               widget._flashCard.sourceWord.toUpperCase(),
        //               style:TextStyle(
        //                 fontSize: ScreenSizeConfig.blockSizeVertical * 8,
        //               ) ,
        //             ),
        //           ),
        //         ),
        //         back: Container(
        //           child:  Center(
        //             child: Text(widget._flashCard.translatedWord.toUpperCase(),
        //               style:TextStyle(
        //                 fontSize: ScreenSizeConfig.blockSizeVertical * 8,
        //               ) ,
        //             ),
        //           )
        //         ),
        //       )
        //
        //
        //
        //
        //
        //
        //         ],
        //       ),
        //     )
        //   ),
        // ),
      ],
    );
  }
}
