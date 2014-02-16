part of restlib.core.data;

final Parser<String> _BASE64_DATA =
  BASE64.followedBy((OWS + COMMA) ^ EOF);

final Parser<ChallengeMessage> CHALLENGE_MESSAGE =
  (TOKEN + SP.many1() + (_BASE64_DATA ^ KVP.optional().sepBy1(OWS_COMMA_OWS)))
    .map((final Iterable e) {
      final String scheme = e.elementAt(0);
      return e.elementAt(2).fold(
          (final String base64) => 
              new Base64ChallengeMessage._internal(scheme, base64),
          (final Iterable<Option<KeyValuePair>> pairs) => 
              new ParametersChallengeMessage._internal(
                  scheme, 
                  EMPTY_DICTIONARY.putAll(
                      pairs
                        .where((final Option<KeyValuePair> optionalPair) => 
                            optionalPair.isNotEmpty)
                        .map((final Option<KeyValuePair> optionalPair) => 
                            optionalPair.value))));
    });

abstract class ChallengeMessage {    
  String get scheme;
}

class Base64ChallengeMessage implements ChallengeMessage {
  final String data;
  final String scheme;
  
  const Base64ChallengeMessage._internal(this.scheme, this.data);
  
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

class ParametersChallengeMessage implements ChallengeMessage {
  final Dictionary<String, String> parameters;
  final String scheme;
  
  const ParametersChallengeMessage._internal(this.scheme, this.parameters);

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
        if(entry.snd.isEmpty) {
          return entry.fst;
        } else if(entry.fst == "realm") {
          return "${entry.fst}=\"${encodeQuotedString(entry.snd)}\"";
        } else {
          return "${entry.fst}=${encodeWord(entry.snd)}";
        }
      }).join(", ");
}