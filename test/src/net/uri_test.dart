part of restlib.core.net_test;

void uriTests() {
  group("class:uri", () {
    test("URI_.parse with invalid", () {
      final Iterable<String> tests = 
          ["http://www.example.org/red%09ros\u00E9#red",
           "http://r\u00E9sum\u00E9.example.org"];
      tests.forEach((final String test) {
        expect(URI_.parse(test), isEmpty);
      });
    });
    
    group("new URI.tag()", () {
      void doTestNewUriTagWithIPAddress(final String expected, final IPAddress authority,  final DateTime date,
                                        final Path specificPath, final String query, final String fragment) {
        
      }
      
      void doTestNewUriTagWithDomainName(final String expected, final String authority,  final DateTime date,
                                         final String specificPath, final String query, final String fragment) {
        final URI expectedUri = URI_.parseValue(expected);
        final URI tag = new URI.tag(
            authorityDomain: DOMAIN_NAME.parseValue(authority), 
            date: date, 
            specificPath: PATH.parseValue(specificPath), 
            query: query, 
            fragment: fragment);
        test(expected, () =>
            expect(tag, equals(expectedUri)));
      }
      
      doTestNewUriTagWithDomainName(
          "tag:www.example.com,2001-01-01:/a/b/c", 
          "www.example.com", 
          new DateTime(2001), 
          "/a/b/c", "", "");

      doTestNewUriTagWithDomainName(
          "tag:www.example.com,2001-12-01:/a/b/c",
          "www.example.com",
          new DateTime(2001, 12),
          "/a/b/c", "", "");
      
      doTestNewUriTagWithDomainName(
          "tag:www.example.com,2001-12-05:/a/b/c",
          "www.example.com", 
          new DateTime(2001, 12, 5),
          "/a/b/c", "", "");

      
      doTestNewUriTagWithDomainName(
          "tag:www.example.com,2001-12-05:/a/b/c?query#fragment",
          "www.example.com",
          new DateTime(2001, 12, 5),
         "/a/b/c",
         "query",
         "fragment");
      
      doTestNewUriTagWithDomainName(
          "tag:www.example.com,2001-12-05:?query#fragment",
          "www.example.com",
          new DateTime(2001, 12, 5),
          "",
          "query",
          "fragment");
      
      doTestNewUriTagWithDomainName(
          "tag:www.example.com,2001-12-05:a?query#fragment",
          "www.example.com",
          new DateTime(2001, 12, 5),
          "a",
          "query",
          "fragment");
      /*
       assertEquals(
               Uri.parse("tag:192.168.1.1,2001-12-05:a?query#fragment"),
               Uri.tagBuilder()
                   .setAuthorityName(InetAddresses.forString("192.168.1.1"))
                   .setDate(2001, 12, 5)
                   .setSpecificPath("a")
                   .setSpecificQuery("query")
                   .setFragment("fragment")
                   .build());*/
       
       // Test with international domain names
       doTestNewUriTagWithDomainName(
           "tag:xn--rsum-bpad.example.org,2001-12-05:a?query#fragment",
           "xn--rsum-bpad.example.org",
           new DateTime(2001, 12, 5),
           "a",
           "query",
           "fragment");
      
      
    });
    
    group("canonicalize()", () {
      void doTestCanonicalize(final String expected, final String testUri) {
        test("with $testUri", () =>
            expect(URI_.parse(testUri).value.canonicalize().toString(), equals(expected)));
      }
      
      doTestCanonicalize("/a/b/c/", "/a/b/c/");      
      doTestCanonicalize("example.com/a/b/c/", "example.com/a/b/c/");
      doTestCanonicalize("http://example.com/", "http://example.com");
      doTestCanonicalize("http://example.com/", "http://example.com/");
      doTestCanonicalize("http://example.com/", "http://example.com/////");
      doTestCanonicalize("http://example.com/a", "http://example.com/a/");
      doTestCanonicalize("http://example.com/a/b", "http://example.com/a//b/");
      doTestCanonicalize("http:a/b/c", "http:a/b/c/");
      doTestCanonicalize("http:/", "http:");
      doTestCanonicalize("http:a/b", "http:a//b");
      doTestCanonicalize("http://example.com/a/b/c", "http://example.com/a/b/c");
      doTestCanonicalize("tag:a", "tag:a/");
      doTestCanonicalize("tag:a/b", "tag:a/b");
      doTestCanonicalize("tag:a", "tag:a");
      doTestCanonicalize("http://www.example.com/", "http://www.example.com");
      doTestCanonicalize("http://www.example.com/test", "http://www.example.com/test/");
      
      // Uris without a scheme aren't canonicalized.
      test("Uri without scheme", () =>
          expect(URI_.parse("www.example.com").value.canonicalize().toString(), equals("www.example.com")));
    });
    
    group("static method: relativeReference()", () {
      void doTestRelativeReference(final String expected, final String base, final String relative) {
        test("with base:$base and relative:$relative", () {
          final URI baseUri = URI_.parse(base).value;
          final URI relativeUri = URI_.parse(relative).value;
          final URI expectedUri = URI_.parse(expected).value;
          
          expect(URI.relativeReference(baseUri, relativeUri), equals(expectedUri));
        });
      }
      
      final String rfcTestsBase = "http://a/b/c/d;p?q";
      doTestRelativeReference("g:h", rfcTestsBase, "g:h"); 
      doTestRelativeReference("http://a/b/c/g", rfcTestsBase, "g");
      doTestRelativeReference("http://a/b/c/g", rfcTestsBase, "./g");
      doTestRelativeReference("http://a/b/c/g/", rfcTestsBase, "g/");
      doTestRelativeReference("http://a/g", rfcTestsBase, "/g");
      doTestRelativeReference("http://g", rfcTestsBase, "//g");
      doTestRelativeReference("http://a/b/c/d;p?y", rfcTestsBase, "?y");
      doTestRelativeReference("http://a/b/c/g?y", rfcTestsBase, "g?y");
      doTestRelativeReference("http://a/b/c/d;p?q#s", rfcTestsBase, "#s");
      doTestRelativeReference("http://a/b/c/g#s", rfcTestsBase, "g#s");
      doTestRelativeReference("http://a/b/c/g?y#s", rfcTestsBase, "g?y#s");
      doTestRelativeReference("http://a/b/c/;x", rfcTestsBase, ";x");
      doTestRelativeReference("http://a/b/c/g;x", rfcTestsBase, "g;x");
      doTestRelativeReference("http://a/b/c/g;x?y#s", rfcTestsBase, "g;x?y#s");
      doTestRelativeReference("http://a/b/c/d;p?q", rfcTestsBase, "");
      doTestRelativeReference("http://a/b/c/", rfcTestsBase, ".");
      doTestRelativeReference("http://a/b/c/", rfcTestsBase, "./");
      doTestRelativeReference("http://a/b/", rfcTestsBase, "..");
      doTestRelativeReference("http://a/b/", rfcTestsBase, "../");
      
      // Abnormal Examples
      doTestRelativeReference("http://a/b/g", rfcTestsBase, "../g");
      doTestRelativeReference("http://a/", rfcTestsBase, "../..");
      doTestRelativeReference("http://a/", rfcTestsBase, "../../");
      doTestRelativeReference("http://a/g", rfcTestsBase, "../../g");
      doTestRelativeReference("http://a/g", rfcTestsBase, "../../../g");
      doTestRelativeReference("http://a/g", rfcTestsBase, "../../../../g");
      doTestRelativeReference("http://a/g", rfcTestsBase, "/./g");
      doTestRelativeReference("http://a/g", rfcTestsBase, "/../g");
      doTestRelativeReference("http://a/b/c/g.", rfcTestsBase, "g.");
      doTestRelativeReference("http://a/b/c/.g", rfcTestsBase, ".g");
      doTestRelativeReference("http://a/b/c/g..", rfcTestsBase, "g..");
      doTestRelativeReference("http://a/b/c/..g", rfcTestsBase, "..g"); 
      doTestRelativeReference("http://a/b/g", rfcTestsBase, "./../g");
      doTestRelativeReference("http://a/b/c/g/", rfcTestsBase, "./g/.");
      doTestRelativeReference("http://a/b/c/g/h", rfcTestsBase, "g/./h");
      doTestRelativeReference("http://a/b/c/h", rfcTestsBase, "g/../h");
      doTestRelativeReference("http://a/b/c/g;x=1/y", rfcTestsBase, "g;x=1/./y");
      doTestRelativeReference("http://a/b/c/y", rfcTestsBase, "g;x=1/../y");
      doTestRelativeReference("http://a/b/c/g?y/./x", rfcTestsBase, "g?y/./x");
      doTestRelativeReference("http://a/b/c/g?y/../x", rfcTestsBase, "g?y/../x");
      doTestRelativeReference("http://a/b/c/g#s/./x", rfcTestsBase, "g#s/./x");
      doTestRelativeReference("http://a/b/c/g#s/../x", rfcTestsBase, "g#s/../x");
      doTestRelativeReference("http:g", rfcTestsBase, "http:g");
      
      doTestRelativeReference("http://www.example.com/a/b/c", "http://www.example.com", "a/b/c");
    });
  });
}

