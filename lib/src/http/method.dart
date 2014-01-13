part of restlib.core.http;

class Method {
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3744#section-8.1">[RFC3744], Section 8.1</a>
   */
  static const Method ACL = const Method._internal("ACL");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-12.6">[RFC3253], Section 12.6</a>
   */
  static const Method BASELINE_CONTROL = const Method._internal("BASELINE-CONTROL");

  /**
   * @see <a href="http://tools.ietf.org/html/rfc5842#section-4">[RFC5842], Section 4</a>
   */
  static const Method BIND = const Method._internal("BIND");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-4.4">[RFC3253], Section 4.4</a>
   */
  static const Method CHECKIN = const Method._internal("CHECKIN");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-4.3">[RFC3253], Section 4.3</a>
   */
  static const Method CHECKOUT = const Method._internal("CHECKOUT");
  
  /**
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.9">HTTP/1.1 CONNECT Method Definition</>
   */
  static const Method CONNECT = const Method._internal("CONNECT");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.8">[RFC4918], Section 9.8 </a>
   */
  static const Method COPY = const Method._internal("COPY");
  
  /**
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.7">HTTP/1.1 DELETE Method Definition</a>
   */
  static const Method DELETE = const Method._internal("DELETE");
  
  /**
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.3">HTTP/1.1 GET Method Definition</a>
   */
  static const Method GET = const Method._internal("GET");
  
  /**
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.4">HTTP/1.1 HEADS Method Definition</a>
   */
  static const Method HEAD = const Method._internal("HEAD");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-8.2">[RFC3253], Section 8.2</a>
   */
  static const Method LABEL = const Method._internal("LABEL");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc2068#section-19.6.1.2">[RFC2068], Section 19.6.1.2</a>
   */
  static const Method LINK = const Method._internal("LINK");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.10">[RFC4918], Section 9.10</a>
   */
  static const Method LOCK = const Method._internal("LOCK");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-11.2">[RFC3253], Section 11.2</a>
   */
  static const Method MERGE = const Method._internal("MERGE");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-13.5">[RFC3253], Section 13.5</a>
   */
  static const Method MKACTIVITY = const Method._internal("MKACTIVITY");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc4791#section-5.3.1">[RFC4791], Section 5.3.1</a>
   */
  static const Method MKCALENDAR = const Method._internal("MKCALENDAR");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.3">[RFC4918], Section 9.3</a>
   */
  static const Method MKCOL = const Method._internal("MKCOL");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc4437#section-6">[RFC4437], Section 6</a>
   */
  static const Method MKREDIRECTREF = const Method._internal("MKREDIRECTREF");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-6.3">[RFC3253], Section 6.3</a>
   */
  static const Method MKWORKSPACE = const Method._internal("MKWORKSPACE");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.9">[RFC4918], Section 9.9</a>
   */
  static const Method MOVE = const Method._internal("MOVE");
  
  /**
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.2">HTTP/1.1 OPTIONS Method Definition</a>
   */
  static const Method OPTIONS = const Method._internal("OPTIONS");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3648#section-7">[RFC3648], Section 7</a>
   */
  static const Method ORDERPATCH = const Method._internal("ORDERPATCH");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc5789#section-2">[RFC5789], Section 2</a>
   */
  static const Method PATCH = const Method._internal("PATCH");
  
  /**
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.5">HTTP/1.1 POST Method Definition</a>
   */
  static const Method POST = const Method._internal("POST");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.1">[RFC4918], Section 9.1</a>
   */
  static const Method PROPFIND = const Method._internal("PROPFIND");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.2">[RFC4918], Section 9.2</a>
   */
  static const Method PROPPATCH = const Method._internal("PROPPATCH");
  
  /**
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.6">HTTP/1.1 PUT Method Definition</a>
   */
  static const Method PUT = const Method._internal("PUT");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc5842#section-6">[RFC5842], Section 6</a>
   */
  static const Method REBIND = const Method._internal("REBIND");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-3.6">[RFC3253], Section 3.6</a>
   */
  static const Method REPORT = const Method._internal("REPORT");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc5323#section-2">[RFC5323], Section 2</a>
   */
  static const Method SEARCH = const Method._internal("SEARCH");
  
  /**
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.8">HTTP/1.1 TRACE Method Definition</>
   */
  static const Method TRACE = const Method._internal("TRACE");   
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc5842#section-5">[RFC5842], Section 5</a>
   */
  static const Method UNBIND = const Method._internal("UNBIND");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-4.5">[RFC3253], Section 4.5</a>
   */
  static const Method UNCHECKOUT = const Method._internal("UNCHECKOUT");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc2068#section-19.6.1.3">[RFC2068], Section 19.6.1.3</a>
   */
  static const Method UNLINK = const Method._internal("UNLINK");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.11">[RFC4918], Section 9.11</a>
   */
  static const Method UNLOCK = const Method._internal("UNLOCK");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-7.1">[RFC3253], Section 7.1</a>
   */
  static const Method UPDATE = const Method._internal("UPDATE");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc4437#section-7">[RFC4437], Section 7</a>
   */
  static const Method UPDATEDIRECTREF = const Method._internal("UPDATEDIRECTREF");
  
  /**
   * @see <a href="http://tools.ietf.org/html/rfc3253#section-3.5">[RFC3253], Section 3.5</a>
   */
  static const Method VERSION_CONTROL = const Method._internal("VERSION-CONTROL");
  
  static final MutableDictionary<Method,Method> _registry = 
      (new MutableDictionary.hash()
          ..insert(Method.ACL, Method.ACL)
          ..insert(Method.BASELINE_CONTROL, Method.BASELINE_CONTROL)
          ..insert(Method.BIND, Method.BIND)
          ..insert(Method.CHECKIN, Method.CHECKIN)
          ..insert(Method.CHECKOUT, Method.CHECKOUT)
          ..insert(Method.CONNECT, Method.CONNECT)
          ..insert(Method.COPY, Method.COPY)
          ..insert(Method.DELETE, Method.DELETE)
          ..insert(Method.GET, Method.GET)
          ..insert(Method.HEAD, Method.HEAD)
          ..insert(Method.LABEL, Method.LABEL)
          ..insert(Method.LINK, Method.LINK)
          ..insert(Method.LOCK, Method.LOCK)
          ..insert(Method.MERGE, Method.MERGE)
          ..insert(Method.MKACTIVITY, Method.MKACTIVITY)
          ..insert(Method.MKCALENDAR, Method.MKCALENDAR)
          ..insert(Method.MKCOL, Method.MKCOL)
          ..insert(Method.MKREDIRECTREF, Method.MKREDIRECTREF)
          ..insert(Method.MKWORKSPACE, Method.MKWORKSPACE)
          ..insert(Method.MOVE, Method.MOVE)
          ..insert(Method.OPTIONS, Method.OPTIONS)
          ..insert(Method.ORDERPATCH, Method.ORDERPATCH)
          ..insert(Method.PATCH, Method.PATCH)
          ..insert(Method.POST, Method.POST)
          ..insert(Method.PROPFIND, Method.PROPFIND)
          ..insert(Method.PROPPATCH, Method.PROPPATCH)
          ..insert(Method.PUT, Method.PUT)
          ..insert(Method.REBIND, Method.REBIND)
          ..insert(Method.REPORT, Method.REPORT)
          ..insert(Method.SEARCH, Method.SEARCH)
          ..insert(Method.TRACE, Method.TRACE)
          ..insert(Method.UNBIND, Method.UNBIND)
          ..insert(Method.UNCHECKOUT, Method.UNCHECKOUT)
          ..insert(Method.UNLINK, Method.UNLINK)
          ..insert(Method.UNLOCK, Method.UNLOCK)
          ..insert(Method.UPDATE, Method.UPDATE)
          ..insert(Method.UPDATEDIRECTREF, Method.UPDATEDIRECTREF)
          ..insert(Method.VERSION_CONTROL, Method.VERSION_CONTROL));

  factory Method.forName(String name) {
    checkArgument(TCHAR.matchesAllOf(name));
    final Method method = new Method._internal(name.toUpperCase());
    return _registry[method]
            .map((final Method method) => 
                method)
            .orElse(method);
  }
  
  final String name;
  
  const Method._internal(this.name);
  
  int get hashCode => computeHashCode([name]);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Method) {
      return this.name == other.name;
    } else {
      return false;
    }
  }
  
  String toString() => name;
}

