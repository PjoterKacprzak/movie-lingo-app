



import 'package:movie_lingo_app/model/FlashCard.dart';

class UserFlashCardSheet{

    int id;
   String email;
   String flashCardName;
   String sourceLanguage;
   String targetLanguage;
   List<FlashCard> flashCards;


   UserFlashCardSheet({this.id,this.email, this.flashCardName, this.sourceLanguage,
       this.targetLanguage,this.flashCards});


   factory UserFlashCardSheet.fromJson(dynamic json) {
     if (json['flashCards'] != null) {
       var tagObjsJson = json['flashCards'] as List;
       List<FlashCard> _flashCards = tagObjsJson.map((tagJson) => FlashCard.fromJson(tagJson)).toList();

       return UserFlashCardSheet(
           id:json['id'],
           email:json['email'] as String,
           flashCardName:json['flashCardName'] as String,
           sourceLanguage:json['sourceLanguage'] as String,
           targetLanguage:json['targetLanguage'] as String,
            flashCards:_flashCards
       );
     } else {
       return UserFlashCardSheet(
         id:json['id'],
         email:json['email'] as String,
         flashCardName:json['flashCardName'] as String,
         sourceLanguage:json['sourceLanguage'] as String,
         targetLanguage:json['targetLanguage'] as String,
          // flashCards:_flashCards
       );
     }
   }

         Map toJson() {
       List<Map> flashCards =
       this.flashCards != null ? this.flashCards.map((i) => i.toJson()).toList() : null;
       return {
         'email': email,
         'flashCardName': flashCardName,
         'sourceLanguage': sourceLanguage,
         'targetLanguage': targetLanguage,
         'flashCards': flashCards
       };
     }

     void addFlashCard(String word, String translatedWord)
     {
       flashCards.add(FlashCard(sourceWord:word, translatedWord:translatedWord));
     }

    @override
  String toString() {
    return 'UserFlashCardSheet{id: $id, email: $email, flashCardName: $flashCardName, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, flashCards: $flashCards}';
  }
}
