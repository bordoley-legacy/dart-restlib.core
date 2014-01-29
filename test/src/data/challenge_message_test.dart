part of restlib.data_test;

challengeMessageTests() {
  doTestParseWithParameters(String testCase, String scheme, Dictionary<String, String> parameters){
    test("parsing: $testCase", () {
      ChallengeMessage message = CHALLENGE_MESSAGE.parse(testCase).value;
      expect(message, predicate((e) => e is ParametersChallengeMessage, "is ParametersChallengeMessage"));
      expect(message.scheme, equals(scheme));
      expect((message as ParametersChallengeMessage).parameters, equals(parameters));
    });
  }
  
  doTestParseWithInvalid(String testCase) {
    test("parsing invalid: $testCase", () {
      expect(!CHALLENGE_MESSAGE.parse(testCase).isEmpty, isFalse);
    });
  }
    
  doTestParseWithParameters("Basic realm=\"foo\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "foo"}));
    
  // Technically should fail per spec
  doTestParseWithParameters("Basic realm=foo", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "foo"}));
    
  doTestParseWithParameters("Basic , realm=\"foo\"", "Basic", Persistent.EMPTY_DICTIONARY.put("realm", "foo"));
    
  doTestParseWithParameters("Basic realm = \"foo\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "foo"}));
  doTestParseWithParameters("Basic realm = \"\\f\\o\\o\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "foo"}));
  doTestParseWithParameters("Basic realm=\"\\\"foo\\\"\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "\"foo\""}));
    
  doTestParseWithParameters("Basic realm=\"foo\", bar=\"xyz\",, a=b,,,c=d", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "foo", "bar" : "xyz", "a" : "b", "c" : "d"}));
    
  doTestParseWithParameters("Basic bar=\"xyz\", realm=\"foo\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "foo", "bar" : "xyz"}));

  doTestParseWithParameters("Basic realm=\"foo-\u00E4\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "foo-\u00E4"}));
  doTestParseWithParameters("Basic realm=\"foo-\u00A4\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "foo-\u00A4"}));       
  doTestParseWithParameters("Basic realm=\"=?ISO-8859-1?Q?foo-=E4?=\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "=?ISO-8859-1?Q?foo-=E4?="}));
    
  // Skip multichallenge tests here.  
  doTestParseWithParameters("Newauth realm=\"newauth\"", "Newauth", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "newauth"}));
  doTestParseWithParameters("Basic foo=\"realm=nottherealm\", realm=\"basic\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"foo" : "realm=nottherealm", "realm" : "basic"}));
  doTestParseWithParameters("Basic nottherealm=\"nottherealm\", realm=\"basic\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"nottherealm" : "nottherealm", "realm" : "basic"}));

  doTestParseWithInvalid("Basic, realm=\"foo\"");
  doTestParseWithInvalid("Basic");   
  
  // Technically invalid, but we ignore bad data as much as possible
  doTestParseWithParameters("Basic realm=\"foo\", realm=\"bar\"", "Basic", Persistent.EMPTY_DICTIONARY.putAllFromMap({"realm" : "foo"}));
}
