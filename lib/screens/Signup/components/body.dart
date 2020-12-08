
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
  final TextEditingController loginNameController = new TextEditingController();
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
          controller: loginNameController,
          hintText: "Your Login",
          onChanged: (value) {},
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
              press: () async{

                if(passwordController.text==confirmPasswordController.text) {
                  {
                    var result = await signUp(emailController.text, passwordController.text,loginNameController.text);
                    print(result);
                    if (result == "User saved")
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    else{

                    }
                  }
                }
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
                Navigator.pop(
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
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
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

Future<String>signUp(String email,String password,String loginName) async
{
  var actualDate = new DateTime.now();
  var dateFormatter = new DateFormat.yMd().add_jm();
  String formattedDate = dateFormatter.format(actualDate);

  //TODO: that can be a method
  var userJson = {};
  userJson["name"] = '';
  userJson["lastName"] = '';
  userJson["password"] = password;
  userJson["telephoneNumber"] = '';
  userJson["email"] = email;
  userJson["profilePhoto"] = '';
  userJson["createdAt"]= formattedDate;
  userJson["role"]= 'user';
  userJson["isActive"]= 'false';
  userJson["loginName"]= loginName;
  String str = json.encode(userJson);
  print(str);

  final http.Response response = await http.post(
      'http://10.0.2.2:8080/addUser',
      headers:{'Content-Type': 'application/json'},
      body: str
  );
return response.body;
}