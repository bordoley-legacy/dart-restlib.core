part of http;

Request requestMethodOverride(final Request request) {
  Request updateMethod(final Header header) =>
      TOKEN.parse(request.customHeaders(header).value).left
        .map((final String token) {
          final Method method = new Method(token);
          final Dictionary<Header, dynamic> customHeaders =
              EMPTY_DICTIONARY
                .putAll(request.customHeaders)
                .removeAt(X_HTTP_METHOD)
                .removeAt(X_HTTP_METHOD_OVERRIDE)
                .removeAt(X_METHOD_OVERRIDE);
          return request.with_(method: method, customHeaders : customHeaders);
        }).orElse(request);

  if (request.method != POST) {
    return request;
  } else if (request.customHeaders.containsKey(X_HTTP_METHOD)) {
    return updateMethod(X_HTTP_METHOD);
  } else if (request.customHeaders.containsKey(X_HTTP_METHOD_OVERRIDE)) {
    return updateMethod(X_HTTP_METHOD_OVERRIDE);
  } else if (request.customHeaders.containsKey(X_METHOD_OVERRIDE)) {
    return updateMethod(X_METHOD_OVERRIDE);
  } else {
    return request;
  }
}