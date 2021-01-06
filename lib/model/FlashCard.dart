


class FlashCard
{
  final String sourceWord;
  final String translatedWord;

  FlashCard({this.sourceWord, this.translatedWord});


  factory FlashCard.fromJson(dynamic json) {
    return FlashCard(
        sourceWord:json['sourceWord'] as String,
        translatedWord:json['translatedWord'] as String);
  }



  Map toJson() => {
    'sourceWord': sourceWord,
    'translatedWord': translatedWord,
  };

  @override
  String toString() {
    return 'FlashCard{ $sourceWord, $translatedWord}';
  }
}


