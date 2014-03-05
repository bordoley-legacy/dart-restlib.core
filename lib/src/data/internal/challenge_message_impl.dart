part of data.internal;

final Parser<String> _BASE64_DATA =
  BASE64.followedBy((OWS + COMMA) ^ EOF);

final Parser<ChallengeMessage> CHALLENGE_MESSAGE =
  (TOKEN + SP.many1() + (_BASE64_DATA ^ KVP.optional().sepBy1(OWS_COMMA_OWS)))
    .map((final Iterable e) {
      final String scheme = e.elementAt(0);
      return e.elementAt(2).fold(
          (final String base64) =>
              new _Base64ChallengeMessage._internal(scheme, base64),
          (final Iterable<Option<KeyValuePair>> pairs) =>
              new _ParametersChallengeMessage._internal(
                  scheme,
                  EMPTY_DICTIONARY.putAll(
                      pairs
                        .where((final Option<KeyValuePair> optionalPair) =>
                            optionalPair.isNotEmpty)
                        .map((final Option<KeyValuePair> optionalPair) =>
                            optionalPair.value))));
    });


class _Base64ChallengeMessage implements Base64ChallengeMessage {
  final String data;
  final String scheme;

  _Base64ChallengeMessage._internal(this.scheme, this.data);

  int get hashCode => computeHashCode([scheme, data]);

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Base64ChallengeMessage) {
      return this.scheme == other.scheme  &&
          this.data == other.data;
    } else {
      return false;
    }
  }

  String toString() =>
      "$scheme $data";
}

class _ParametersChallengeMessage implements ParametersChallengeMessage {
  final Dictionary<String, String> parameters;
  final String scheme;

  const _ParametersChallengeMessage._internal(this.scheme, this.parameters);

  int get hashCode => computeHashCode([scheme, parameters]);

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ParametersChallengeMessage) {
      return this.scheme == other.scheme  &&
          this.parameters == other.parameters;
    } else {
      return false;
    }
  }

  String toString() =>
      scheme + " " + parameters.map((final Pair<String, String> entry) {
        if(entry.e1.isEmpty) {
          return entry.e0;
        } else if(entry.e0 == "realm") {
          return "${entry.e0}=\"${encodeQuotedString(entry.e1)}\"";
        } else {
          return "${entry.e0}=${encodeWord(entry.e1)}";
        }
      }).join(", ");
}