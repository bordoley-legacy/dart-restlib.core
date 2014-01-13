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

abstract class MultipartOutput<T extends Streamable> implements Iterable<Part<T>>, Multipart<T> {
  static MultipartOutput<ByteRange> byteRange(final Iterable<Part<ByteRange>> byteRanges) =>
      new _MultipartOutput(byteRanges);
}

abstract class Multipart<T> implements Iterable<Part<T>> {
  factory Multipart(final Iterable<Part<T>> parts) =>
      new _Multipart(parts);
} 

// Use this to include custom part headers
abstract class PartContentInfo implements ContentInfo{
  
}

class Part<T> {
  final ContentInfo contentInfo;
  final T entity;
  
  Part(this.contentInfo, this.entity){
    checkNotNull(contentInfo);
    checkNotNull(entity);
  }
}