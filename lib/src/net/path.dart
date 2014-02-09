part of restlib.core.net;

final Parser<String> _PATH_SEGMENT = PCHAR.orElse("");
final Parser<Path> PATH = 
  _PATH_SEGMENT
    .sepBy(FORWARD_SLASH)
    .map(Path.EMPTY.addAll)
    .map((final Path path) {
      if ((path.length == 1) && path.elementAt(0).isEmpty) {
        return Path.EMPTY;
      } else {
        return path;
      }
    });

abstract class Path implements IPath {
  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  static final Path EMPTY = new _Path(Persistent.EMPTY_SEQUENCE);
  
  Path get tail; 
  
  Path add(String value);
  
  Path addAll(Iterable<String> elements);  
  
  Path canonicalize();
  
  Path remove(String element);
  
  Path push(String value);
  
  Path putAll(Iterable<Pair<int, String>> other);
  
  Path put(int key, String value);
  
  Path putPair(Pair<int,String> pair);
  
  Path removeAt(int key);
}

class _Path extends _IPathBase implements Path {
  static final Path _FORWARD_SLASH_PATH = new _Path(Persistent.EMPTY_SEQUENCE.addAll(["",""]));
  
  final ImmutableSequence<String> delegate;
  
  _Path(this.delegate);
  
  IPath get forwardSlashPath => 
      _Path._FORWARD_SLASH_PATH;
  
  Parser<String> get segmentParser => 
      _PATH_SEGMENT;
      
  Path builder(final ImmutableSequence<String> delegate) =>
      new _Path(delegate);
}