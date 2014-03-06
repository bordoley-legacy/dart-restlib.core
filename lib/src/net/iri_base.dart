part of net;

Parser<IRI> _iriParser(final Parser<IAuthority> authority,
    final Parser<IPath> path,
    final Parser<String> query,
    final Parser<String> fragment,
    final _IRIBuilder builder) {

  final Parser<Option<String>> optionalScheme =
      (_SCHEME + COLON).map((final Pair<String, int> e) =>
          e.e0).optional();

  final Parser<Option<IAuthority>> optionalAuthority =
      (string("//") + authority).map((final Pair<String, IAuthority> e) =>
          e.e1).optional();

  final Parser<String> optionalQuery =
      (isChar("?") + query).map((final Pair<int, String> e) =>
          e.e1).orElse("");

  final Parser<String> optionalFragment =
      (isChar("#") + fragment).map((final Pair<int, String> e) =>
          e.e1).orElse("");

  return (optionalScheme + optionalAuthority + path + optionalQuery + optionalFragment)
      .map((final Tuple5<Option<String>, Option<IAuthority>, IPath, String, String> e) =>
          builder(e.e0.orElse(""), e.e1, e.e2, e.e3, e.e4));
}

abstract class _IRIBase implements IRI {
  int _hashCode;

  int get hashCode =>
      computeIfNull(_hashCode, () {
        _hashCode = computeHashCode([this.scheme, this.authority, this.path, this.query, this.fragment]);
        return _hashCode;
      });

  bool get isAbsolute =>
      this.scheme.isNotEmpty && fragment.isEmpty;

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is IRI) {
      return this.scheme == other.scheme &&
          this.authority == other.authority &&
          this.path == other.path &&
          this.query == other.query &&
          this.fragment == other.fragment;
    } else {
      return false;
    }
  }

  IRI toIRI() {
    final IRI self = this;

    if (self is URI) {
      //FIXME:
    }
    return self;
  }

  String toString() {
    final StringBuffer buffer = new StringBuffer();

    if (!this.scheme.isEmpty) {
      buffer..write(this.scheme)..write(":");
    }

    if (authority.isNotEmpty) {
      buffer..write("//")..write(authority.value);
    }

    buffer.write(this.path);

    if (!this.query.isEmpty) {
      buffer..write("?")..write(this.query);
    }

    if (!this.fragment.isEmpty) {
      buffer..write("#")..write(this.fragment);
    }

    return buffer.toString();
  }

  Uri toUri() {
    final URI asUri = toURI();
    return new Uri(
        scheme: asUri.scheme,
        userInfo: asUri.authority.map((final Authority authority) =>
            authority.userInfo).orElse(""),
        host: asUri.authority.map((final Authority authority) =>
            authority.host).orElse(""),
        port: asUri.authority..map((final Authority authority) =>
            authority.port).orElse(0),
        path: asUri.path.toString(),
        query: asUri.query,
        fragment: asUri.fragment);
  }

  URI toURI() {
    final IRI self = this;

    if (self is URI) {
      return self;
    }


    // FIXME:
    return null;
  }
}


typedef IRI _IRIBuilder(String scheme, Option<IAuthority> authority, IPath pathSegments, String query, String fragment);

bool _isValid(final IRI iri) {
  final Option<IAuthority> authority = iri.authority;

  // http://tools.ietf.org/html/rfc3986#section-3.3
  // If a URI contains an authority component, then the path component
  // must either be empty or begin with a slash ("/") character.
  if (authority.isNotEmpty && !_isPathAbEmpty(iri.path)) {
    return false;
  }

  // http://tools.ietf.org/html/rfc3986#section-3.3
  // If a URI does not contain an authority component,
  // then the path cannot begin with two slash characters ("//").
  else if (authority.isEmpty && _startsWithDoubleSlash(iri.path)) {
    return false;
  }

  // http://tools.ietf.org/html/rfc3986#section-4.2
  // A path segment that contains a colon character (e.g., "this:that")
  // cannot be used as the first segment of a relative-path reference, as
  // it would be mistaken for a scheme name.
  else if(iri.scheme.isEmpty && authority.isEmpty && !_isPathNoScheme(iri.path)) {
    return false;
  } else {
    return true;
  }
}

IRI _canonicalize(final IRI iri, final _IRIBuilder builder, IRI normalize(IRI iri, _IRIBuilder builder)) {
  checkNotNull(iri);
  checkNotNull(builder);

  if (iri.scheme.isEmpty) {
    return iri;
  }

  final IRI normalized = normalize(iri, builder);
  final Path path = normalized.path.canonicalize();

  return builder(normalized.scheme, normalized.authority, path, normalized.query, normalized.fragment);
}

IRI _relativeReference(final IRI base, final IRI relative, _IRIBuilder builder, IPath empty) {
  checkNotNull(base);
  checkNotNull(relative);
  checkNotNull(builder);
  checkArgument(base.isAbsolute);

  String scheme = "";
  Option<Authority> authority = Option.NONE;
  Path path = Path.EMPTY;
  String query = "";
  String fragment = "";

  if (!relative.scheme.isEmpty) {
    scheme = relative.scheme;
    authority = relative.authority;
    path = _removeDotSegments(relative.path);
    query = relative.query;
  } else {
    scheme = base.scheme;

    if (relative.authority.isNotEmpty) {
      authority = relative.authority;
      path = _removeDotSegments(relative.path);
      query = relative.query;
    } else {
      authority = base.authority;

      if (relative.path.isEmpty) {
        path = base.path;

        if (relative.query.isNotEmpty) {
          query = relative.query;
        } else {
          query = base.query;
        }
      } else {
        if (_startsWithSlash(relative.path)) {
          path = _removeDotSegments(relative.path);
        } else {
          path = _removeDotSegments(_merge(base, relative, empty));
        }

        query = relative.query;
      }
    }
  }

  fragment = relative.fragment;

  return builder(scheme, authority, path, query, fragment);
}

final Parser<String> _SCHEME = new _SchemeParser();
class _SchemeParser extends AbstractParser<String> {
  static final RuneMatcher _schemeChars = ALPHA_NUMERIC | anyOf("+-.");

  _SchemeParser();

  Option<String> doParse(final StringIterator itr) {
    final int startIndex = itr.index + 1;

    if (!itr.moveNext()) {
      return Option.NONE;
    } else if (!ALPHA.matches(itr.current)) {
      return Option.NONE;
    }

    while(itr.moveNext()) {
      if (!_schemeChars.matches(itr.current)) {
        break;
      }
    }

    int endIndex = itr.index;
    itr.movePrevious();

    return new Option(itr.string.substring(startIndex, endIndex));
  }
}