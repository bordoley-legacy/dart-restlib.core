part of restlib.core.net;

class _IRI extends _IRIBase implements IRI { 
  static IRI _builder(final String scheme, final Option<Authority> authority, 
                       final Iterable<String> pathSegments, final String query, final String fragment) =>
                           new _IRI (scheme, authority, pathSegments, query, fragment);
  
  static IRI _normalize(final IRI iri, final _IRIBuilder builder) {
    // FIXME: 
  }
  
  final String fragment;
  final Option<Authority> authority;
  final IPath path;
  final String query;
  final String scheme;
  
  _IRI(this.scheme, this.authority, this.path, this.query, this.fragment);
  
  IRI canonicalize() =>
      _canonicalize(this, _builder, _normalize);
}