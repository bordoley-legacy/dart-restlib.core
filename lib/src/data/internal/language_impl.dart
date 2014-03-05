part of data.internal;

final Parser<Language> LANGUAGE =
  TOKEN.map((final String language) => 
      new LanguageImpl(language.toLowerCase()));

class LanguageImpl implements Language { 
  final String _language;
  
  const LanguageImpl (this._language);
  
  int get hashCode => _language.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if(other is Language) {
      return this.toString() == other.toString();
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