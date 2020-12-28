

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_lingo_app/components/rounded_button.dart';
import 'package:movie_lingo_app/controller/TokenController.dart';
import 'package:movie_lingo_app/screens/MainPage/components/body.dart';
import 'package:movie_lingo_app/screens/Welcome/welcome_screen.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreen createState() =>  _MainScreen();
}
class  _MainScreen extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Body()
    );

  }

}
