



import 'package:movie_lingo_app/model/FlashCard.dart';

class UserFlashCardSheet{

   String email;
   String flashCardName;
   String sourceLanguage;
   String targetLanguage;
   List<FlashCard> flashCards;

   UserFlashCardSheet(this.email, this.flashCardName, this.sourceLanguage,
       this.targetLanguage, this.flashCards);



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
    flashCards.add(FlashCard(word, translatedWord));
  }

   @override
  String toString() {
    return 'UserFlashCardSheet{email: $email, flashCardName: $flashCardName, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, flashCards: $flashCards}';
  }
}