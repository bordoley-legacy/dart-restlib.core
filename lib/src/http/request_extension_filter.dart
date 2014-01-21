part of restlib.core.http;

typedef Request RequestFilter(Request request); 
typedef Response ResponseFilter(Response response); 

RequestFilter requestExtensionAsAccept(final Dictionary<String, MediaRange> extensionMap) =>
    new _RequestExtensionAsAccept(extensionMap);

class _RequestExtensionAsAccept {  
  final Dictionary<String, MediaRange> extensionMap;
  
  _RequestExtensionAsAccept(this.extensionMap);
  
  Request call(final Request request) {
    final Iterable<String> pathSegments = request.uri.pathSegments;  
    final String lastSegment = pathSegments.last;
    final int index = lastSegment.lastIndexOf(".");
    
    // cases:
    // /noext
    // /.ext
    // /noext.
    // /path.ext
    if (index < 1 || index == (lastSegment.length - 1)) {
      return request;
    }
    
    final String newLastSegment = lastSegment.substring(0, index);
    final String extension = lastSegment.substring(index + 1);
    
    return extensionMap(extension)
        .map((final MediaRange mediaRange) {
          final Iterable<String> newPathSegments = 
              pathSegments.take(pathSegments.length - 1).toList(growable: true)..add(newLastSegment);
          final Uri uri = request.uri;
          final Uri newUri = new Uri(
              scheme: uri.scheme, 
              userInfo: uri.userInfo, 
              host: uri.host, 
              port: uri.port, 
              pathSegments: newPathSegments, 
              query: uri.query,
              fragment: uri.fragment);
          final RequestPreferences newRequestPreferences = 
              new RequestPreferences(
                  acceptedMediaRanges: [new Preference(mediaRange)]);
          return request.with_(
              uri: newUri,
              preferences: newRequestPreferences);
        }).orElse(request);
  }
}