part of http.internal;

class HeaderImpl implements Header {
  final String _header;
  final String _display;

  const HeaderImpl(this._header, this._display);

  int get hashCode =>
      _header.hashCode;

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is HeaderImpl) {
      return this._header == other._header;
    } else if (other is Header) {
      return this._header == other.toString().toLowerCase();
    } else {
      return false;
    }
  }

  String toString() {
    return _display;
  }
}
