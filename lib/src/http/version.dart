part of http;

abstract class HttpVersion {
  static const _HttpVersion v2_0 = const _HttpVersion("HTTP/2.0");
  static const _HttpVersion v1_1 = const _HttpVersion("HTTP/1.1");
  static const _HttpVersion v1_0 = const _HttpVersion("HTTP/1.0");
  static const _HttpVersion v0_9 = const _HttpVersion("HTTP/0.9");

  static const Dictionary<String, _HttpVersion> _versions =
     const Dictionary.wrapMap(const {"HTTP/2.0": v2_0, "HTTP/1.1": v1_1, "HTTP/1.0": v1_0, "HTTP/0.9": v0_9});

  static final Parser<_HttpVersion> parser =
     (string("HTTP/") + DIGIT + PERIOD + DIGIT).map((final Tuple4<String, int, int, int> e) {
       final String version = "HTTP/${e.e1}.${e.e3}";
       return _versions[version].orCompute(() =>
           new _HttpVersion(version));
     });
}

class _HttpVersion implements HttpVersion {
  final String _value;
  const _HttpVersion(this._value);

  String toString();
}