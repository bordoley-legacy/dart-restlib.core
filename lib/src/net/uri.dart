part of restlib.core.net;

abstract class URI extends IRI {  
  static String _twoDigit(final int number) {
    checkArgument(number >=0 && number < 100);
    return number > 9 ? number.toString() : "0$number";
  }
  
  static String _dateTimeToTagDate(final DateTime dateTime) =>
    "${dateTime.year}-${_twoDigit(dateTime.month)}-${_twoDigit(dateTime.day)}";  
  
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
    
  factory URI.tag({
    final IPAddress authorityAddress,
    final DomainName authorityDomain,
    DateTime date,
    Path specificPath, // FIXME: final and Path.EMPTY once its const
    final String query : "",
    final String fragment : ""}) {
    
    checkNotNull(query);
    checkNotNull(fragment);
    
    final authority = firstNotNull(authorityAddress, authorityDomain);
    date = firstNotNull(date, new DateTime.now());
    specificPath = firstNotNull(specificPath, Path.EMPTY);
    
    final String firstSegment = "$authority,${_dateTimeToTagDate(date)}:${first(specificPath).orElse("")}";
    final Path tagPath = Path.EMPTY.add(firstSegment).addAll(specificPath.skip(1));
    
    return new URI(
        scheme:TAG,
        path: tagPath,
        query: query,
        fragment: fragment);
  }
  
  Option<Authority> get authority;
  Path get path;
  
  URI canonicalize();
}