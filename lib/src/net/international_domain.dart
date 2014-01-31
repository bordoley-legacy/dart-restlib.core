part of restlib.core.net;

final RuneMatcher _I_REG_NAME_SAFE_CHARS = _I_UNRESERVED | _SUB_DELIMS;
final Parser<InternationalDomainName> _I_REG_NAME = 
  new _PercentEncodedStringParser(_REG_NAME_SAFE_CHARS.matches).map((final String domain) =>
      new _InternationalDomainName(domain));

abstract class InternationalDomainName {
  DomainName toDomainName();
  InternationalDomainName toInternationalDomainName();
}

final RuneMatcher _REG_NAME_SAFE_CHARS = _UNRESERVED | _SUB_DELIMS;
final Parser<DomainName> DOMAIN_NAME = _REG_NAME;
final Parser<DomainName> _REG_NAME = 
  new _PercentEncodedStringParser(_REG_NAME_SAFE_CHARS.matches).map((final String domain) =>
      new _DomainName(domain));

abstract class DomainName implements InternationalDomainName {
  
}

class _InternationalDomainName extends _InternationalDomainNameBase implements InternationalDomainName {
  final String domain;
  
  _InternationalDomainName(this.domain);
  
  String toString() =>
      domain;
}

class _DomainName extends _InternationalDomainNameBase implements DomainName {
  final String domain;
  
  _DomainName(this.domain);
  
  String toString() =>
      domain;
}

abstract class _InternationalDomainNameBase implements InternationalDomainName {
  int get hashCode =>
      this.toString().hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is InternationalDomainName) {
      return this.toString() == other.toString();
    } else {
      return false;
    }
  }
  
  DomainName toDomainName() {
    if (this is DomainName) {
      return this as DomainName;
    }
    
    return new _DomainName(_toASCII(this.toString()));
  }
      
  InternationalDomainName toInternationalDomainName() {
    if (this is DomainName) {
      return new _InternationalDomainName(_toUnicode(this.toString()));
    } 
    
    return this;
  }
}