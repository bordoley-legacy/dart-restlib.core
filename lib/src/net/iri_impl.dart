part of net;

class _IRI extends _IRIBase implements IRI { 
  static IRI _builder(final String scheme, final Option<Authority> authority, 
                       final Iterable<String> pathSegments, final String query, final String fragment) =>
                           new _IRI (scheme, authority, pathSegments, query, fragment);
  
  static IRI _normalize(final IRI iri, final _IRIBuilder builder) {
    if (iri.scheme.isEmpty) {
      return iri;
    }
   
    // FIXME: normalize the URI authority component.
    // FIXME: normalize query, 
    // FIXME: normalize fragment
    return _builder(iri.scheme.toLowerCase(), iri.authority,_removeDotSegments(iri.path), iri.query, iri.fragment);
  }
  
  final String fragment;
  final Option<IAuthority> authority;
  final IPath path;
  final String query;
  final String scheme;
  
  _IRI(this.scheme, this.authority, this.path, this.query, this.fragment);
  
  IRI canonicalize() =>
      _canonicalize(this, _builder, _normalize);
}