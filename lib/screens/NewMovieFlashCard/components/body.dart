import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:movie_lingo_app/components/rounded_input_field.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          backgroundColor: Color(0xff0a043c),
          material: (_, __) => MaterialAppBarData(
            toolbarHeight: 0,
            leading: Container(
              width: 0,
              height: 50,
            ),
          ),
          cupertino: (_, __) => CupertinoNavigationBarData(),
        ),
        backgroundColor: Color(0xff0a043c),
        material: (_, __) => MaterialScaffoldData(),
        cupertino: (_, __) => CupertinoPageScaffoldData(
        ),
        body: Container(

          child: Center(
            child: Column(
              children: [
                SizedBox(height: ScreenSizeConfig.safeBlockVertical * 5,),
                RoundedInputField(
                  style: TextStyle(
                    color: beigeColor,
                  ),
                  hintText: "Enter Movie Name",
                ),
              ],
            ),
          ),

    ),
    );
  }
}


getSubtitles()
{

}