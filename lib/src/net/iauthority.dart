part of net;

final Parser<IAuthority> _I_AUTHORITY =
  _authorityParser(_I_USER_INFO, _I_HOST, IAuthority._builder);

abstract class IAuthority {
  static IAuthority _builder(final String userInfo,
                            final Either<InternationalDomainName, IPAddress> host,
                            final Option<int> port) =>
                                new _IAuthority(userInfo, host, port);
  static final Parser<IAuthority> parser = _I_AUTHORITY;

  Either<InternationalDomainName, IPAddress> get host;
  Option<int> get port;
  String get userInfo;

  IAuthority toIAuthority();
  Authority toAuthority();
}