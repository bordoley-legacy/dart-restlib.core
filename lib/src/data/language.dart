part of restlib.core.data;

abstract class Language implements Matcheable<Language> { 
  static const ANY = const LanguageImpl("*");
}