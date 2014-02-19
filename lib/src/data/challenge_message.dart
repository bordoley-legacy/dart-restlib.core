part of restlib.core.data;


abstract class ChallengeMessage {
  static ChallengeMessage parse(final String challengeMessage) =>
      CHALLENGE_MESSAGE.parseValue(challengeMessage);

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