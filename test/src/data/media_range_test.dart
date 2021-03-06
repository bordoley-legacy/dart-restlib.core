part of restlib.data_test;

mediaRangeTests() {
  doTestParse(String testCase,
              String type,
              String subtype,
              Option<Charset> charset,
              ImmutableSetMultimap<String, String> parameters) =>
    test("parse: $testCase", () {
      MediaRange result = MEDIA_RANGE.parseValue(testCase);

      expect(result.type, equals(type));
      expect(result.subtype, equals(subtype));
      expect(result.charset, equals(charset));
      expect(result.parameters, equals(parameters));
    });

  doTestMatch(MediaRange fst, MediaRange snd, int expected) =>
      test("match: $fst, $snd", () => expect(fst.match(snd), equals(expected)));

  doTestParseWithInvalid(String testCase) =>
    test("parse invalid: $testCase",
        () =>
            expect(MEDIA_RANGE.parse(testCase), isEmpty));


  doTestFactoryConstructorWithInvalid(String type, String subtype,
                                      {Charset charset, ImmutableSetMultimap<String, String> parameters}) =>
    test("new MediaRange($type, $subtype, $charset, $parameters)", () {
      try {
        new MediaRange(type, subtype, charset: charset, parameters: parameters);
        fail("Expected ArgumentError");
      } on ArgumentError{}
    });

  doTestParse("a/b", "a", "b", Option.NONE, EMPTY_SET_MULTIMAP);
  doTestParse("a/b; charset =  \t UTF-8", "a", "b", new Option(Charset.UTF_8), EMPTY_SET_MULTIMAP);
  doTestParse("a/b; c=d; e=f", "a", "b",  Option.NONE, EMPTY_SET_MULTIMAP.putAllFromMap({"c" : "d", "e" : "f"}));

  doTestParseWithInvalid("");
  doTestParseWithInvalid("a");
  doTestParseWithInvalid("a/");
  doTestParseWithInvalid("@/b");
  doTestParseWithInvalid("b/@");

  // Ignore bad charsets
  doTestParse("a/b; charset=\" \\\" \"" , "a", "b", Option.NONE, EMPTY_SET_MULTIMAP);
  doTestParse("a/b; charset=US-ASCII; c=d; charset=UTF-8", "a", "b", new Option(Charset.US_ASCII), EMPTY_SET_MULTIMAP.putAllFromMap({"c" : "d"}));
  doTestParse("a/b; charset=*", "a", "b", Option.NONE, EMPTY_SET_MULTIMAP);

  new EqualsTester()
    ..addEqualityGroup(
      [MediaRange.APPLICATION_ANY,
      MEDIA_RANGE.parse("application/*").value,
      new MediaRange("application", "*")])
    ..addEqualityGroup(
      [APPLICATION_ATOM_XML,
      MEDIA_RANGE.parse("aPpLiCaTioN/AtOm+xmL").value,
      new MediaRange("applicAtion", "atoM+xml")])
    ..addEqualityGroup(
      [APPLICATION_ATOM_XML_ENTRY,
      MEDIA_RANGE.parse("application/atom+xml; type = \"entry\"").value,
      new MediaRange("application", "atom+xml", parameters: EMPTY_SET_MULTIMAP.putAllFromMap({"type" : "entry"}))])
    ..addEqualityGroup(
      [APPLICATION_ATOM_XML.with_(charset:Charset.UTF_8),
      MEDIA_RANGE.parse("application/atom+xml; charSet = utf-8").value,
      new MediaRange("application", "atom+xml", charset: Charset.UTF_8)])
    ..addEqualityGroup(
      [APPLICATION_ATOM_XML_ENTRY.with_(charset:Charset.UTF_8),
      MEDIA_RANGE.parse("application/atom+xml; type = \"entry\"     \t\t\t; charSet = utf-8").value,
      new MediaRange("application", "atom+xml", charset: Charset.UTF_8, parameters: EMPTY_SET_MULTIMAP.putAllFromMap({"tyPe" : "entry"}))])
    ..addEqualityGroup(
      [TEXT_HTML,
      MEDIA_RANGE.parse("text/html").value,
      new MediaRange("text", "html")])
    ..executeTestCase();

  test("withCharset()", (){
    expect(() => APPLICATION_ATOM_XML.with_(charset:Charset.UTF_8), throwsArgumentError);
    expect(() => MediaRange.ANY.with_(charset:Charset.UTF_8), throwsStateError);
    expect(() => MediaRange.TEXT_ANY.with_(charset:Charset.UTF_8), throwsStateError);
  });

  doTestMatch(APPLICATION_ATOM_XML, APPLICATION_JSON, 0);
  doTestMatch(APPLICATION_ATOM_XML, TEXT_HTML, 0);
  doTestMatch(MediaRange.ANY, APPLICATION_ATOM_XML_ENTRY, 250);
  doTestMatch(MediaRange.APPLICATION_ANY, APPLICATION_ATOM_XML_ENTRY, 500);
  doTestMatch(MEDIA_RANGE.parse("a/b; c=d; e=f").value, MEDIA_RANGE.parse("a/b; c=d").value, 750);
  doTestMatch(MEDIA_RANGE.parse("a/b; e=f").value, MEDIA_RANGE.parse("a/b; c=d").value, 0);
  doTestMatch(APPLICATION_ATOM_XML_ENTRY, APPLICATION_ATOM_XML_ENTRY, 1000);

  // Ignore the charset parameter for matching.
  doTestMatch(APPLICATION_ATOM_XML_ENTRY, APPLICATION_ATOM_XML_ENTRY.with_(charset:Charset.UTF_8), 1000);

  /* Proper behaviour here is up to negotiation depending on how connegResource gets implemented.
  test("invalid match", () {
    try {
      MediaRange.APPLICATION_ATOM_ENTRY.withCharset(Charset.UTF_8).match(MediaRange.APPLICATION_ATOM_ENTRY);
      fail("Expected IllegalStateException");
    } on StateError {}
  });*/

  doTestFactoryConstructorWithInvalid("a", "@");
  doTestFactoryConstructorWithInvalid("@", "b");
  doTestFactoryConstructorWithInvalid("a", "b", charset: Charset.ANY);
  doTestFactoryConstructorWithInvalid("a", "b", parameters: EMPTY_SET_MULTIMAP.putAllFromMap({"charset" : "UTF-8"}));
  doTestFactoryConstructorWithInvalid("a", "b", parameters: EMPTY_SET_MULTIMAP.putAllFromMap({"q" : "1.0"}));
}