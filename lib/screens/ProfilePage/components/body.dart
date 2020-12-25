import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_lingo_app/controller/TokenController.dart';
import 'package:movie_lingo_app/model/User.dart';
import 'package:movie_lingo_app/screens/AboutApp/about_app_screen.dart';
import 'package:movie_lingo_app/screens/Login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:movie_lingo_app/screens/PasswordChange/password_change_screen.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {


  User _loggedUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future : getUserInformation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return  Container(
                color: Color(0xff0a043c),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.08),
                      ClipOval(
                        // borderRadius: BorderRadius.circular(15.0),
                        // clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            'assets/images/avatar.png',
                            // width: size.width * 0.6,
                            // height: size.height * 0.3,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(height: size.height * 0.01),
                      Text(snapshot.data.userName+' '+ snapshot.data.userLastName,
                          style: TextStyle(
                              fontSize: size.height * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(height: size.height * 0.06),
                      Container(
                        width: double.infinity,
                        height: size.height * 0.06,
                        color: Color(0xffffe3d8),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Stack(alignment: Alignment.centerLeft, children: [
                                Text("E-mail"),
                                Center(
                                  child: Text(snapshot.data.userEmail),
                                ),
                                Positioned(
                                  right: 6,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: size.height * 0.02,
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        width: double.infinity,
                        height: size.height * 0.06,
                        color: Color(0xffffe3d8),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Stack(alignment: Alignment.centerLeft, children: [
                                Text("Nickname"),
                                Center(
                                  child: Text(snapshot.data.userName+' '+ snapshot.data.userLastName),
                                ),
                                Positioned(
                                  right: 6,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: size.height * 0.02,
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {

                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => PasswordChange()));
                        },
                        child:Container(
                          width: double.infinity,
                          height: size.height * 0.06,
                          color: Color(0xffffe3d8),
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Stack(alignment: Alignment.centerLeft, children: [
                                  Text("Password"),
                                  Center(
                                    child: Text("*********"),
                                  ),
                                  Positioned(
                                    right: 6,
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: size.height * 0.02,
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                      ),


                      SizedBox(height: size.height * 0.03),

                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {

                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => AboutApp()));
                        },
                        child: Container(
                        width: double.infinity,
                        height: size.height * 0.06,
                        color: Color(0xffffe3d8),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Stack(alignment: Alignment.centerLeft, children: [
                                Text("About MovieLingo"),
                                Positioned(
                                  right: 6,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: size.height * 0.02,
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                      ),

                      SizedBox(height: size.height * 0.03),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {

                          Container(
                              child: _showCupertinoDialog());
                        },
                        child: Container(
                          width: double.infinity,
                          height: size.height * 0.06,
                          color: Color(0xffffe3d8),
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child:
                                Stack(alignment: Alignment.centerLeft, children: [
                                  Text(
                                    "Log Out",
                                    style: TextStyle(
                                        color: Colors.red, fontWeight: FontWeight.bold),
                                  ),
                                  Positioned(
                                    right: 6,
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: size.height * 0.02,
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ));;
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
        });

  }

  _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Log Out"),
              content: new Text("Do you accept ?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    TokenController().deleteToken("token");

                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }


  void getUser()async{
   // _loggedUser = await getUserInformation(await TokenController().retrieveToken("token"));
    print( "Logged  $_loggedUser");
    print(_loggedUser.userEmail);

  }

}
Future<User> getUserInformation()
async {

  String token = await TokenController().retrieveToken("token");

  final http.Response response = await http.post(
      'http://10.0.2.2:8080/api/user/user-information',
      headers:{'Content-Type': 'application/json',
        'authorization': token
      });

  print("My response $response.body");

  return User.fromJson(json.decode(response.body));

}
