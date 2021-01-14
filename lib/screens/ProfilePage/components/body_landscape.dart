import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_alert/flutter_alert_cupertino.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/controller/TokenController.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:movie_lingo_app/model/User.dart';
import 'package:movie_lingo_app/screens/AboutApp/about_app_screen.dart';
import 'package:movie_lingo_app/screens/Login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:movie_lingo_app/screens/PasswordChange/password_change_screen.dart';
import 'package:movie_lingo_app/screens/ProfilePage/components/background.dart';

class BodyLandscape extends StatefulWidget {

  @override
  _BodyLandscapeState createState() => _BodyLandscapeState();
}

class _BodyLandscapeState extends State<BodyLandscape> {


  User _loggedUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future : getUserInformation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Background(
                child: Padding(
                  padding:EdgeInsets.only(
                      left: ScreenSizeConfig.blockSizeHorizontal * 8,
                      right: ScreenSizeConfig.blockSizeHorizontal * 6,
                      top: ScreenSizeConfig.blockSizeVertical * 6,
                      bottom: ScreenSizeConfig.blockSizeVertical * 6,
                  ),
                  child: Center(
              child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                            child: Image.asset(
                              'assets/images/avatar.png',
                              // width: size.width * 0.6,
                              // height: size.height * 0.3,
                              width: ScreenSizeConfig.blockSizeHorizontal * 20,
                              height: ScreenSizeConfig.blockSizeVertical * 40,
                              fit: BoxFit.cover,
                            )),
                        SizedBox( height: ScreenSizeConfig.blockSizeVertical *2),
                        Text(snapshot.data.userLoginName,
                            style: TextStyle(
                                fontSize:  ScreenSizeConfig.blockSizeHorizontal * 3,
                                fontWeight: FontWeight.bold,
                                color: yellowTheemeColor),
                        )
                      ],
                    ),
                    SizedBox(width: ScreenSizeConfig.blockSizeHorizontal * 6,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width:  ScreenSizeConfig.blockSizeHorizontal * 50,
                          height: ScreenSizeConfig.blockSizeVertical * 10,
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
                        SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
                        Container(
                          width:  ScreenSizeConfig.blockSizeHorizontal * 50,
                          height: ScreenSizeConfig.blockSizeVertical * 10,
                          color: Color(0xffffe3d8),
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Stack(alignment: Alignment.centerLeft, children: [
                                  Text("Nickname"),
                                  Center(
                                    child: Text(snapshot.data.userLoginName),
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
                        SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {

                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => PasswordChange()));
                          },
                          child:Container(
                            width:  ScreenSizeConfig.blockSizeHorizontal * 50,
                            height: ScreenSizeConfig.blockSizeVertical * 10,
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
                        SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {

                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => AboutApp()));
                          },
                          child: Container(
                            width:  ScreenSizeConfig.blockSizeHorizontal * 50,
                            height: ScreenSizeConfig.blockSizeVertical * 10,
                            color: Color(0xffffe3d8),
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Stack(alignment: Alignment.center, children: [
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
                        SizedBox(height: ScreenSizeConfig.blockSizeVertical * 1),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {_showDialog(context);
                          },
                          child: Container(
                            width:  ScreenSizeConfig.blockSizeHorizontal * 50,
                            height: ScreenSizeConfig.blockSizeVertical * 10,
                            color: Color(0xffffe3d8),
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child:
                                  Stack(alignment: Alignment.center, children: [
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
                    )

                  ],
              ),
            ),
                ));
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  _showCupertinoDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
          title: new AutoSizeText("Log Out"),
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
              child: AutoSizeText('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }
  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Log Out"),
          content: new Text("Do you accept ?"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Yes"),
              onPressed:  () {
                TokenController().deleteToken("token");

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            CupertinoDialogAction(
              onPressed: (){  Navigator.of(context).pop();},
              child: Text("No"),
            )
          ],
        )
    );
    // showAlert(
    //   context: context,
    //   title: "Log Out",
    //   body: "Do you accept ?",
    //   actions: [
    //     AlertAction(
    //       text: "Yes",
    //       isDestructiveAction: true,
    //       onPressed: () {
    //         TokenController().deleteToken("token");
    //
    //         Navigator.push(
    //             context, MaterialPageRoute(builder: (context) => LoginScreen()));
    //       },
    //     ),
    //   ],
    //   cancelable: true,
    // );
    // CupertinoAlertDialog(
    //   title: new Text("Dialog Title"),
    //   content: new Text("This is my content"),
    //   actions: <Widget>[
    //     CupertinoDialogAction(
    //       isDefaultAction: true,
    //       child: Text("Yes"),
    //     ),
    //     CupertinoDialogAction(
    //       child: Text("No"),
    //     )
    //   ],
    // );
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
