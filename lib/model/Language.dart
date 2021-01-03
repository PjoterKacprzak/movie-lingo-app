

class Language
{
  final String language;
  final String languageCode;

  Language({this.language,this.languageCode});


  factory Language.fromJson(Map<String,dynamic>json){

    return Language(
        language: json['name'],
        languageCode:json['code']);
  }

  static List<Language>fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Language.fromJson(item)).toList();
  }

  @override
  String toString() {
    return 'Language{ $language, $languageCode}';
  }
}


