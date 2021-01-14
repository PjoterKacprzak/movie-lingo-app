import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movie_lingo_app/constants.dart';
import 'dart:convert';

import 'package:movie_lingo_app/controller/TokenController.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:movie_lingo_app/screens/MainPage/main_screen.dart';

import 'login_screen.dart';

class AutoLogin extends StatefulWidget {
  _AutoLoginState createState() => _AutoLoginState();
}

class _AutoLoginState extends State<AutoLogin> {

  Future myData;

  void initState() {
    myData = autoLogIn();
    super.initState();


  }




  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Scaffold(
      backgroundColor: darkBlueThemeColor,
      body: FutureBuilder(
          future: myData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == 200) {
                return MainScreen();
              } else {
                //TokenController().deleteToken("token");
                return LoginScreen();
              }
            } else if (snapshot.hasError) {
              return LoginScreen();
            } else {
              return Container(
                  height:30,
                  width:30,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
              return LoginScreen();
            }
          }),
    );
  }

  Future<int> autoLogIn() async {
    print("Auto-Login...");
    var userToken = await TokenController().retrieveToken("token");
    var isLoggedIn = await TokenController().retrieveToken("isLoggedIn");
    print(userToken);
    print(isLoggedIn);

    if (isLoggedIn == "Yes") {
      var prepareTokenJson = {};
      prepareTokenJson["authorization"] = userToken;
      String tokenJson = json.encode(prepareTokenJson);
      print(tokenJson);

      final http.Response response = await http
          .post('http://10.0.2.2:8080/api/user/authByToken', headers: {
        'Content-Type': 'application/json',
        'authorization': userToken
      });
          return response.statusCode;

    }
    return 0;
  }

}
