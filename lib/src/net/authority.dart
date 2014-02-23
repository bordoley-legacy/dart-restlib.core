part of restlib.core.net;

final Parser<Authority> _AUTHORITY =
  _authorityParser(_USER_INFO, _HOST, Authority._builder);

abstract class Authority extends IAuthority {
  static Authority _builder(final String userInfo,
                            final Either<DomainName, IPAddress> host,
                            final Option<int> port) =>
                                new _Authority(userInfo, host, port);
  static final Parser<Authority> parser = _AUTHORITY;

  Either<DomainName, IPAddress> get host;
  Option<int> get port;
  String get userInfo;
}