part of restlib.core.data;

final Parser<Language> LANGUAGE =
  TOKEN.map((final String language) => 
      new Language._internal(language.toLowerCase()));

class Language implements Matcheable<Language> { 
  static const ANY = const Language._internal("*");
  
  final String _language;
  
  const Language._internal (this._language);
  
  int get hashCode => computeHashCode([_language]);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if(other is Language) {
      return this._language == other._language;
    } else {
      return false;
    }
  }
  
  int match(final Language that) {
    if (this == that) {
      return 1000;
    } else if (this == Language.ANY) {
      return 500;
    } else {
      return 0;
    }
  }
  
  String toString() => _language;
}