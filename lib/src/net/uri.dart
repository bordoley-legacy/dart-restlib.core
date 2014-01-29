part of restlib.core.net;

abstract class URI extends IRI {  
  static URI relativeReference(final URI base, final URI relative) =>
      _relativeReference(base, relative, _URI._builder, Path.EMPTY);
  
  factory URI(
      {final String scheme : "", 
        final Authority authority, 
        Path path, // FIXME: final and Path.EMPTY once its const
        final String query : "", 
        final String fragment : ""}) {
    checkNotNull(scheme);
    checkNotNull(query);
    checkNotNull(fragment);
    
    if (scheme.isNotEmpty) {
      checkArgument(_SCHEME.parse(scheme).isNotEmpty);
    }
    
    if(query.isNotEmpty) {
      checkArgument(_QUERY.parse(query).isNotEmpty);
    }

    if(fragment.isNotEmpty) {
      checkArgument(_FRAGMENT.parse(query).isNotEmpty);
    }
    
    path = firstNotNull(path, Path.EMPTY);
    final URI retval = new _URI(scheme, new Option(authority), path, query, fragment);
    checkArgument(_isValid(retval));
    return retval;
  }
    
  
  Option<Authority> get authority;
  Path get path;
  
  URI canonicalize();
}