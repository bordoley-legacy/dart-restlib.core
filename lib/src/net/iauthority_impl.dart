part of restlib.core.net;

final Parser<int> _PORT = INTEGER.map((final int port) => 
    (port < 1 || port > 65535) ? null : port);


typedef IAuthority _AuthorityBuilder(String userInfo, 
                                     Either<InternationalDomainName, IPAddress> host,
                                     Option<int> port);

Parser<IAuthority> _authorityParser(
    final Parser<String> userInfo, 
    final Parser<Either<InternationalDomainName, IPAddress>> host,
    final _AuthorityBuilder builder) {
  
  final Parser<String> optionalUserInfo = 
      (userInfo + isChar("@")).map((final Iterable e) => 
          e.elementAt(0)).orElse("");
  final Parser<Option<int>> optionalPort = 
      (isChar(":") + _PORT).map((final Iterable e) =>
          e.elementAt(1)).optional();
  
  return (optionalUserInfo + host + optionalPort).map((final Iterable e) =>
     builder(e.elementAt(0), e.elementAt(1), e.elementAt(2)));
}

class _IAuthority extends _IAuthorityBase implements Authority {
  final Either<InternationalDomainName, IPAddress> host;
  final Option<int> port;
  final String userInfo;
  
  _IAuthority(this.userInfo, this.host, this.port); 
}

abstract class _IAuthorityBase implements IAuthority {     
  int get hashCode =>
      computeHashCode([host, port, userInfo]);

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is IAuthority) {
      return this.host == other.host && 
          this.port == other.port && 
          this.userInfo == other.userInfo;
    } else {
      return false;
    }
  }
  
  IAuthority toIAuthority() {
    if (this is! Authority) {
      return this;
    }
    
    // FIXME: decode userinfo
    final String userInfo = this.userInfo;
    final Either<DomainName, IPAddress> host = 
        this.host.fold(
            (final DomainName domain) =>
                new Either.leftValue(domain.toInternationalDomainName()), 
            (final IPAddress ip) =>
                new Either.rightValue(ip));
    
    final Option<int> port = this.port;
  }
  
  Authority toAuthority() {
    if (this is Authority) {
      return this as Authority;
    }
    
    // FIXME: encode userinfo
    final String userInfo = this.userInfo;
    final Either<DomainName, IPAddress> host = 
        this.host.fold(
            (final InternationalDomainName idn) =>
                new Either.leftValue(idn.toDomainName()), 
            (final IPAddress ip) =>
                new Either.rightValue(ip));
    
    final Option<int> port = this.port;
    
    return new _Authority(userInfo, host, port); 
  }
  
  String toString() {
    final StringBuffer buffer = new StringBuffer();
    if (userInfo.isNotEmpty) {
      buffer..write(userInfo)..write("@");
    }
    
    buffer.write(host.value);
    
    if (port.isNotEmpty) {
      buffer..write(":")..write(port.value);
    }
    
    return buffer.toString();
  }
}

