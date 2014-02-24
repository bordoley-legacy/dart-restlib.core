part of restlib.core.http;

abstract class Status {
  factory Status(code, message, reason) {
    return new StatusImpl(code, message, reason, new StatusClass.forCode(code));
  }

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