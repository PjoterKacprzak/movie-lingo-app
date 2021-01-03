import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_lingo_app/components/rounded_button.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenSizeConfig().init(context);
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            new Image.asset('assets/icons/chat.svg', width: 100.0, height: 100.0),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

