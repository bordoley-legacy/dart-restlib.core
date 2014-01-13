part of restlib.http_syntax_test;

primitiveParserTests() {
  
  test("OWS_COMMA_OWS",(){
    expect(OWS_COMMA_OWS.parse("   , \t  ").value, equals(","));
  });
  
  test("QUOTED_STRING" , () {
    expect(QUOTED_STRING.parse("\"abc\"").value, equals("abc"));
  });
  
  test("WORD", (){
    expect(WORD.parse("\"abc\"").value, equals("abc"));
    expect(WORD.parse("abc").value, equals("abc"));
  });
}