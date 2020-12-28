import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_lingo_app/screens/MainPage/components/body.dart';
import 'package:movie_lingo_app/screens/NewFlashCard/components/background.dart';
import 'package:movie_lingo_app/screens/NewFlashCard/components/dynamic_flash_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  FocusNode myFocusNode;

  List<DynamicFlashCard> dynamicFlashCards = [];
  List<String> words = [];
  List<String> translatedWords = [];
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
      backgroundColor: Color(0xff0a043c),
      floatingActionButton: new FloatingActionButton(
          onPressed:() {
            myFocusNode.requestFocus();
            addDynamic();
          },


          child: new Icon(Icons.add)),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.06,
          ),
          SizedBox(
            width: size.width * 045,
            height: size.height * 0.07,
            child: Align(
              alignment: Alignment.center,
              child: CupertinoButton(
                  borderRadius: new BorderRadius.circular(30.0),
                  child: Text(
                    "Save",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onPressed: () {submitData();},
                  color: Color(0xff54E619)),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: dynamicFlashCards.length,
                itemBuilder: (_,index)=> dynamicFlashCards[index]),
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
    setState(() {});
    if (dynamicFlashCards.length >= 40) {
      return;
    }
    dynamicFlashCards.add(new DynamicFlashCard(myFocusNode));
  }
  
  submitData()
  {
    dynamicFlashCards.forEach((widget) => print(widget.word.text));
    dynamicFlashCards.forEach((widget) => print(widget.translated.text));

  }
  
}
