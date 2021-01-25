import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:movie_lingo_app/components/rounded_password_field.dart';
import 'package:movie_lingo_app/controller/TokenController.dart';
import 'package:movie_lingo_app/screens/AboutApp/components/background.dart';
import 'package:passwordfield/passwordfield.dart';

import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {




  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var logger = Logger();
  final TextEditingController _newPasswordController =
  new TextEditingController();
  final TextEditingController _newConfirmPasswordController =
  new TextEditingController();

  TextEditingController _currentPasswordController =
  new TextEditingController();

  ButtonState stateTextWithIcon = ButtonState.idle;

  Widget buildTextWithIcon() {
    return ProgressButton.icon(
        iconedButtons: {
          ButtonState.idle: IconedButton(
              text: "Send",
              icon: Icon(Icons.send, color: Colors.white),
              color: Colors.deepPurple.shade500),
          ButtonState.loading:
          IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
          ButtonState.fail: IconedButton(
              text: "Failed",
              icon: Icon(Icons.cancel, color: Colors.white),
              color: Colors.red.shade300),
          ButtonState.success: IconedButton(
              text: "Success",
              icon: Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              color: Colors.green.shade400)
        },
        onPressed: () async {
          await onPressedIconWithText();
          FocusScope.of(context).requestFocus(FocusNode());

          if (stateTextWithIcon == ButtonState.success) {
            Future.delayed(Duration(seconds: 1), () {
              logger.d("Logger is working!");
              Navigator.pop(context);
            });
          }
        },
        state: stateTextWithIcon);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundedPasswordField(
                    controller: _currentPasswordController,
                    hintText: 'old password',
                  ),
                  RoundedPasswordField(
                    controller:  _newPasswordController,
                    hintText: 'new password',
                  ),
                  RoundedPasswordField(
                    controller: _newConfirmPasswordController,
                    hintText: 'confirm new password',
                  ),
                  buildTextWithIcon(),
                ],
              ),
            )));
  }

  Future<void> onPressedIconWithText() async {
    http.Response response;
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        setState(() {
          stateTextWithIcon = ButtonState.loading;
        });

        response = await changePassword(
            _currentPasswordController.text, _newPasswordController.text);
        print(response.statusCode);
        if (response.statusCode == 200) {
          setState(() {
            stateTextWithIcon = ButtonState.success;
          });
          break;
        } else {
          stateTextWithIcon = ButtonState.fail;
          break;
        }

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }

  Future<http.Response> changePassword(String oldPassword,
      String newPassword) async {
    String token = await TokenController().retrieveToken("token");

    var newJson = {};

    newJson["oldPassword"] = oldPassword;
    newJson["newPassword"] = newPassword;

    String passwordJson = json.encode(newJson);

    print(passwordJson);
    final http.Response response = await http.patch(
        'http://10.0.2.2:8080/api/user/change-password',
        headers: {'Content-Type': 'application/json', 'authorization': token},
        body: passwordJson);

    print("Change password status code = $response.statusCode");

    return response;
  }
}
