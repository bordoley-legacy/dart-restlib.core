library restlib.core.multipart;

import "dart:async";

import "package:restlib_common/collections.dart";
import "package:restlib_common/objects.dart";
import "package:restlib_common/preconditions.dart";

import "http.dart";

part "src/multipart/multipart_impl.dart";

abstract class Streamable {
  Stream<List<int>> asStream();
}

abstract class Multipart<T> implements Iterable<Part<T>> {
  factory Multipart(final Iterable<Part<T>> parts) =>
      new _Multipart(parts);
  
  static Multipart<ByteRange> byteRange(final Iterable<Part<ByteRange>> byteRanges) =>
      new _Multipart(byteRanges);
} 

// Use this to include custom part headers
abstract class PartContentInfo implements ContentInfo{
  
}

class Part<T> {
  final PartContentInfo contentInfo;
  final T entity;
  
  Part(final ContentInfo contentInfo, this.entity):
  this.contentInfo = new _ForwardingPartContentInfo(contentInfo){
    checkNotNull(contentInfo);
    checkNotNull(entity);
  }
}

class _ForwardingPartContentInfo 
  extends Object
  with ForwardingContentInfo 
  implements PartContentInfo {
  final ContentInfo delegate;
  
  _ForwardingPartContentInfo(this.delegate);
}


