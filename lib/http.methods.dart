library restlib.core.http.methods;

import "http.dart";
import "http.internal.dart";

/**
  * @see <a href="http://tools.ietf.org/html/rfc3744#section-8.1">[RFC3744], Section 8.1</a>
  */
 const Method ACL = const MethodImpl("ACL");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-12.6">[RFC3253], Section 12.6</a>
  */
 const Method BASELINE_CONTROL = const MethodImpl("BASELINE-CONTROL");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc5842#section-4">[RFC5842], Section 4</a>
  */
 const Method BIND = const MethodImpl("BIND");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-4.4">[RFC3253], Section 4.4</a>
  */
 const Method CHECKIN = const MethodImpl("CHECKIN");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-4.3">[RFC3253], Section 4.3</a>
  */
 const Method CHECKOUT = const MethodImpl("CHECKOUT");

 /**
  * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.9">HTTP/1.1 CONNECT Method Definition</>
  */
 const Method CONNECT = const MethodImpl("CONNECT");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.8">[RFC4918], Section 9.8 </a>
  */
 const Method COPY = const MethodImpl("COPY");

 /**
  * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.7">HTTP/1.1 DELETE Method Definition</a>
  */
 const Method DELETE = const MethodImpl("DELETE");

 /**
  * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.3">HTTP/1.1 GET Method Definition</a>
  */
 const Method GET = const MethodImpl("GET");

 /**
  * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.4">HTTP/1.1 HEADS Method Definition</a>
  */
 const Method HEAD = const MethodImpl("HEAD");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-8.2">[RFC3253], Section 8.2</a>
  */
 const Method LABEL = const MethodImpl("LABEL");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc2068#section-19.6.1.2">[RFC2068], Section 19.6.1.2</a>
  */
 const Method LINK = const MethodImpl("LINK");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.10">[RFC4918], Section 9.10</a>
  */
 const Method LOCK = const MethodImpl("LOCK");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-11.2">[RFC3253], Section 11.2</a>
  */
 const Method MERGE = const MethodImpl("MERGE");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-13.5">[RFC3253], Section 13.5</a>
  */
 const Method MKACTIVITY = const MethodImpl("MKACTIVITY");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc4791#section-5.3.1">[RFC4791], Section 5.3.1</a>
  */
 const Method MKCALENDAR = const MethodImpl("MKCALENDAR");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.3">[RFC4918], Section 9.3</a>
  */
 const Method MKCOL = const MethodImpl("MKCOL");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc4437#section-6">[RFC4437], Section 6</a>
  */
 const Method MKREDIRECTREF = const MethodImpl("MKREDIRECTREF");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-6.3">[RFC3253], Section 6.3</a>
  */
 const Method MKWORKSPACE = const MethodImpl("MKWORKSPACE");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.9">[RFC4918], Section 9.9</a>
  */
 const Method MOVE = const MethodImpl("MOVE");

 /**
  * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.2">HTTP/1.1 OPTIONS Method Definition</a>
  */
 const Method OPTIONS = const MethodImpl("OPTIONS");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3648#section-7">[RFC3648], Section 7</a>
  */
 const Method ORDERPATCH = const MethodImpl("ORDERPATCH");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc5789#section-2">[RFC5789], Section 2</a>
  */
 const Method PATCH = const MethodImpl("PATCH");

 /**
  * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.5">HTTP/1.1 POST Method Definition</a>
  */
 const Method POST = const MethodImpl("POST");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.1">[RFC4918], Section 9.1</a>
  */
 const Method PROPFIND = const MethodImpl("PROPFIND");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.2">[RFC4918], Section 9.2</a>
  */
 const Method PROPPATCH = const MethodImpl("PROPPATCH");

 /**
  * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.6">HTTP/1.1 PUT Method Definition</a>
  */
 const Method PUT = const MethodImpl("PUT");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc5842#section-6">[RFC5842], Section 6</a>
  */
 const Method REBIND = const MethodImpl("REBIND");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-3.6">[RFC3253], Section 3.6</a>
  */
 const Method REPORT = const MethodImpl("REPORT");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc5323#section-2">[RFC5323], Section 2</a>
  */
 const Method SEARCH = const MethodImpl("SEARCH");

 /**
  * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-6.8">HTTP/1.1 TRACE Method Definition</>
  */
 const Method TRACE = const MethodImpl("TRACE");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc5842#section-5">[RFC5842], Section 5</a>
  */
 const Method UNBIND = const MethodImpl("UNBIND");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-4.5">[RFC3253], Section 4.5</a>
  */
 const Method UNCHECKOUT = const MethodImpl("UNCHECKOUT");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc2068#section-19.6.1.3">[RFC2068], Section 19.6.1.3</a>
  */
 const Method UNLINK = const MethodImpl("UNLINK");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc4918#section-9.11">[RFC4918], Section 9.11</a>
  */
 const Method UNLOCK = const MethodImpl("UNLOCK");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-7.1">[RFC3253], Section 7.1</a>
  */
 const Method UPDATE = const MethodImpl("UPDATE");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc4437#section-7">[RFC4437], Section 7</a>
  */
 const Method UPDATEDIRECTREF = const MethodImpl("UPDATEDIRECTREF");

 /**
  * @see <a href="http://tools.ietf.org/html/rfc3253#section-3.5">[RFC3253], Section 3.5</a>
  */
 const Method VERSION_CONTROL = const MethodImpl("VERSION-CONTROL");