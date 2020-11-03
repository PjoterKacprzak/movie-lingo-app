
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
import 'package:movie_lingo_app/screens/Welcome/MainPage/main_screen.dart';
import '../../Signup/signup_screen.dart';
import 'background.dart';

//TODO:Input Validation
class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);


  @override
  _BodyState createState() =>  _BodyState();
}

class  _BodyState extends State<Body> {

  bool isLoggedIn = false;

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
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
                TokenController().saveToken(token);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
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


    //TODO: that can be a method
    var userXml = {};
    userXml["name"] = '';
    userXml["lastName"] = '';
    userXml["password"] = password;
    userXml["telephoneNumber"] = '';
    userXml["email"] = email;
    userXml["profilePhoto"] = '';
    userXml["createdAt"]= '';
    userXml["role"]= '';
    String userJson = json.encode(userXml);
    print(userJson);

    final http.Response response = await http.post(
        'http://10.0.2.2:8080/api/user/login',
        headers:{'Content-Type': 'application/json'},
        body: userJson
    );
    setState(() {
      isLoggedIn = true;
    });

    String stringResponse = response.body;
    return stringResponse;

  }

  void autoLogIn() async {

    var userToken = await TokenController().retrieveToken("token");
    print(userToken);
    if (userToken != null) {
      setState(() {
        isLoggedIn = true;
      });
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()));
    }else
      {
        //isLoggedIn=false;
      }
  }
  }



