part of net;


bool _isPathAbEmpty(final IPath path) =>
    (path.isEmpty) ? true : path.elementAt(0).isEmpty;   

bool _isPathNoScheme(final IPath path) =>
    path.isEmpty ? true : !path.elementAt(0).contains(":");

IPath _merge(final IRI base, final IRI relative, IPath empty) {
  checkNotNull(base);
  checkNotNull(relative);
  checkArgument(base.isAbsolute);

  if (base.authority.isNotEmpty && base.path.isEmpty) {
    return empty.add("").addAll(relative.path);   
  } else {
    return empty
        .addAll(base.path.take(base.path.length -1))
        .addAll(relative.path);
  }
}

IPath _removeDotSegments(final IPath path) {
  IPath doRemoveDotSegments() { 
    IPath buffer = path;
    for (int i = 0; i < buffer.length; i++) {
      final String segment = buffer.elementAt(i);
      if (segment == ".") {
        buffer = buffer.removeAt(i);
        i--;
        
        if (i == buffer.length - 1) {
          buffer = buffer.add("");
        }
      } else if (segment == "..") {
        buffer = buffer.removeAt(i);
        
        if (i == buffer.length){
          buffer = buffer.add("");
        }
        
        if ((i - 1) >= 0) {
          i--;
          final String prevSegment = buffer.elementAt(i);
          if (!prevSegment.isEmpty) {
            buffer = buffer.removeAt(i);
            i--;
          }
        }
      }
    }
    
    return buffer;
  }
  
  if (path.isEmpty) {
    return path;
  } 
  
  final IPath noDotSegments = doRemoveDotSegments();
  if (path == noDotSegments) {
    return path;
  } else {
    return noDotSegments;
  }
}

bool _startsWithDoubleSlash(final IPath path) =>
    // A double slash path looks like ["", "", *]    
    (path.length > 2) && path.take(2).every((final String str) => 
        str.isEmpty);

bool _startsWithSlash(final IPath path) =>
    (path.length > 0) && (path.elementAt(0) == "");


