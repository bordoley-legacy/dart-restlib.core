part of data;


abstract class ChallengeMessage {
  static final Parser<ChallengeMessage> parser = CHALLENGE_MESSAGE;

  String get scheme;
}

abstract class Base64ChallengeMessage implements ChallengeMessage {
  String get data;
  String get scheme;
}

abstract class ParametersChallengeMessage implements ChallengeMessage {
  Dictionary<String, String> get parameters;
  String get scheme;
}