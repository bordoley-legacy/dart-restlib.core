part of net;

// FIXME: IPv6 support
final Parser<IPAddress> _IP_ADDRESS = _IP_V4_ADDRESS;

final Parser<IPv4Address> _IP_V4_ADDRESS  =
  (_DEC_OCTET + PERIOD + _DEC_OCTET + PERIOD + _DEC_OCTET + PERIOD + _DEC_OCTET)
    .map((final Tuple7<int, int, int, int, int, int, int> e) =>
        new IPv4Address._internal(e.e0, e.e2, e.e4, e.e6));

final Parser<int> _DEC_OCTET = INTEGER.map((final int result) =>
    (result >=0 && result <= 255) ? result : null);

abstract class IPAddress {
  static final Parser<IPAddress> parser = _IP_ADDRESS;

  Iterable<int> get address;
}

class IPv4Address implements IPAddress {
  static final Parser<IPAddress> parser = _IP_V4_ADDRESS;

  final int _oct1;
  final int _oct2;
  final int _oct3;
  final int _oct4;

  IPv4Address._internal(this._oct1, this._oct2, this._oct3, this._oct4);

  Iterable<int> get address =>
      [_oct1, _oct2, _oct3, _oct4];

  int get hashCode =>
      computeHashCode(address);

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is IPv4Address) {
      return this._oct1 == other._oct1 &&
          this._oct2 == other._oct2 &&
          this._oct3 == other._oct3 &&
          this._oct4 == other._oct4;
    } else {
      return false;
    }
  }

  String toString() =>
      "$_oct1.$_oct2.$_oct3.$_oct4";
}

class IPv6Address implements IPAddress {
  Iterable<int> get address => [];
}