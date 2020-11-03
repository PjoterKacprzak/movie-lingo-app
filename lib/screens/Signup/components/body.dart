
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:movie_lingo_app/components/already_have_an_account_acheck.dart';
import 'package:movie_lingo_app/components/rounded_button.dart';
import 'package:movie_lingo_app/components/rounded_input_field.dart';
import 'package:http/http.dart' as http;
import 'package:movie_lingo_app/components/rounded_password_field.dart';
import '../../Login/login_screen.dart';
import 'background.dart';
import 'or_divider.dart';
import 'social_icon.dart';


//TODO:Input Validation
class Body extends StatelessWidget {

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              controller: emailController,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passwordController,
              hintText:"Password",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: confirmPasswordController,
              hintText: "Confirm password",
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {

                print(emailController);
                print(passwordController);
                print(confirmPasswordController);
                if(passwordController.text==confirmPasswordController.text)
               signUp(emailController.text, passwordController.text);
                else
                  {
                    Text("Wrong Password");
                  }
                },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
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
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}




Future<String>signUp(String email,String password) async
{
  var actualDate = new DateTime.now();
  var dateFormatter = new DateFormat.yMd().add_jm();
  String formattedDate = dateFormatter.format(actualDate);


  //TODO: that can be a method
  var userXml = {};
  userXml["name"] = '';
  userXml["lastName"] = '';
  userXml["password"] = password;
  userXml["telephoneNumber"] = '';
  userXml["email"] = email;
  userXml["profilePhoto"] = '';
  userXml["createdAt"]= formattedDate;
  userXml["role"]= 'user';
  String str = json.encode(userXml);
  print(str);

  final http.Response response = await http.post(
      'http://10.0.2.2:8080/api/user/addUser',
      headers:{'Content-Type': 'application/json'},
      body: str
  );
  print(response.statusCode);
  print(response.body);
return response.body;
}