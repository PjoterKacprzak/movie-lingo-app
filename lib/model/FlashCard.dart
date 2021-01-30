


class FlashCard
{
  final String sourceWord;
  final String translatedWord;
  final int sourceWordFrequencyValue;

  FlashCard({this.sourceWord, this.translatedWord,this.sourceWordFrequencyValue});


  factory FlashCard.fromJson(dynamic json) {
    return FlashCard(
        sourceWord:json['sourceWord'] as String,
        translatedWord:json['translatedWord'] as String,
        sourceWordFrequencyValue:json['sourceWordFrequencyValue'] as int);
  }



  Map toJson() => {
    'sourceWord': sourceWord,
    'translatedWord': translatedWord,
    'sourceWordFrequencyValue' : sourceWordFrequencyValue
  };

  @override
  String toString() {
    return 'FlashCard{ $sourceWord, $translatedWord, $sourceWordFrequencyValue}';
  }
}


