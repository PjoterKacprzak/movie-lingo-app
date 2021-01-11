import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/controller/TokenController.dart';
import 'package:http/http.dart' as http;
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';
import 'package:movie_lingo_app/model/UserFlashCardSheet.dart';
import 'package:movie_lingo_app/screens/EditFlashCard/edit_flash_card.dart';
import 'package:movie_lingo_app/screens/_StudyScreens/SlideStudyScreen/slide_study_screen.dart';

import 'HorizontalListItem.dart';
import 'VerticalListItem.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Future cards;

  List<UserFlashCardSheet> _items;
  SlidableController slidableController;
  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  @protected
  void initState() {
    fetchData();
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    super.initState();
  }

void fetchData()async{
    setState(() {
      cards = getCards();
    });
}
  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueThemeColor,
      body: Center(
        child: FutureBuilder(
              future: cards,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return OrientationBuilder(
                    builder: (context, orientation) => _buildList(
                        context,
                        orientation == Orientation.portrait
                            ? Axis.vertical
                            : Axis.horizontal),
                  );
                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      padding: EdgeInsets.only(
          top: ScreenSizeConfig.blockSizeVertical *8),
      scrollDirection: direction,
      itemBuilder: (context, index) {
        final Axis slidableDirection =
            direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
        return _getSlidableWithDelegates(context, index, slidableDirection);
      },
      itemCount: _items.length,
    );
  }

  Widget _getSlidableWithLists(
      BuildContext context, int index, Axis direction) {
    final UserFlashCardSheet item = _items[index];
    //final int t = index;
    return Slidable(
      key: Key(item.flashCardName),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          _showSnackBar(
              context,
              actionType == SlideActionType.primary
                  ? 'Dismiss Archive'
                  : 'Dismiss Delete');
          setState(() {
            _items.removeAt(index);
          });
        },
      ),
      actionPane: _getActionPane(4),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? VerticalListItem(_items[index])
          : HorizontalListItem(_items[index]),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => _showSnackBar(context, 'Archive'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => _showSnackBar(context, 'Share'),
        ),
      ],
      secondaryActions: <Widget>[
        Container(
          height: 800,
          color: Colors.green,
          child: Text('Edit'),
        ),
        IconSlideAction(
          caption: 'More',
          color: Colors.grey.shade200,
          icon: Icons.more_horiz,
          onTap: () => _showSnackBar(context, 'More'),
          closeOnTap: false,
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _showSnackBar(context, 'Delete'),
        ),
      ],
    );
  }

  static Widget _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }

  Widget _getSlidableWithDelegates(
      BuildContext context, int index, Axis direction) {
    final UserFlashCardSheet item = _items[index];

    return Slidable.builder(
      key: Key(item.flashCardName),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        closeOnCanceled: true,
        onWillDismiss: (actionType) {
          return showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Delete'),
                content: Text('Item will be deleted'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (actionType) {
          _showSnackBar(
              context,
              actionType == SlideActionType.primary
                  ? 'Dismiss Archive'
                  : 'Dismiss Delete');
          setState(() {
            _items.removeAt(index);
          });
        },
      ),
      actionPane: _getActionPane(1),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? VerticalListItem(_items[index])
          : HorizontalListItem(_items[index]),
      actionDelegate: SlideActionBuilderDelegate(
          actionCount: 2,
          builder: (context, index, animation, renderingMode) {
            if (index == 0) {
              return IconSlideAction(
                caption: 'Study',
                color: renderingMode == SlidableRenderingMode.slide
                    ? Colors.blue.withOpacity(animation.value)
                    : (renderingMode == SlidableRenderingMode.dismiss
                        ? Colors.blue
                        : Colors.green),
                icon: Icons.school,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SlideStudyScreen(item)));
                },
              );
            } else {
              return IconSlideAction(
                caption: 'Edit',
                color: renderingMode == SlidableRenderingMode.slide
                    ? Colors.indigo.withOpacity(animation.value)
                    : Colors.indigo,
                icon: Icons.edit,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditFlashCard(item)));
                      }
              );
            }
          }),
      secondaryActionDelegate: SlideActionBuilderDelegate(
          actionCount: 2,
          builder: (context, index, animation, renderingMode) {
            if (index == 0) {
              return IconSlideAction(
                caption: 'Study',
                color: renderingMode == SlidableRenderingMode.slide
                    ? Colors.grey.shade200.withOpacity(animation.value)
                    : Colors.grey.shade200,
                icon: Icons.more_horiz,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SlideStudyScreen(item)));
                    },

                closeOnTap: false,
              );
            } else {
              return IconSlideAction(
                caption: 'Delete',
                color: renderingMode == SlidableRenderingMode.slide
                    ? Colors.red.withOpacity(animation.value)
                    : Colors.red,
                icon: Icons.delete,
                onTap: () => _showSnackBar(context, 'Delete'),
              );
            }
          }),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));

  }

  Future<void> getCards() async {
    final token = await TokenController().retrieveToken("token");

    final http.Response response = await http.get(
        'http://10.0.2.2:8080//api/user/get-card-by-user',
        headers: {'Content-Type': 'application/json', 'Authorization': token});

    Iterable l = json.decode(response.body);
    List<UserFlashCardSheet> cards = List<UserFlashCardSheet>.from(
        l.map((model) => UserFlashCardSheet.fromJson(model)));
    setState(() {
      _items = cards;
    });

    return cards;
  }
}
