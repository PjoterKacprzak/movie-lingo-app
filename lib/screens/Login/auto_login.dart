// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:movie_lingo_app/controller/TokenController.dart';
//
// class AutoLogin extends StatefulWidget {
//   _AutoLoginState createState() => _AutoLoginState();
// }
//
// class _AutoLoginState extends State<AutoLogin> {
//   void initAutoLogin() {
//     setState(() async {
//       _token = await TokenController().retrieveToken("token");
//       print("Token after retriving $_token");
//     });
//   }
//
//   bool isLoggedIn = false;
//   String _token;
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: autoLogin(_token),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             if (snapshot.data == 200) {
//               return Scaffold( body: Text("Gitówa"),
//               );
//             } else {
//               return Scaffold(
//               );
//             }
//           } else if (snapshot.hasError) {
//             return Icon(Icons.error_outline);
//           } else {
//             return CircularProgressIndicator();
//           }
//         });
//   }
//
//   Future<int> autoLogin(String token) async {
//     var prepareJson = {};
//     prepareJson["token"] = token;
//
//     String tokenJson = json.encode(prepareJson);
//
//     final http.Response response = await http.post(
//         'http://10.0.2.2:8080/auto-login',
//         headers: {'Content-Type': 'application/json'},
//         body: tokenJson);
//
//     return response.statusCode;
//   }
// }
