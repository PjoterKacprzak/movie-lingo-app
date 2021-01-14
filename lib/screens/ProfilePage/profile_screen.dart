import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_lingo_app/model/User.dart';
import 'package:movie_lingo_app/screens/ProfilePage/components/body_portrait.dart';
import 'package:movie_lingo_app/screens/ProfilePage/components/body_landscape.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation){
          if(orientation == Orientation.portrait){
            return BodyPortrait();
          }else{
            return BodyLandscape();
          }
        },
      ),
    );
  }
}
