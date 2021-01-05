


class FlashCard
{
  final String sourceWord;
  final String translatedWord;

  FlashCard(this.sourceWord, this.translatedWord,);


  Map toJson() => {
    'sourceWord': sourceWord,
    'translatedWord': translatedWord,
  };

  @override
  String toString() {
    return 'FlashCard{ $sourceWord, $translatedWord}';
  }
}


