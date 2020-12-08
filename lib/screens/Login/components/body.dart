
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_lingo_app/components/already_have_an_account_acheck.dart';
import 'package:movie_lingo_app/components/rounded_button.dart';
import 'package:movie_lingo_app/components/rounded_input_field.dart';
import 'package:movie_lingo_app/components/rounded_password_field.dart';
import 'package:movie_lingo_app/controller/TokenController.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_lingo_app/screens/Login/login_screen.dart';
import 'package:movie_lingo_app/screens/MainPage/main_screen.dart';
import '../../Signup/signup_screen.dart';
import 'background.dart';

//TODO:Input Validation
class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);


  @override
  _BodyState createState() => _BodyState();
}

class  _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }


  @override
  Widget build(BuildContext context) {
    var storage = FlutterSecureStorage();
    Size size = MediaQuery.of(context).size;
    final TextEditingController emailController= TextEditingController();
    final TextEditingController passwordController= TextEditingController();

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              controller: emailController,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: ()async {
                String token =  await login(emailController.text, passwordController.text);
                if(token!="Bad Credentials") {
                  TokenController().saveToken(token);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
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

  Future<String> login(String email, String password) async {

    print("Login...");
    //TODO: that can be a method
    var prepareJson = {};
    prepareJson["password"] = password;
    prepareJson["email"] = email;

    String userJson = json.encode(prepareJson);
    print(userJson);

    final http.Response response = await http.post(
        'http://10.0.2.2:8080/login',
        headers:{'Content-Type': 'application/json'},
        body: userJson
    );


    String stringResponse = response.body;
    return stringResponse;

  }

  void autoLogIn() async {
    print("Auto-Login...");
    var userToken = await TokenController().retrieveToken("token");
    var isLoggedIn = await TokenController().retrieveToken("isLoggedIn");
    print(userToken);
    print(isLoggedIn);

    if (isLoggedIn == "Yes") {

      var prepareTokenJson = {};
      prepareTokenJson["authorization"]=userToken;
      String tokenJson=json.encode(prepareTokenJson);
      print(tokenJson);

      final http.Response response = await http.post(
          'http://10.0.2.2:8080/api/user/authByToken',
          headers:{'Content-Type': 'application/json','authorization':userToken}


      );
      print(response.statusCode);
      print(response.body);
      if(response.body == "Token Expired")
        {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      if(response.body=="Ok Credentials")
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()));
    }else {
      print("Failed to AutoLogin");
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()));
      }
  }
  }



