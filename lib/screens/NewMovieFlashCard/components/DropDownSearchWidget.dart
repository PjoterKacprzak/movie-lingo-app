



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_lingo_app/constants.dart';
import 'package:movie_lingo_app/model/Language.dart';
import 'package:movie_lingo_app/model/ScreenSizeConfig.dart';

class DropDownSearchWidget extends StatefulWidget {

  List<Language>_languageList;
  Function(Language) callback;
  Language _selectedCountry;
  DropDownSearchWidget(this._languageList, this.callback,this._selectedCountry);

  @override
  _DropDownSearchWidgetState createState() => _DropDownSearchWidgetState();
}

class _DropDownSearchWidgetState extends State<DropDownSearchWidget> {


  @override
  Widget build(BuildContext context) {
    print(widget._selectedCountry);
    return  DropdownSearch<Language>(
      selectedItem: widget._selectedCountry,

      hint: "Select language",
      mode: Mode.MENU,
      maxHeight: ScreenSizeConfig.blockSizeVertical * 56,

      items: widget._languageList,
      //showSearchBox: true,
      dropdownSearchDecoration: InputDecoration(
          filled: true,
          fillColor: darkBlueThemeColor),
      onChanged: (print){
        setState(() {
          widget.callback(print);
        });
      },
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );
  }

  Future<List<Language>> getGoogleSupportedLanguages() async {
    final http.Response response = await http
        .get('http://10.0.2.2:8080/translation-api/supported-languages');

    final jsonResponse = json.decode(response.body);

    return Language.fromJsonList(jsonResponse);
  }

  Widget _customDropDownExample(
      BuildContext context, Language item, String itemDesignation) {
    return Container(
      color: darkBlueThemeColor,
      child: (item?.language == null)
          ? setDefaultValue()
          : ListTile(
        title: Padding(
          padding: const EdgeInsets.all(0.0),
          child: AutoSizeText(item.language,maxLines: 1,textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,),
          ),
        ),
      ),
    );

  }


  Widget setDefaultValue()
  {
    Language temp = Language(language: 'English',languageCode: "en");
    // setState(() {
    //   widget._selectedCountry = temp;
    // });
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(0.0),
        child: AutoSizeText(temp.language,maxLines: 1,
        ),
      ),
      // softWrap: true,
    );
  }
  Widget _customPopupItemBuilderExample(
      BuildContext context, Language item, bool isSelected) {
    return Container(
      color:darkBlueThemeColor ,
     // margin: EdgeInsets.symmetric(horizontal: 33),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color:yellowTheemeColor),

      ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.language,maxLines: 1,
          style: TextStyle(fontSize: ScreenSizeConfig.safeBlockVertical*2,
            color: yellowTheemeColor
          ),
        ),
        // subtitle: Text(item.language.toString()),
      ),
    );
  }
}
