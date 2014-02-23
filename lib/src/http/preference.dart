part of restlib.core.http;

abstract class Preference<T extends Matcheable<T>> {
  static Option/*<T>*/ bestMatch(Iterable<Preference/*<T>*/> preferred, Iterable/*<T>*/ available) {
    int prefScore = 0;
    var bestMatch = null;

    preferred.forEach((final Preference/*<T>*/ pref) =>
        available.forEach((var t) {
          final int score = pref.value.match(t) * pref.qualityFactor ~/ 1000;
          if (score > prefScore) {
            prefScore = score;
            bestMatch = t;
          }
        }));

    return new Option(bestMatch);
  }

  factory Preference(
      final T value,
      {final int qualityFactor: 1000, final Multimap<String, String, dynamic> parameters: EMPTY_SEQUENCE_MULTIMAP}) =>
      new _Preference(checkNotNull(value), checkNotNull(qualityFactor), checkNotNull(parameters));

  T get value;
  int get qualityFactor;
  Multimap<String, String, dynamic> get parameters;
}

class _Preference<T extends Matcheable<T>> implements Preference<T> {
  final T value;
  final int qualityFactor;
  final Multimap<String, String, dynamic> parameters;

  _Preference(this.value, this.qualityFactor, this.parameters);

  int get hashCode =>
      computeHashCode([value, qualityFactor, parameters]);

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Preference) {
      Preference that = other;
      return this.value == that.value &&
          this.qualityFactor == that.qualityFactor &&
          this.parameters == that.parameters;
    } else {
      return false;
    }
  }

  String toString() {
    String qf =
        (qualityFactor == 1000) ? 1.toString() :
          (qualityFactor == 0) ? 0.toString() :
            (qualityFactor / 1000).toStringAsFixed(3);

    return "${value}; q=${qf}" +
        (parameters.isEmpty ? "" : "; " +
            pairIterableToString(this.parameters));
  }
}

Parser<Preference> _preferenceParser(final Parser<Matcheable> valueParser) {
    final Parser<Iterable<KeyValuePair>> KEY_VALUE_PAIRS =
        (OWS_SEMICOLON_OWS + KVP.sepBy1(OWS_SEMICOLON_OWS))
             .map((final Iterable e) =>
                 e.elementAt(1))
             .orElse([]);

    final Parser<int> FRACTIONAL_PART =
        (PERIOD + DIGIT + DIGIT.orElse(0) + DIGIT.orElse(0))
          .map((final Iterable e){
            final int _100s = e.elementAt(1) * 100;
            final int _10s = e.elementAt(2) * 10;
            final int _1s = e.elementAt(3);

            return _100s + _10s + _1s;
          }).orElse(0);

    final Parser<int> QF_PARSER =
        (DIGIT + FRACTIONAL_PART).map((final Iterable<int> e){
          final int _1000s = e.elementAt(0) * 1000;
          final int retval = _1000s + e.elementAt(1);

          if (retval > 1000) {
            return null;
          }
          return retval;
        });

    return (valueParser + KEY_VALUE_PAIRS)
      .map((final Iterable e) {
        final Matcheable value = e.elementAt(0);
        final Iterable<KeyValuePair> parameters = e.elementAt(1);

        if (parameters.isEmpty) {
          return new Preference(value);
        }

        final KeyValuePair qfPair = parameters.first;
        if (qfPair.fst.toLowerCase() != "q") {
          return null;
        }

        final Option<int> qfValue = QF_PARSER.parse(qfPair.snd);
        if (qfValue.isEmpty) {
          return null;
        }

        return new Preference(value, qualityFactor: qfValue.value, parameters: EMPTY_SEQUENCE_MULTIMAP.putAll(parameters.skip(1)));
      });
  }