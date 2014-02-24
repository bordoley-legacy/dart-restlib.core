part of restlib.http_test;

preferenceTests() {
  new EqualsTester()
    ..addEqualityGroup(
        [new Preference("a"),
         new Preference("a", qualityFactor: 1000),
         new Preference("a", qualityFactor: 1000, parameters: EMPTY_SEQUENCE_MULTIMAP)])
    ..addEqualityGroup(
        [new Preference("b"),
         new Preference("b", qualityFactor: 1000),
         new Preference("b", qualityFactor: 1000, parameters: EMPTY_SEQUENCE_MULTIMAP)])
    ..addEqualityGroup(
         [new Preference("a", qualityFactor: 500),
         new Preference("a", qualityFactor: 500, parameters: EMPTY_SEQUENCE_MULTIMAP)])
    ..addEqualityGroup(
         [new Preference("a", qualityFactor: 500, parameters: EMPTY_SEQUENCE_MULTIMAP.put("a", "b")),
         new Preference("a", qualityFactor: 500, parameters: EMPTY_SEQUENCE_MULTIMAP.put("a", "b"))])
    ..executeTestCase();

  Parser prefParser = preferenceParser(Charset.parser);

  doTestParse(String testCase, var expectedValue, int expectedQualityFactor, SequenceMultimap expectedParameters) =>
    test("test parsing $testCase",() {
      Preference result = prefParser.parse(testCase).value;
      expect(result.value, equals(expectedValue));
      expect(result.qualityFactor, equals(expectedQualityFactor));
      expect(result.parameters, equals(expectedParameters));
    });

  doTestParse("UTF-8", Charset.UTF_8, 1000, EMPTY_SEQUENCE_MULTIMAP);
  doTestParse("UTF-8; q=0.5", Charset.UTF_8, 500, EMPTY_SEQUENCE_MULTIMAP);
  doTestParse("UTF-8; q=0.5; a=b", Charset.UTF_8, 500, EMPTY_SEQUENCE_MULTIMAP.put("a", "b"));
}