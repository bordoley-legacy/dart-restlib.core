part of restlib.data_test;

commentTests() {
  testParse(final String testCase) =>
      test("parse: $testCase", () =>
        expect(COMMENT.parse(testCase).value.toString(), equals(testCase)));
  
  testParse("(test)");
  testParse("(\\()");
  testParse("(test\\(\\)\\\\ test(test test(test test)test)(test))");
}