part of net;

class _Authority extends _IAuthorityBase implements Authority {
  final Either<DomainName, IPAddress> host;
  final Option<int> port;
  final String userInfo;
  
  _Authority(this.userInfo, this.host, this.port); 
}

