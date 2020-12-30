import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_lingo_app/components/rounded_input_field.dart';

class DynamicFlashCard extends StatelessWidget {
  final TextEditingController word = new TextEditingController();
  final TextEditingController translated = new TextEditingController();

  FocusNode focusNode;

  DynamicFlashCard( FocusNode focusNode)
  {
    this.focusNode = focusNode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: new EdgeInsets.all(8.0),
      child: ListBody(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
                child: Row(
                  children: [
                    new RoundedInputField(
                      // icon:Icon.ImageIcon(Image.asset('icons/flags/png/de.png', package: 'country_icons')),
                      icon: Icons.flag,
                      focusNode: focusNode,
                      controller: word,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                      child: Icon(
                        Icons.compare_arrows_rounded,
                        size: 30,
                        color: Color(0xffFFA400),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(80, 0, 20, 0),
                child: new RoundedInputField(
                  controller: translated,
                  icon: Icons.flag,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
