import 'package:flutter/material.dart';
import 'package:movie_lingo_app/components/text_field_container.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';

import '../constants.dart';


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final TextStyle style;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
 // final TextAlign textAlign;
  const RoundedInputField({
    Key key,
    this.style,
    this.hintText,
    this.focusNode,
    this.icon = Icons.person,
    this.onChanged,
    this.controller,
    //this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(

       // textAlign: textAlign,
        controller:controller,
        onChanged: onChanged,
        style: style,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(

          hintStyle: TextStyle(
            //fontWeight: FontWeight,
              fontStyle: FontStyle.italic,
                  fontSize: ScreenSizeConfig.blockSizeHorizontal * 4

          ),
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
