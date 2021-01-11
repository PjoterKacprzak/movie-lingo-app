import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:movie_lingo_app/screens/DisplayCards/display_cards.dart';
import 'package:movie_lingo_app/screens/MainPage/main_screen.dart';
import 'package:movie_lingo_app/screens/NewFlashCardRemake/NewFlashCardRemake.dart';
import 'package:movie_lingo_app/screens/NewMovieFlashCard/new_movie_flash_card.dart';
import 'package:movie_lingo_app/screens/ProfilePage/profile_screen.dart';

class Body extends StatefulWidget {
  Body({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of first screen

  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.home,
    Icons.add,
    Icons.search,
    Icons.account_circle_sharp,
  ];

  final iconText = <String>[
    "Home",
    "Soon",
    "Your Cards",
    "Profile",
  ];

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkBlueThemeColor,
      extendBody: true,
      body: NavigationScreen(
        _bottomNavIndex,
      ),
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor: yellowTheemeColor,
          child: Icon(
            Icons.add,
            color: HexColor('#373A36'),
          ),
          onPressed: () {
            actionSheetMethod(context);
            _animationController.reset();
            _animationController.forward();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? HexColor('#FFA400') : beigeColor;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: ScreenSizeConfig.blockSizeHorizontal + 17,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  iconText[index],
                  maxLines: 1,
                  style: TextStyle(color: color),
                  group: autoSizeGroup,
                ),
              )
            ],
          );
        },
        backgroundColor:Colors.black,
        activeIndex: _bottomNavIndex,
        splashColor: beigeColor,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }

  Widget actionSheetMethod(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text("Choose Option"),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  // setState(() {
                  //   _bottomNavIndex = 4;
                  // });

                 // Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewFlashCardRemake()));

                },
                child: Text("New flash card"),
              ),
               CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewMovieFlashCard()));
                },
                child: Text("New movie flash card"),
              ),
              CupertinoActionSheetAction(
                onPressed: () {},
                child: Text("Option 3"),
              ),
              CupertinoActionSheetAction(
                onPressed: () {},
                child: Text("Option 4"),
              ),
            ],
          );
        });
  }
}

class NavigationScreen extends StatefulWidget {
  final int screen;

  NavigationScreen(this.screen) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.screen != widget.screen) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: CircularRevealAnimation(
            animation: animation,
            centerOffset: Offset(80, 80),
            maxRadius: MediaQuery.of(context).size.longestSide * 1.6,
            child: chooseScreen(widget.screen)),
      ),
    );
  }

  Widget chooseScreen(int _bottomNavBar) {
    switch (_bottomNavBar) {
      case 0:
        {
          return Container(
            color: darkBlueThemeColor,
          );
        }
      case 1:
        {
          return Container(
              color: darkBlueThemeColor
          );
        }
      case 2:
        {
          return DisplayCards();
        }
      case 3:
        {
          return ProfilePage();
        }
      case 4:
        {
          return NewFlashCardRemake();
        }
      default:
        {
          return MainScreen();
        }
    }
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
