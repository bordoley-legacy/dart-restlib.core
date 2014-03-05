part of http;

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
            DataInternal.pairIterableToString(this.parameters));
  }
}

