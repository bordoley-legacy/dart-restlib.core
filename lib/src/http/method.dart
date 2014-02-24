part of restlib.core.http;

final MutableDictionary<Method,Method> _registry =
    (new MutableDictionary.hash()
        ..put(ACL, ACL)
        ..put(BASELINE_CONTROL, BASELINE_CONTROL)
        ..put(BIND, BIND)
        ..put(CHECKIN, CHECKIN)
        ..put(CHECKOUT, CHECKOUT)
        ..put(CONNECT, CONNECT)
        ..put(COPY, COPY)
        ..put(DELETE, DELETE)
        ..put(GET, GET)
        ..put(HEAD, HEAD)
        ..put(LABEL, LABEL)
        ..put(LINK, LINK)
        ..put(LOCK, LOCK)
        ..put(MERGE, MERGE)
        ..put(MKACTIVITY, MKACTIVITY)
        ..put(MKCALENDAR, MKCALENDAR)
        ..put(MKCOL, MKCOL)
        ..put(MKREDIRECTREF, MKREDIRECTREF)
        ..put(MKWORKSPACE, MKWORKSPACE)
        ..put(MOVE, MOVE)
        ..put(OPTIONS, OPTIONS)
        ..put(ORDERPATCH, ORDERPATCH)
        ..put(PATCH, PATCH)
        ..put(POST, POST)
        ..put(PROPFIND, PROPFIND)
        ..put(PROPPATCH, PROPPATCH)
        ..put(PUT, PUT)
        ..put(REBIND, REBIND)
        ..put(REPORT, REPORT)
        ..put(SEARCH, SEARCH)
        ..put(TRACE, TRACE)
        ..put(UNBIND, UNBIND)
        ..put(UNCHECKOUT, UNCHECKOUT)
        ..put(UNLINK, UNLINK)
        ..put(UNLOCK, UNLOCK)
        ..put(UPDATE, UPDATE)
        ..put(UPDATEDIRECTREF, UPDATEDIRECTREF)
        ..put(VERSION_CONTROL, VERSION_CONTROL));


abstract class Method {
  static final Parser<Method> parser =
      TOKEN.map((final String method) =>
          _registry[new MethodImpl(method.toUpperCase())].orElse(method));

  factory Method(final String method) =>
      parser.parseValue(method);
}

