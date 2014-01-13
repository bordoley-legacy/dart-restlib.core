part of restlib.data_test;

mediaRangeTests() {
  doTestParse(String testCase, 
              String type,
              String subtype,
              Option<Charset> charset,
              ImmutableSetMultimap<String, String> parameters) =>   
    test("parse: $testCase", () {
      Option<MediaRange> resultOption = MEDIA_RANGE.parse(testCase);
      MediaRange result = resultOption.value;
    
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
  
  doTestParse("a/b", "a", "b", Option.NONE, Persistent.EMPTY_SET_MULTIMAP);
  doTestParse("a/b; charset =  \t UTF-8", "a", "b", new Option(Charset.UTF_8), Persistent.EMPTY_SET_MULTIMAP);
  doTestParse("a/b; c=d; e=f", "a", "b",  Option.NONE, Persistent.EMPTY_SET_MULTIMAP.insertAllFromMap({"c" : "d", "e" : "f"}));   

  doTestParseWithInvalid("");
  doTestParseWithInvalid("a");
  doTestParseWithInvalid("a/");
  doTestParseWithInvalid("@/b");
  doTestParseWithInvalid("b/@");
  
  // Ignore bad charsets
  doTestParse("a/b; charset=\" \\\" \"" , "a", "b", Option.NONE, Persistent.EMPTY_SET_MULTIMAP);
  doTestParse("a/b; charset=US-ASCII; c=d; charset=UTF-8", "a", "b", new Option(Charset.US_ASCII), Persistent.EMPTY_SET_MULTIMAP.insertAllFromMap({"c" : "d"}));
  doTestParse("a/b; charset=*", "a", "b", Option.NONE, Persistent.EMPTY_SET_MULTIMAP);

  new EqualsTester()
    ..addEqualityGroup(
      [MediaRange.APPLICATION_ANY, 
      MEDIA_RANGE.parse("application/*").value, 
      new MediaRange("application", "*")])
    ..addEqualityGroup(
      [MediaRange.APPLICATION_ATOM,
      MEDIA_RANGE.parse("aPpLiCaTioN/AtOm+xmL").value,
      new MediaRange("applicAtion", "atoM+xml")])
    ..addEqualityGroup(
      [MediaRange.APPLICATION_ATOM_ENTRY,
      MEDIA_RANGE.parse("application/atom+xml; type = \"entry\"").value,
      new MediaRange("application", "atom+xml", parameters: Persistent.EMPTY_SET_MULTIMAP.insertAllFromMap({"type" : "entry"}))])
    ..addEqualityGroup(
      [MediaRange.APPLICATION_ATOM.withCharset(Charset.UTF_8),
      MEDIA_RANGE.parse("application/atom+xml; charSet = utf-8").value,
      new MediaRange("application", "atom+xml", charset: Charset.UTF_8)])      
    ..addEqualityGroup(
      [MediaRange.APPLICATION_ATOM_ENTRY.withCharset(Charset.UTF_8),
      MEDIA_RANGE.parse("application/atom+xml; type = \"entry\"     \t\t\t; charSet = utf-8").value,
      new MediaRange("application", "atom+xml", charset: Charset.UTF_8, parameters: Persistent.EMPTY_SET_MULTIMAP.insertAllFromMap({"tyPe" : "entry"}))])                
    ..addEqualityGroup(
      [MediaRange.TEXT_HTML,
      MEDIA_RANGE.parse("text/html").value,
      new MediaRange("text", "html")])
    ..executeTestCase();

  test("withCharset()", (){
    expect(() => MediaRange.APPLICATION_ATOM.withCharset(Charset.ANY), throwsArgumentError);
    expect(() => MediaRange.ANY.withCharset(Charset.UTF_8), throwsStateError);
    expect(() => MediaRange.TEXT_ANY.withCharset(Charset.UTF_8), throwsStateError);
  });
  
  doTestMatch(MediaRange.APPLICATION_ATOM, MediaRange.APPLICATION_JSON, 0);
  doTestMatch(MediaRange.APPLICATION_ATOM, MediaRange.TEXT_HTML, 0);
  doTestMatch(MediaRange.ANY, MediaRange.APPLICATION_ATOM_ENTRY, 250);
  doTestMatch(MediaRange.APPLICATION_ANY, MediaRange.APPLICATION_ATOM_ENTRY, 500);
  doTestMatch(MEDIA_RANGE.parse("a/b; c=d; e=f").value, MEDIA_RANGE.parse("a/b; c=d").value, 750);
  doTestMatch(MEDIA_RANGE.parse("a/b; e=f").value, MEDIA_RANGE.parse("a/b; c=d").value, 0);
  doTestMatch(MediaRange.APPLICATION_ATOM_ENTRY, MediaRange.APPLICATION_ATOM_ENTRY, 1000);

  // Ignore the charset parameter for matching.
  doTestMatch(MediaRange.APPLICATION_ATOM_ENTRY, MediaRange.APPLICATION_ATOM_ENTRY.withCharset(Charset.UTF_8), 1000);
 
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
  doTestFactoryConstructorWithInvalid("a", "b", parameters: Persistent.EMPTY_SET_MULTIMAP.insertAllFromMap({"charset" : "UTF-8"}));
  doTestFactoryConstructorWithInvalid("a", "b", parameters: Persistent.EMPTY_SET_MULTIMAP.insertAllFromMap({"q" : "1.0"}));
}