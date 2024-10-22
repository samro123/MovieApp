enum LanguageType{ENGLISH, VIETNAME}

const String ENGLISH = "en";
const String VIETNAME = "vi";

extension LanguageTypeExtension on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.VIETNAME:
        return VIETNAME;
    }
  }
}