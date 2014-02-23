part of restlib.core.net;

final Parser<String> _I_PATH_SEGMENT = _I_PCHAR;
final Parser<IPath> _I_PATH =
  _I_PATH_SEGMENT
    .sepBy(FORWARD_SLASH)
    .map(IPath.EMPTY.addAll)
    .map((final IPath path) {
      if ((path.length == 1) && path.elementAt(0).isEmpty) {
        return IPath.EMPTY;
      } else {
        return path;
      }
    });

abstract class IPath implements ImmutableSequence<String> {
  static final Parser<IPath> parser = _I_PATH;

  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  static final IPath EMPTY = new _IPath(EMPTY_SEQUENCE);

  IPath get tail;

  IPath add(String value);

  IPath addAll(Iterable<String> elements);

  IPath canonicalize();

  IPath remove(String element);

  IPath push(String value);

  IPath putAll(Iterable<Pair<int, String>> other);

  IPath putAllFromMap(Map<int,String> map);

  IPath put(int key, String value);

  IPath putPair(Pair<int,String> pair);

  IPath removeAt(int key);

  IPath pushAll(Iterable<String> value);
}

class _IPath extends _IPathBase {
  static final IPath _FORWARD_SLASH_PATH = new _IPath(EMPTY_SEQUENCE.addAll(["",""]));

  final ImmutableSequence<String> delegate;

  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  _IPath(this.delegate);

  IPath get forwardSlashPath =>
      _IPath._FORWARD_SLASH_PATH;

  Parser<String> get segmentParser =>
      _I_PATH_SEGMENT;

  IPath builder(final ImmutableSequence<String> delegate) =>
      new _IPath(delegate);
}