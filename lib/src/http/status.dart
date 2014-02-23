part of restlib.core.http;

class Status {
  /**
   * The request could not be understood by the server due to malformed syntax.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.1">400 Bad Request</a>
   */
  static const Status CLIENT_ERROR_BAD_REQUEST =
      const Status._internal(
          400,
          "Bad Request",
          "The request could not be understood by the server due to malformed syntax.",
          StatusClass.CLIENT_ERROR);

  /**
   * The request could not be completed due to a conflict with the current state of the resource.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.10">409 Conflict</a>
   */
  static const Status CLIENT_ERROR_CONFLICT =
      const Status._internal(
          409,
          "Conflict",
          "The request could not be completed due to a conflict with the current state of the resource.",
           StatusClass.CLIENT_ERROR);

  /**
   * The expectation given in an Expect request-header field could not be met by this server.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.18">417 Expectation Failed</a>
   */
  static const Status CLIENT_ERROR_EXPECTATION_FAILED =
      const Status._internal(
          417,
          "Expectation Failed",
          "The expectation given in an Expect request-header field could not be met by this server.",
           StatusClass.CLIENT_ERROR);

  /**
   * The method could not be performed on the resource because the
   * requested action depended on another action and that action failed.
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.4">424 Failed Dependency</a>
   */
  static const Status CLIENT_ERROR_FAILED_DEPENDENCY =
      const Status._internal(
          424,
          "Failed Dependency",
          "The method could not be performed on the resource because the requested action depended on another action and that action failed.",
          StatusClass.CLIENT_ERROR);

  /**
   * The server understood the request, but is refusing to authorize it.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.4">403 Bad Request</a>
   */
  static const Status CLIENT_ERROR_FORBIDDEN =
      const Status._internal(
          403,
          "Forbidden",
          "The server understood the request, but is refusing to authorize it.",
          StatusClass.CLIENT_ERROR);

  /**
   * The requested resource is no longer available at the server and no forwarding address is known.
   * This condition is expected to be considered permanent.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.11">410 Gone</a>
   */
  static const Status CLIENT_ERROR_GONE =
      const Status._internal(
          410,
          "Gone",
          "The requested resource is no longer available at the server and no forwarding address is known. This condition is expected to be considered permanent.",
          StatusClass.CLIENT_ERROR);

  /**
   * The server refuses to accept the request without a defined Content-Length.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.12">411 Length Required</a>
   */
  static const Status CLIENT_ERROR_LENGTH_REQUIRED =
      const Status._internal(
          411,
          "Length Required",
          "The server refuses to accept the request without a defined Content-Length.",
          StatusClass.CLIENT_ERROR);

  /**
   * The source or destination resource of a method is locked.
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.3">423 Locked</a>
   */
  static const Status CLIENT_ERROR_LOCKED =
      const Status._internal(
          423,
          "Locked",
          "The source or destination resource of a method is locked.",
          StatusClass.CLIENT_ERROR);

  /**
   * The method specified in the Request-Line is not allowed for the resource identified by the Request-URI.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.6">405 Method Not Allowed</a>
   */
  static const Status CLIENT_ERROR_METHOD_NOT_ALLOWED =
      const Status._internal(
          405,
          "Method Not Allowed",
          "The method specified in the Request-Line is not allowed for the resource identified by the Request-URI.",
          StatusClass.CLIENT_ERROR);

  /**
   * The resource identified by the request is only capable of generating response entities
   * which have content characteristics not acceptable according to the accept headers sent in the request.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.7">406 Not Acceptable</a>
   */
  static const Status CLIENT_ERROR_NOT_ACCEPTABLE =
      const Status._internal(
          406,
          "Not Acceptable",
          "The resource identified by the request is only capable of generating response entities which have content characteristics not acceptable according to the accept headers sent in the request.",
          StatusClass.CLIENT_ERROR);

  /**
   * The server has not found anything matching the Request-URI.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.5">404 Not Found</a>
   */
  static const Status CLIENT_ERROR_NOT_FOUND =
      const Status._internal(
          404,
          "Not Found",
          "The server has not found anything matching the Request-URI.",
          StatusClass.CLIENT_ERROR);

  /**
   * The precondition given in one or more of the request-header fields evaluated to false when it was tested on the server.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.13">412 Precondition Failed</a>
   */
  static const Status CLIENT_ERROR_PRECONDITION_FAILED =
      const Status._internal(
          412,
          "Precondition Failed",
          "The precondition given in one or more of the request-header fields evaluated to false when it was tested on the server.",
          StatusClass.CLIENT_ERROR);

  /**
   * The request requires user authentication.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.2">407 Unauthorized</a>
   */
  static const Status CLIENT_ERROR_PROXY_AUTHENTICATED =
      const Status._internal(
          407,
          "Proxy Authentication Required",
          "Indicates that the client must first authenticate itself with the proxy.",
          StatusClass.CLIENT_ERROR);

  /**
   * The server is refusing to process a request because the request entity is larger than the server is willing or able to process.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.14">413 Request Entity Too Large</a>
   */
  static const Status CLIENT_ERROR_REQUEST_ENTITY_TOO_LARGE =
      const Status._internal(
          413,
          "Request Entity Too Large",
          "The server is refusing to process a request because the request entity is larger than the server is willing or able to process.",
          StatusClass.CLIENT_ERROR);

  /**
   * The client did not produce a request within the time that the server was prepared to wait.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.9">408 Request Timeout</a>
   */
  static const Status CLIENT_ERROR_REQUEST_TIMEOUT =
      const Status._internal(
          408,
          "Request Timeout",
          "The client did not produce a request within the time that the server was prepared to wait.",
          StatusClass.CLIENT_ERROR);

  /**
   * The server is refusing to service the request because the Request-URI is longer than the server is willing to interpret.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.15">414 Request-URI Too Long</a>
   */
  static const Status CLIENT_ERROR_REQUEST_URI_TOO_LONG =
      const Status._internal(
          414,
          "Request-URI Too Long",
          "The server is refusing to service the request because the Request-URI is longer than the server is willing to interpret.",
          StatusClass.CLIENT_ERROR);

  /**
   * Request included a Range request-header field, and none of the range-specifier values in this field overlap the current extent of the selected resource.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.17">416 Requested Range Not Satisfiable</a>
   */
  static const Status CLIENT_ERROR_REQUESTED_RANGE_NOT_SATISFIABLE =
      const Status._internal(
          416,
          "Requested Range Not Satisfiable",
          "Request included a Range request-header field, and none of the range-specifier values in this field overlap the current extent of the selected resource.",
          StatusClass.CLIENT_ERROR);

  /**
   * The request requires user authentication.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.2">401 Unauthorized</a>
   */
  static const Status CLIENT_ERROR_UNAUTHORIZED =
      const Status._internal(
          401,
          "Unauthorized",
          "The request requires user authentication.",
          StatusClass.CLIENT_ERROR);

  /**
   * The server understands the content type of the request entity,
   * and the syntax of the request entity is correct but was unable
   * to process the contained instructions.
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.2">422 Unprocessable Entity</a>
   */
  static const Status CLIENT_ERROR_UNPROCESSABLE_ENTITY =
      const Status._internal(
          422,
          "Unprocessable Entity",
          "The server understands the content type of the request entity, and the syntax of the request entity is correct but was unable to process the contained instructions.",
          StatusClass.CLIENT_ERROR);

  /**
   * The server is refusing to service the request because the entity of the request is in a
   * format not supported by the requested resource for the requested method.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.4.16">415 Unsupported Media Type</a>
   */
  static const Status CLIENT_ERROR_UNSUPPORTED_MEDIA_TYPE =
      const Status._internal(
          415,
          "Unsupported Media Type",
          "The server is refusing to service the request because the entity of the request is in a format not supported by the requested resource for the requested method.",
          StatusClass.CLIENT_ERROR);

  /**
   * Allows a server to definitively state the precise protocol extensionsa given resource must be served with.
   * @see <a href="http://tools.ietf.org/html/rfc2817#section-6">426 Upgrade Required</a>
   */
  static const Status CLIENT_ERROR_UPGRADE_REQUIRED =
      const Status._internal(
          426,
          "Upgrade Required",
          "Allows a server to definitively state the precise protocol extensionsa given resource must be served with.",
          StatusClass.CLIENT_ERROR);

  /**
   * The client SHOULD continue with its request.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.1.1">100 Continue</a>
   */
  static const Status INFORMATIONAL_CONTINUE =
      const Status._internal(
          100,
          "Continue",
          "The client SHOULD continue with its request.",
          StatusClass.INFORMATIONAL);

  /**
   * The server has accepted the complete request, but has not yet completed it.
   * @see <a href="http://tools.ietf.org/html/rfc2518#section-10.1">102 Processing</a>
   */
  static const Status INFORMATIONAL_PROCESSING =
      const Status._internal(
          102,
          "Processing",
          "The server has accepted the complete request, but has not yet completed it.",
          StatusClass.INFORMATIONAL);
  /**
   * The server understands and is willing to comply with the client's request for a change
   * in the application protocol being used on this connection.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.1.2">101 Switching Protocols</a>
   */
  static const Status INFORMATIONAL_SWITCHING_PROTOCOLS =
      const Status._internal(
          101,
          "Switching Protocols",
          "The server understands and is willing to comply with the client's request for a change in the application protocol being used on this connection.",
          StatusClass.INFORMATIONAL);

  /**
   * The requested resource resides temporarily under a different URI.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.3.3">302 Found</a>
   */
  static const Status REDIRECTION_FOUND =
      const Status._internal(
          302,
          "Found",
          "The requested resource resides temporarily under a different URI.",
          StatusClass.REDIRECTION);

  /**
   * The requested resource has been assigned a new permanent URI and any future references to this resource SHOULD use one of the returned URIs.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.3.2">310 Moved Permanently</a>
   */
  static const Status REDIRECTION_MOVED_PERMANENTLY =
      const Status._internal(
          301,
          "Moved Permanently",
          "The requested resource has been assigned a new permanent URI and any future references to this resource SHOULD use one of the returned URIs.",
          StatusClass.REDIRECTION);

  /**
   * The requested resource corresponds to any one of a set of representations,
   * each with its own specific location, and agent-driven negotiation information
   * is being provided so that the user (or user agent) can select a preferred
   * representation and redirect its request to that location.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.3.1">300 Multiple Choices</a>
   */
  static const Status REDIRECTION_MULTIPLE_CHOICES =
      const Status._internal(
          300,
          "Multiple Choices",
          "The requested resource corresponds to any one of a set of representations, each with its own specific location, and agent-driven negotiation information is being provided so that the user (or user agent) can select a preferred representation and redirect its request to that location.",
          StatusClass.REDIRECTION);

  /**
   * The response to the request has not been modified since the
   * conditions indicated by the client's conditional GET request.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.3.5">304 Not Modified</a>
   */
  static const Status REDIRECTION_NOT_MODIFIED =
      const Status._internal(
          304,
          "Not Modified",
          "The response to the request has not been modified since the conditions indicated by the client's conditional GET request.",
          StatusClass.REDIRECTION);

  /**
   * The response to the request can be found under a different URI and SHOULD be retrieved using a GET method on that resource.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.3.4">303 See Other</a>
   */
  static const Status REDIRECTION_SEE_OTHER =
      const Status._internal(
          303,
          "See Other",
          "The response to the request can be found under a different URI and SHOULD be retrieved using a GET method on that resource.",
          StatusClass.REDIRECTION);

  /**
   * The requested resource resides temporarily under a different URI.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.3.8">307 Temporary Redirect</a>
   */
  static const Status REDIRECTION_TEMPORARY_REDIRECT =
      const Status._internal(
          307,
          "Temporary Redirect",
          "The requested resource resides temporarily under a different URI.",
          StatusClass.REDIRECTION);

  /**
   * The requested resource MUST be accessed through the proxy given by the Location field.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.3.6">305 Use Proxy</a>
   */
  static const Status REDIRECTION_USE_PROXY =
      const Status._internal(
          305,
          "Use Proxy",
          "The requested resource MUST be accessed through the proxy given by the Location field.",
          StatusClass.REDIRECTION);

  /**
   * The server, while acting as a gateway or proxy, received an
   * invalid response from the upstream server it accessed in
   * attempting to fulfill the request.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.5.3">502 Bad Gateway</a>
   */
  static const Status SERVER_ERROR_BAD_GATEWAY =
      const Status._internal(
          502,
          "Bad Gateway",
          "The server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed in attempting to fulfill the request.",
          StatusClass.SERVER_ERROR);

  /**
   * The server, while acting as a gateway or proxy, did not receive a
   * timely response from the upstream server specified by the URI
   * (e.g. HTTP, FTP, LDAP) or some other auxiliary server (e.g. DNS)
   * it needed to access in attempting to complete the request.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.5.5">504 Gateway Timeout</a>
   */
  static const Status SERVER_ERROR_GATEWAY_TIMEOUT =
      const Status._internal(
          504,
          "Gateway Timeout",
          "The server, while acting as a gateway or proxy, did not receive a timely response from the upstream server specified by the URI (e.g. HTTP, FTP, LDAP) or some other auxiliary server (e.g. DNS) it needed to access in attempting to complete the request.",
          StatusClass.SERVER_ERROR);

  /**
   * The server does not support, or refuses to support,
   * the HTTP protocol version that was used in the request message.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.5.6">505 HTTP Version Not Supported</a>
   */
  static const Status SERVER_ERROR_HTTP_VERSION_NOT_SUPPORTED =
      const Status._internal(
          505,
          "HTTP Version Not Supported",
          "The server does not support, or refuses to support, the HTTP protocol version that was used in the request message.",
          StatusClass.SERVER_ERROR);

  /**
   * The method could not be performed on the resource because the server is unable to
   * store the representation needed to successfully complete the request.
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.5">507 Insufficient Storage</a>
   */
  static const Status SERVER_ERROR_INSUFFICIENT_STORAGE =
      const Status._internal(
          507,
          "Insufficient Storage",
          "The method could not be performed on the resource because the server is unable to store the representation needed to successfully complete the request.",
          StatusClass.SERVER_ERROR);

  /**
   * The server encountered an unexpected condition which prevented it from fulfilling the request.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.5.1">500 Internal Server Error</a>
   */
  static const Status SERVER_ERROR_INTERNAL =
      const Status._internal(
          500,
          "Internal Server Error",
          "The server encountered an unexpected condition which prevented it from fulfilling the request.",
          StatusClass.SERVER_ERROR);

  /**
   * The server terminated an operation because it encountered an infinite loop while processing the request.
   * @see <a href="http://tools.ietf.org/html/rfc5842#section-7.2">508 Loop Detected</a>
   */
  static const Status SERVER_ERROR_LOOP_DETECTED =
      const Status._internal(
          508,
          "Loop Detected",
          "The server terminated an operation because it encountered an infinite loop while processing the request.",
          StatusClass.SERVER_ERROR);

  /**
   * The policy for accessing the resource has not been met in the request.
   * @see <a href="http://tools.ietf.org/html/rfc2774#section-7">510 Not Extended </a>
   */
  static const Status SERVER_ERROR_NOT_EXTENDED =
      const Status._internal(
          510,
          "Not Extended",
          "The policy for accessing the resource has not been met in the request.",
          StatusClass.SERVER_ERROR);

  /**
   * The server does not support the functionality required to fulfill the request.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.5.2">501 Not Implemented</a>
   */
  static const Status SERVER_ERROR_NOT_IMPLEMENTED =
      const Status._internal(
          501,
          "Not Implemented",
          "The server does not support the functionality required to fulfill the request.",
          StatusClass.SERVER_ERROR);

  /**
   * The server is currently unable to handle the request due to a temporary overloading or maintenance of the server.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.5.4">503 Service Unavailable</a>
   */
  static const Status SERVER_ERROR_SERVICE_UNAVAILABLE =
      const Status._internal(
          503,
          "Service Unavailable",
          "The server is currently unable to handle the request due to a temporary overloading or maintenance of the server.",
          StatusClass.SERVER_ERROR);

  /**
   * The server has an internal configuration error: the chosen variant resource is
   * configured to engage in transparent content negotiation itself, and is therefore
   * not a proper end point in the negotiation process.
   * @see <a href="http://tools.ietf.org/html/rfc2295#section-8.1">506 Variant Also Negotiates</a>
   */
  static const Status SERVER_ERROR_VARIANT_ALSO_NEGOTIATES =
      const Status._internal(
          506,
          "Variant Also Negotiates",
          "The server has an internal configuration error: the chosen variant resource is configured to engage in transparent content negotiation itself, and is therefore not a proper end point in the negotiation process.",
          StatusClass.SERVER_ERROR);

  /**
   * The request has been accepted for processing, but the processing has not been completed.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.2.3">202 Accepted</a>
   */
  static const Status SUCCESS_ACCEPTED =
      const Status._internal(
          202,
          "Accepted",
          "The request has been accepted for processing, but the processing has not been completed.",
          StatusClass.SUCCESS);

  /**
   * Already Reported
   * @see <a href="http://tools.ietf.org/html/rfc5842#section-7.1">208 Already Reported</a>
   */
  static const Status SUCCESS_ALREADY_REPORTED =
      const Status._internal(
          208,
          "Already Reported",
          "Already Reported.",
          StatusClass.SUCCESS);

  /**
   * The request has been fulfilled and resulted in a new resource being created.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.2.2">201 Created</a>
   */
  static const Status SUCCESS_CREATED =
      const Status._internal(
          201,
          "Created",
          "The request has been fulfilled and resulted in a new resource being created.",
          StatusClass.SUCCESS);

  /**
   * The response is a representation of the result of one or
   * more instance-manipulations applied to the current instance.
   * @see <a href="http://tools.ietf.org/html/rfc3229#section-10.4.1">226 IM Used</a>
   */
  static const Status SUCCESS_IM_USED =
      const Status._internal(
          226,
          "IM Used",
          "The response is a representation of the result of one or more instance-manipulations applied to the current instance.",
          StatusClass.SUCCESS);

  /**
   * Multiple resources were to be affected by the COPY, but errors on some of them prevented the operation from taking place.
   * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.1">207 Multi-Status</a>
   */
  static const Status SUCCESS_MULTI_STATUS =
      const Status._internal(
          207,
          "Multi-Status",
          "Multiple resources were to be affected by the COPY, but errors on some of them prevented the operation from taking place.",
          StatusClass.SUCCESS);

  /**
   * The server has fulfilled the request but does not need to return an entity-body, and might want to return updated metainformation.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.2.5">204 No Content</a>
   */
  static const Status SUCCESS_NO_CONTENT =
      const Status._internal(
          204,
          "No Content",
          "The server has fulfilled the request but does not need to return an entity-body, and might want to return updated metainformation.",
          StatusClass.SUCCESS);

  /**
   * The returned metainformation in the entity-header is not
   * the definitive set as available from the origin server,
   * but is gatheredfrom a local or a third-party copy.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.2.4">203 Non-Authoritative Information</a>
   */
  static const Status SUCCESS_NON_AUTHORITATIVE_INFORMATION =
      const Status._internal(
          203,
          "Non-Authoritative Information",
          "The returned metainformation in the entity-header is not the definitive set as available from the origin server, but is gatheredfrom a local or a third-party copy.",
          StatusClass.SUCCESS);

  /**
   * The request has succeeded.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.2.1">200 OK</a>
   */
  static const Status SUCCESS_OK =
      const Status._internal(
          200,
          "OK",
          "The request has succeeded.",
          StatusClass.SUCCESS);

  /**
   * The server has fulfilled the partial GET request for the resource.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.2.7">206 Partial Content</a>
   */
  static const Status SUCCESS_PARTIAL_CONTENT =
      const Status._internal(
          206,
          "Partial Content",
          "The server has fulfilled the partial GET request for the resource.",
          StatusClass.SUCCESS);

  /**
   * The server has fulfilled the request and the user agent SHOULD reset the document view which caused the request to be sent.
   * @see <a href="http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-17#section-7.2.6">205 Reset Content</a>
   */
  static const Status SUCCESS_RESET_CONTENT =
      const Status._internal(
          205,
          "Reset Content",
          "The server has fulfilled the request and the user agent SHOULD reset the document view which caused the request to be sent.",
          StatusClass.SUCCESS);


  factory Status(code, message, reason) {
    return new Status._internal(code, message, reason, new StatusClass.forCode(code));
  }

  final int code;
  final String message;
  final String reason;
  final StatusClass statusClass;

  const Status._internal(this.code, this.message, this.reason, this.statusClass);

  int get hashCode => computeHashCode([code]);

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Status) {
      Status that = other;
      return this.code == that.code;
    } else {
      return false;
    }
  }

  Response toResponse() {
    return new Response(this, entity : this.reason);
  }

  String toString() {
    return "$code $message";
  }
}

class StatusClass {
  /**
   * The request contains bad syntax or cannot be fulfilled.
   */
  static const StatusClass CLIENT_ERROR = const StatusClass._internal();

  /**
   * Informational - Request received, continuing process.
   */
  static const StatusClass INFORMATIONAL = const StatusClass._internal();

  /**
   * Further action must be taken in order to complete the request.
   */
  static const StatusClass REDIRECTION = const StatusClass._internal();

  /**
   * The server failed to fulfill an apparently valid request.
   */
  static const StatusClass SERVER_ERROR = const StatusClass._internal();

  /**
   * The action was successfully received, understood, and accepted.
   */
  static const StatusClass SUCCESS = const StatusClass._internal();

  /**
   * The status does not belong to a defined status class.
   */
  static const StatusClass UNDEFINED = const StatusClass._internal();

  factory StatusClass.forCode(final int code) {
    if ((code >= 100) && (code < 200)) {
      return StatusClass.INFORMATIONAL;
    } else if ((code >= 200) && (code < 300)) {
      return StatusClass.SUCCESS;
    } else if ((code >= 300) && (code < 400)) {
      return StatusClass.REDIRECTION;
    } else if ((code >= 400) && (code < 500)) {
      return StatusClass.CLIENT_ERROR;
    } else if ((code >= 500) && (code < 600)) {
      return StatusClass.SERVER_ERROR;
    } else {
      return UNDEFINED;
    }
  }

  const StatusClass._internal();
}