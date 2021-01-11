import 'package:flutter/material.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'screens/Login/auto_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Movie Lingo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: AutoLogin()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void state() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
    );
  }
}
