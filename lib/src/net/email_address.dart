part of restlib.core.net;

Parser<EmailAddress> _EMAIL_ADDRESS;

final RuneMatcher _ATEXT = ALPHA | DIGIT | anyOf("!#\$%&'*+-/=?^_`{|}~");
final Parser<Iterable<String>> _DOT_ATOM_TEXT = (_ATEXT.many().map(objectToString)).sepBy(PERIOD);

class EmailAddress {
  static final Parser<EmailAddress> parser = _EMAIL_ADDRESS;

  final Either<DomainName, IPAddress> domain;
  final String localPart;

  EmailAddress._internal(this.domain, this.localPart);

  int get hashCode =>
      computeHashCode([domain, localPart]);

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is EmailAddress) {
      return this.domain == other.domain &&
          this.localPart == other.localPart;
    } else {
      return false;
    }
  }

  String toString() =>
      "$localPart@$domain";
}