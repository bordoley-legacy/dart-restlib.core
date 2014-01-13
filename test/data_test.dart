library restlib.data_test;

import "package:restlib_common/collections.dart";
import "package:restlib_testing/testing.dart";

import "package:restlib_core/data.dart";

import "package:unittest/unittest.dart";

part "src/data/cache_directive_test.dart";
part "src/data/challenge_message_test.dart";
part "src/data/comment_test.dart";
part "src/data/media_range_test.dart";
part "src/data/user_agent_test.dart";

dataTests() {
  test("KVP",(){
    expect(KVP.parse("realm=\"foo\"").value, equals(new Pair("realm", "foo")));
  });
}

dataTestGroups() {
  group("properties Data", dataTests);
  group("class CacheDirective", cacheDirectiveTests);
  group("class ChallengeMessage", challengeMessageTests);
  group("class Comment", commentTests);
  group("class MediaRange", mediaRangeTests);
  group("class UserAgent", userAgentTests);
}

main() {
  dataTestGroups();
}