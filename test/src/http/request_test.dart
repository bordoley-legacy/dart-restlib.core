part of restlib.http_test;

void requestTests() {
  group("factory:wrapHeaders()", () {
    test("with no headers present", () {
      final SequenceMultimap<Header, String> headers =
          EMPTY_SEQUENCE_MULTIMAP.put(HOST, "example.com");

      final Request request = new Request.wrapHeaders(PUT, URI.parser.parse("http://example.com/test").value, headers);

      expect(request.authorizationCredentials, isEmpty);
      expect(request.cacheDirectives, isEmpty);
      expect(request.contentInfo.encodings, isEmpty);
      expect(request.contentInfo.languages, isEmpty);
      expect(request.contentInfo.length, isEmpty);
      expect(request.contentInfo.location, isEmpty);
      expect(request.contentInfo.mediaRange, isEmpty);
      expect(request.contentInfo.range, isEmpty);
      expect(request.entity, isEmpty);
      expect(request.expectations, isEmpty);
      expect(request.method, equals(PUT));
      expect(request.pragmaCacheDirectives, isEmpty);
      expect(request.preconditions.ifMatch, isEmpty);
      expect(request.preconditions.ifModifiedSince, isEmpty);
      expect(request.preconditions.ifNoneMatch, isEmpty);
      expect(request.preconditions.ifRange, isEmpty);
      expect(request.preconditions.ifUnmodifiedSince, isEmpty);
      expect(request.preferences.acceptedCharsets, isEmpty);
      expect(request.preferences.acceptedEncodings, isEmpty);
      expect(request.preferences.acceptedLanguages, isEmpty);
      expect(request.preferences.acceptedMediaRanges, isEmpty);
      expect(request.proxyAuthorizationCredentials, isEmpty);
      expect(request.referer, isEmpty);
      expect(request.uri, equals(URI.parser.parse("http://example.com/test").value));
      expect(request.userAgent, isEmpty);
    });

    test("with all headers present", () {
      final String scheme = "https";

      final ImmutableSet<Preference<Charset>> acceptedCharsets =
          EMPTY_SET.addAll([new Preference(Charset.UTF_8), new Preference(Charset.US_ASCII)]);

      final ImmutableSet<Preference<ContentEncoding>> acceptedEncodings =
          EMPTY_SET.addAll([]);

      final ImmutableSet<Preference<Language>> acceptedLanguages =
          EMPTY_SET.addAll([]);

      final ImmutableSet<Preference<MediaRange>> acceptedMediaRanges =
          EMPTY_SET.addAll([new Preference(APPLICATION_ATOM_XML), new Preference(APPLICATION_JSON)]);

      final ChallengeMessage authorizationCredentials =
          ChallengeMessage.parser.parseValue("Basic dGVzdDp0ZXN0");

      ImmutableSet<CacheDirective> cacheDirectives =
          EMPTY_SET.addAll([CacheDirective.MUST_REVALIDATE, CacheDirective.PRIVATE]);

      ImmutableSequence<ContentEncoding> contenEncodings =
          EMPTY_SEQUENCE.addAll([]);

      ImmutableSet<Language> contentLanguages =
          EMPTY_SET.addAll([]);

      final int contentLength = 10;
      final URI contentLocation =
          URI.parser.parse("https://example.com/fake/content/location").value;

      final MediaRange contentMediaRange =
          MediaRange.parser.parse("application/json; charset=\"UTF-8\"").value;

      ContentRange contentRange;

      ImmutableSet<Expectation> expectations =
          EMPTY_SET.addAll([Expectation.EXPECTS_100_CONTINUE]);

      final String host = "www.example.com:8080";

      final ImmutableSet<EntityTag> ifMatch =
          EMPTY_SET.addAll([EntityTag.parser.parseValue("\"abcd\""), EntityTag.parser.parseValue("W/\"efgh\"")]);

      DateTime ifModifiedSince;

      final ImmutableSet<EntityTag> ifNoneMatch =
          EMPTY_SET.addAll([EntityTag.parser.parseValue("\"abcd\""), EntityTag.parser.parseValue("W/\"efgh\"")]);

      final EntityTag ifRange = EntityTag.parser.parseValue("\"abcd\"");
      DateTime ifUnmodifiedSince;

      final Method method = PUT;
      final String path = "/test";

      ImmutableSet<CacheDirective> pragmaCacheDirectives =
          EMPTY_SET.addAll([CacheDirective.PROXY_REVALIDATE, CacheDirective.NO_STORE]);

      //final Range range = "";

      final URI referer =
          URI.parser.parse("https://example.com/fake/referer").value;

      final URI uri = URI.parser.parse("$scheme://$host$path").value;

      final UserAgent userAgent = UserAgent.parser.parse("test/1.1").value;

      final Multimap<Header, String, dynamic> headers =
          EMPTY_SEQUENCE_MULTIMAP.putAllFromMap(
                {ACCEPT : acceptedMediaRanges,
                 ACCEPT_CHARSET : acceptedCharsets,
                 ACCEPT_ENCODING : acceptedEncodings,
                 ACCEPT_LANGUAGE : acceptedLanguages,
                 ACCEPT_RANGES : "", //FIXME:
                 AUTHORIZATION : authorizationCredentials,
                 CACHE_CONTROL : cacheDirectives,
                 CONTENT_ENCODING : contenEncodings,
                 CONTENT_LANGUAGE : contentLanguages,
                 CONTENT_LENGTH  : 10,
                 CONTENT_LOCATION : contentLocation,
                 CONTENT_MD5 : "", //FIXME:
                 CONTENT_RANGE : "", //FIXME:
                 CONTENT_TYPE : contentMediaRange,
                 EXPECT : expectations,
                 FROM : "", //FIXME:
                 HOST : host,
                 IF_MATCH : ifMatch,
                 IF_MODIFIED_SINCE : "", //FIXME:
                 IF_NONE_MATCH : ifNoneMatch,
                 IF_RANGE : ifRange,
                 IF_UNMODIFIED_SINCE : "", //FIXME:
                 PRAGMA : pragmaCacheDirectives,
                 PROXY_AUTHORIZATION : authorizationCredentials,
                 REFERER : referer,
                 USER_AGENT : userAgent}).mapValues(asHeaderValue);

      final Request request =
          new Request.wrapHeaders(PUT, uri, headers);

      expect(request.authorizationCredentials.value, equals(authorizationCredentials));
      expect(request.cacheDirectives, equals(cacheDirectives));
      expect(request.contentInfo.encodings, equals(contenEncodings));
      expect(request.contentInfo.languages, equals(contentLanguages));
      expect(request.contentInfo.length.value, equals(contentLength));
      expect(request.contentInfo.location.value, equals(contentLocation));
      expect(request.contentInfo.mediaRange.value, equals(contentMediaRange));
      expect(request.contentInfo.range, isEmpty);
      expect(request.entity, isEmpty);
      expect(request.expectations, equals(expectations));
      expect(request.method, equals(method));
      expect(request.pragmaCacheDirectives, equals(pragmaCacheDirectives));
      expect(request.preconditions.ifMatch, equals(ifMatch));
      expect(request.preconditions.ifModifiedSince, isEmpty);
      expect(request.preconditions.ifNoneMatch, equals(ifNoneMatch));
      expect(request.preconditions.ifRange.value.value, equals(ifRange));
      expect(request.preconditions.ifUnmodifiedSince, isEmpty);
      expect(request.preferences.acceptedCharsets, equals(acceptedCharsets));
      expect(request.preferences.acceptedEncodings, equals(acceptedEncodings));
      expect(request.preferences.acceptedLanguages, equals(acceptedLanguages));
      expect(request.preferences.acceptedMediaRanges, equals(acceptedMediaRanges));
      expect(request.proxyAuthorizationCredentials.value, equals(authorizationCredentials));
      expect(request.referer.value, equals(referer));
      expect(request.uri, equals(uri));
      expect(request.userAgent.value, equals(userAgent));
    });

    test("with if-Range as date string", () {
      final SequenceMultimap<Header, String> headers =
          EMPTY_SEQUENCE_MULTIMAP.putAllFromMap({IF_RANGE : ""});

      final Request request = new Request.wrapHeaders(PUT, URI.parser.parse("http://www.example.com").value, headers);
      // FIXME:
      expect(request.preconditions.ifRange, isEmpty);
    });
  });
}