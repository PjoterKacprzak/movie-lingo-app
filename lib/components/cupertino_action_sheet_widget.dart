//
//
//
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:movie_lingo_app/screens/NewFlashCard/new_flash_card.dart';
//
//
// class CupertinoActionSheetWidget extends StatefulWidget {
//   @override
//   _CupertinoActionSheetWidgetState createState() => _CupertinoActionSheetWidgetState();
// }
//
// class _CupertinoActionSheetWidgetState extends State<CupertinoActionSheetWidget> {
//
//
//   @override
//   void initState() {
//     super.initState();
//      WidgetsBinding.instance
//        .addPostFrameCallback((_) => actionSheetMethod(context));
//   }
//
//
//
//   var logger = Logger();
//
//    actionSheetMethod(BuildContext context) {
//
//     int index = 0;
//
//     showCupertinoModalPopup(
//         context: context,
//         builder: (context) {
//           return CupertinoActionSheet(
//             title: Text("Choose Option"),
//             cancelButton: CupertinoActionSheetAction(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Cancel"),
//             ),
//             actions: [
//               CupertinoActionSheetAction(
//                 onPressed: () {
//                     setState(() {
//                       index = 1;
//                     });
//
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => NewFlashCard()));
//
//
//                 },
//                 child: Text("Option 1"),
//               ),
//               CupertinoActionSheetAction(
//                 onPressed: () {},
//                 child: Text("Option 2"),
//               ),
//               CupertinoActionSheetAction(
//                 onPressed: () {},
//                 child: Text("Option 3"),
//               ),
//               CupertinoActionSheetAction(
//                 onPressed: () {},
//                 child: Text("Option 4"),
//               ),
//             ],
//           );
//         }
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             actionSheetMethod(context); },
//           tooltip: 'Increment',
//           child: Icon(Icons.add),
//           elevation: 2.0,
//         ),
//         body: Center(
//           child: _widgetOptions.elementAt(_selectedIndex),
//         ),
//         bottomNavigationBar: new Theme(
//           data: Theme.of(context).copyWith(
//             // sets the background color of the `BottomNavigationBar`
//               canvasColor: Color(0xffe3d8),
//               // sets the active color of the `BottomNavigationBar` if `Brightness` is light
//               primaryColor: Colors.red,
//               textTheme: Theme
//                   .of(context)
//                   .textTheme
//                   .copyWith(caption: new TextStyle(color: Color(0x0a043c)))),
//           // sets the inactive color of the `BottomNavigationBar`
//           child: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.search),
//                 label: 'Search',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.add),
//                 label: 'Add',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.account_circle_sharp),
//                 label: 'Profile',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             selectedItemColor: Colors.amber[800],
//             unselectedItemColor: Colors.black,
//             onTap: _onItemTapped,
//           ),
//         )
//     );
//   }
// }
