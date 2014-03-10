part of http;

abstract class Status {
  static const Dictionary<int,Status> _REGISTRY = const Dictionary.wrapMap(const{
    100: INFORMATIONAL_CONTINUE,
    101: INFORMATIONAL_SWITCHING_PROTOCOLS,
    102: INFORMATIONAL_PROCESSING,
    200: SUCCESS_OK,
    201: SUCCESS_CREATED,
    202: SUCCESS_ACCEPTED,
    203: SUCCESS_NON_AUTHORITATIVE_INFORMATION,
    204: SUCCESS_NO_CONTENT,
    205: SUCCESS_RESET_CONTENT,
    206: SUCCESS_PARTIAL_CONTENT,
    207: SUCCESS_MULTI_STATUS,
    208: SUCCESS_ALREADY_REPORTED,
    226: SUCCESS_IM_USED,
    300: REDIRECTION_MULTIPLE_CHOICES,
    301: REDIRECTION_MOVED_PERMANENTLY,
    302: REDIRECTION_FOUND,
    303: REDIRECTION_SEE_OTHER,
    304: REDIRECTION_NOT_MODIFIED,
    305: REDIRECTION_USE_PROXY,
    307: REDIRECTION_TEMPORARY_REDIRECT,
    400: CLIENT_ERROR_BAD_REQUEST,
    401: CLIENT_ERROR_UNAUTHORIZED,
    403: CLIENT_ERROR_FORBIDDEN,
    404: CLIENT_ERROR_NOT_FOUND,
    405: CLIENT_ERROR_METHOD_NOT_ALLOWED,
    406: CLIENT_ERROR_NOT_ACCEPTABLE,
    407: CLIENT_ERROR_PROXY_AUTHENTICATED,
    408: CLIENT_ERROR_REQUEST_TIMEOUT,
    409: CLIENT_ERROR_CONFLICT,
    410: CLIENT_ERROR_GONE,
    411: CLIENT_ERROR_LENGTH_REQUIRED,
    412: CLIENT_ERROR_PRECONDITION_FAILED,
    413: CLIENT_ERROR_REQUEST_ENTITY_TOO_LARGE,
    414: CLIENT_ERROR_REQUEST_URI_TOO_LONG,
    415: CLIENT_ERROR_UNSUPPORTED_MEDIA_TYPE,
    416: CLIENT_ERROR_REQUESTED_RANGE_NOT_SATISFIABLE,
    417: CLIENT_ERROR_EXPECTATION_FAILED,
    422: CLIENT_ERROR_UNPROCESSABLE_ENTITY,
    423: CLIENT_ERROR_LOCKED,
    424: CLIENT_ERROR_FAILED_DEPENDENCY,
    426: CLIENT_ERROR_UPGRADE_REQUIRED,
    500: SERVER_ERROR_INTERNAL,
    501: SERVER_ERROR_NOT_IMPLEMENTED,
    502: SERVER_ERROR_BAD_GATEWAY,
    503: SERVER_ERROR_SERVICE_UNAVAILABLE,
    504: SERVER_ERROR_GATEWAY_TIMEOUT,
    505: SERVER_ERROR_HTTP_VERSION_NOT_SUPPORTED,
    506: SERVER_ERROR_VARIANT_ALSO_NEGOTIATES,
    507: SERVER_ERROR_INSUFFICIENT_STORAGE,
    508: SERVER_ERROR_LOOP_DETECTED,
    510: SERVER_ERROR_NOT_EXTENDED});

  factory Status(code, [reason, message]) =>
      _REGISTRY[code].orCompute(() =>
          new StatusImpl(code, reason, message, new StatusClass.forCode(code)));

  int get code;
  String get message;
  String get reason;
  StatusClass get statusClass;

  Response toResponse();
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