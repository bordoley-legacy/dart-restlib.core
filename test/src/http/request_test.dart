part of restlib.http_test;

void requestTests() {
  group("factory:wrapHeaders()", () {
    test("with no headers present", () { 
      final SequenceMultimap<Header, String> headers =
          Persistent.EMPTY_SEQUENCE_MULTIMAP.insert(Header.HOST, "example.com");
 

      final Request request = new Request.wrapHeaders(headers, Method.PUT, Uri.parse("http://example.com/test"));
      
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
      expect(request.method, equals(Method.PUT));
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
      expect(request.uri, equals(Uri.parse("http://example.com/test")));
      expect(request.userAgent, isEmpty);
    });
    
    test("with all headers present", () {
      final String scheme = "https";
      
      final ImmutableSet<Preference<Charset>> acceptedCharsets =
          Persistent.EMPTY_SET.addAll([new Preference(Charset.UTF_8), new Preference(Charset.US_ASCII)]);
      
      final ImmutableSet<Preference<ContentEncoding>> acceptedEncodings =
          Persistent.EMPTY_SET.addAll([]);     
      
      final ImmutableSet<Preference<Language>> acceptedLanguages =
          Persistent.EMPTY_SET.addAll([]);
      
      final ImmutableSet<Preference<MediaRange>> acceptedMediaRanges =
          Persistent.EMPTY_SET.addAll([new Preference(MediaRange.APPLICATION_ATOM), new Preference(MediaRange.APPLICATION_JSON)]);

      final ChallengeMessage authorizationCredentials =
          CHALLENGE_MESSAGE.parse("Basic dGVzdDp0ZXN0").value;
      
      ImmutableSet<CacheDirective> cacheDirectives =
          Persistent.EMPTY_SET.addAll([CacheDirective.MUST_REVALIDATE, CacheDirective.PRIVATE]);
      
      ImmutableSequence<ContentEncoding> contenEncodings =
          Persistent.EMPTY_SEQUENCE.addAll([]); 
      
      ImmutableSet<Language> contentLanguages =
          Persistent.EMPTY_SET.addAll([]);
      
      final int contentLength = 10;
      final Uri contentLocation = 
          Uri.parse("https://example.com/fake/content/location");
      
      final MediaRange contentMediaRange = 
          MEDIA_RANGE.parse("application/json; charset=\"UTF-8\"").value;
      
      ContentRange contentRange;
      
      ImmutableSet<Expectation> expectations =
          Persistent.EMPTY_SET.addAll([Expectation.EXPECTS_100_CONTINUE]);
     
      final String host = "www.example.com:8080";
      
      final ImmutableSet<EntityTag> ifMatch =
          Persistent.EMPTY_SET.addAll([ETAG.parse("\"abcd\"").value, ETAG.parse("W/\"efgh\"").value]);
      
      DateTime ifModifiedSince;
      
      final ImmutableSet<EntityTag> ifNoneMatch =
          Persistent.EMPTY_SET.addAll([ETAG.parse("\"abcd\"").value, ETAG.parse("W/\"efgh\"").value]);
      
      final EntityTag ifRange = ETAG.parse("\"abcd\"").value;
      DateTime ifUnmodifiedSince;
      
      final Method method = Method.PUT;
      final String path = "/test";
      
      ImmutableSet<CacheDirective> pragmaCacheDirectives =
          Persistent.EMPTY_SET.addAll([CacheDirective.PROXY_REVALIDATE, CacheDirective.NO_STORE]);
      
      //final Range range = "";
      
      final Uri referer = 
          Uri.parse("https://example.com/fake/referer");
      
      final Uri uri = Uri.parse("$scheme://$host$path");
      
      final UserAgent userAgent = USER_AGENT.parse("test/1.1").value;
      
      final Multimap<Header, String, dynamic> headers = 
          Persistent.EMPTY_SEQUENCE_MULTIMAP.insertAllFromMap(
                {Header.ACCEPT : acceptedMediaRanges,
                 Header.ACCEPT_CHARSET : acceptedCharsets,
                 Header.ACCEPT_ENCODING : acceptedEncodings,
                 Header.ACCEPT_LANGUAGE : acceptedLanguages,
                 Header.ACCEPT_RANGES : "", //FIXME:
                 Header.AUTHORIZATION : authorizationCredentials,
                 Header.CACHE_CONTROL : cacheDirectives,
                 Header.CONTENT_ENCODING : contenEncodings,
                 Header.CONTENT_LANGUAGE : contentLanguages,
                 Header.CONTENT_LENGTH  : 10,
                 Header.CONTENT_LOCATION : contentLocation, 
                 Header.CONTENT_MD5 : "", //FIXME:
                 Header.CONTENT_RANGE : "", //FIXME:
                 Header.CONTENT_TYPE : contentMediaRange,
                 Header.EXPECT : expectations,
                 Header.FROM : "", //FIXME:
                 Header.HOST : host,
                 Header.IF_MATCH : ifMatch,
                 Header.IF_MODIFIED_SINCE : "", //FIXME:
                 Header.IF_NONE_MATCH : ifNoneMatch,
                 Header.IF_RANGE : ifRange,
                 Header.IF_UNMODIFIED_SINCE : "", //FIXME:
                 Header.PRAGMA : pragmaCacheDirectives,
                 Header.PROXY_AUTHORIZATION : authorizationCredentials,
                 Header.REFERER : referer,
                 Header.USER_AGENT : userAgent}).mapValues(Header.asHeaderValue);

      final Request request =  
          new Request.wrapHeaders(headers, Method.PUT, uri);
      
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
          Persistent.EMPTY_SEQUENCE_MULTIMAP.insertAllFromMap({Header.IF_RANGE : ""});

      final Request request = new Request.wrapHeaders(headers, Method.PUT, Uri.parse("http://www.example.com"));
      // FIXME:
      expect(request.preconditions.ifRange, isEmpty);
    });
  }); 
}