part of data;

abstract class Language implements Matcheable<Language> {
  static final Parser<Language> parser = LANGUAGE;
  static const ANY = const LanguageImpl("*");
}