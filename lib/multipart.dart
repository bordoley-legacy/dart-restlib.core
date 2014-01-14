library restlib.core.multipart;

import "dart:async";
import "dart:convert";

import "package:mime/mime.dart";

import "package:restlib_common/collections.dart";
import "package:restlib_common/objects.dart";
import "package:restlib_common/preconditions.dart";

import "http.dart";

part "src/multipart/multipart_impl.dart";

// FIXME: Should go in restlib.core.async
abstract class ByteStreamable {
  Stream<List<int>> asByteStream();
}

abstract class Multipart<T> implements Iterable<Part<T>> {
  factory Multipart(final String boundary, final Iterable<Part<T>> parts) =>
      new _Multipart(boundary, parts);
  
  String get boundary;
} 

class ByteStreamableMultipart 
    extends Object
    with ForwardingIterable<Part<ByteStreamable>>
    implements Multipart<ByteStreamable> {
  final String boundary;
  final Iterable<Part<ByteStreamable>> delegate;
  
  ByteStreamableMultipart(this.boundary, this.delegate);
  
  Stream<List<int>> asByteStream() {
    final ImmutableSequence<Stream<List<int>>> streams =
        this
          .fold(Persistent.EMPTY_SEQUENCE, (final ImmutableSequence sequence, final Part<ByteStreamable> part) =>
              sequence
                .add(_ofValue(ASCII.encode("--$boundary\r\n")))
                .add(_ofValue(ASCII.encode(part.contentInfo.toString())))
                .add(part.entity.asByteStream())
                .add(_ofValue(ASCII.encode("\r\n\r\n"))))
          .add(_ofValue(ASCII.encode("--$boundary--\r\n")));
    return _concat(streams);
  }    
}

// Use this to include custom part headers
abstract class PartContentInfo implements ContentInfo {
  
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

typedef Future<Part> PartParser(PartContentInfo contentInfo, final Stream<List<int>> msgStream);

Future<Multipart> parseMultipartStream(
    final Stream<List<int>> msgStream, 
    final String boundary, 
    Option<PartParser> partParserProvider(PartContentInfo contentInfo)) => 
        new MimeMultipartTransformer(boundary)
          .bind(msgStream)
          .map((final MimeMultipart multipart) =>
              new Part(new ContentInfo.wrapHeaders(
                (final Header header) => 
                    new Option(multipart.headers[header.toString()])), 
              multipart))
          .fold(Persistent.EMPTY_SEQUENCE, (final ImmutableSequence<Future> futureResults, final Part<Stream<List<int>>> part) => 
              partParserProvider(part.contentInfo)
                .map((final PartParser parser) =>
                    futureResults.add(parser(part.contentInfo, part.entity)))
                .orCompute(() =>
                    futureResults.add(part.entity.drain()))
          .then(Future.wait)
          .then((final List parts) => 
              parts.where((final e) =>
                  e is Part))
          .then((final List<Part> parts) =>
              new Multipart(boundary, parts)));   

