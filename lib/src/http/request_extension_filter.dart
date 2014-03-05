part of http;

typedef Request RequestFilter(Request request); 
typedef Response ResponseFilter(Response response); 

RequestFilter requestExtensionAsAccept(final Dictionary<String, MediaRange> extensionMap) =>
    new _RequestExtensionAsAccept(extensionMap);

class _RequestExtensionAsAccept {  
  final Dictionary<String, MediaRange> extensionMap;
  
  _RequestExtensionAsAccept(this.extensionMap);
  
  Request call(final Request request) {
    final Path path = request.uri.path;  
    final String lastSegment = path.last;
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
          final Path newPath = path.tail.add(newLastSegment);
          final URI uri = request.uri;
          final URI newUri = new URI(
              scheme: uri.scheme, 
              authority: uri.authority.nullableValue, 
              path: newPath, 
              query: uri.query,
              fragment: uri.fragment);
          final RequestPreferences newRequestPreferences = 
              request.preferences.with_(
                  acceptedMediaRanges: [new Preference(mediaRange)]);
          return request.with_(
              uri: newUri,
              preferences: newRequestPreferences);
        }).orElse(request);
  }
}