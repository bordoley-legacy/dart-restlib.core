part of restlib.core.net;

final Codec<String, String> _USER_INFO_CODEC = utf8UriCodec(_USER_INFO_SAFE_CHARS.matches);
final Codec<String, String> _QUERY_CODEC = utf8UriCodec(_QUERY_SAFE_CHARS.matches);
final Codec<String, String> _FRAGMENT_CODEC = utf8UriCodec(_FRAGMENT_SAFE_CHARS.matches);

class _URI extends _IRIBase implements URI {
  static URI _builder(final String scheme, final Option<Authority> authority,
                       final Path path, final String query, final String fragment) =>
                           new _URI (scheme, authority, path, query, fragment);
  
  static URI _normalize(final URI uri, final _IRIBuilder builder) {
    if (uri.scheme.isEmpty) {
      return uri;
    }
   
    // FIXME: normalize the URI authority component.
    // FIXME: normalize query, 
    // FIXME: normalize fragment
    return _builder(uri.scheme.toLowerCase(), uri.authority,_removeDotSegments(uri.path), uri.query, uri.fragment);
  }
  
  final Option<Authority> authority;
  final String fragment;
  final Path path;
  final String query;
  final String scheme;
  
  _URI(this.scheme, this.authority, this.path, this.query, this.fragment);
  
  URI canonicalize() =>
      _canonicalize(this, _builder, _normalize);
}