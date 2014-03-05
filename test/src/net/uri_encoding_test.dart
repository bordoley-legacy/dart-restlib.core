part of restlib.core.net_test;

void uriCodecTester() {
  group("_UriCodec", () {

    final parse.RuneMatcher safeChars =
        parse.inRange('a', 'z') | parse.inRange('A', 'Z') | parse.anyOf("*-._");

    final Codec<String, String> codec = uriCodec(safeChars.matches, UTF8);

    test("_UriEncoder", () {
      final String test = "Hello +%-_.!~*\'()@\u00ae\u0101\u10a0";
      final String expected = "Hello%20%2B%25-_.%21%7E*%27%28%29%40%C2%AE%C4%81%E1%82%A0";

      expect(codec.encoder.convert(test), equals(expected));
    });


    test("_UriDecoder", () {
      final Dictionary<String,String> tests =
          new Dictionary.wrapMap(
              {"\u{10000}" : "%F0%90%80%80",
               "\u{103FF}" : "%F0%90%8F%BF",
               "\u{10FC00}" : "%F4%8F%B0%80",
               "\u{10FFFF}" : "%F4%8F%BF%BF",
               "1\u{10FC00}" : "1%F4%8F%B0%80",
               "@\u{10FC00}" : "%40%F4%8F%B0%80",
               "\u{10FC00}1" : "%F4%8F%B0%801",
               "\u{10FC00}@" : "%F4%8F%B0%80%40",
               "\u{0101}\u{10FC00}" : "%C4%81%F4%8F%B0%80",
               "\u{10FC00}\u{0101}" : "%F4%8F%B0%80%C4%81"});


      tests.forEach((final Pair<String, String> test) {
        expect(test.e0, equals(codec.decoder.convert(test.e1)));
      });
    });
  });
}