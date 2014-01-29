library restlib.core.multipart;

import "dart:async";
import "dart:convert";

import "package:mime/mime.dart";

import "package:restlib_common/async.dart";
import "package:restlib_common/collections.dart";
import "package:restlib_common/collections.forwarding.dart";
import "package:restlib_common/collections.immutable.dart";
import "package:restlib_common/io.dart";
import "package:restlib_common/preconditions.dart";

import "data.dart";
import "http.dart";

part "src/multipart/multipart_impl.dart";

abstract class Multipart<T> implements Iterable<Part<T>> {
  factory Multipart(final String boundary, final Iterable<Part<T>> parts) =>
      new _Multipart(boundary, parts);
  
  String get boundary;
} 

abstract class ByteStreamableMultipart<T extends ByteStreamable> implements Multipart<T>, ByteStreamable {
  factory ByteStreamableMultipart(final String boundary, final Iterable<Part<T>> parts) =>
      new _ByteStreamableMultipart(boundary, parts);
}

class _ByteStreamableMultipart<T extends ByteStreamable>
    extends Object
    with ForwardingIterable<Part<T>>
    implements ByteStreamableMultipart<T> {
  final String boundary;
  final Iterable<Part<ByteStreamable>> delegate;
  
  _ByteStreamableMultipart(this.boundary, this.delegate);
  
  Stream<List<int>> asByteStream() {
    final ImmutableSequence<Stream<List<int>>> streams =
        this
          .fold(Persistent.EMPTY_SEQUENCE, (final ImmutableSequence sequence, final Part<ByteStreamable> part) =>
              sequence
                .add(valueAsStream(ASCII.encode("--$boundary\r\n")))
                .add(valueAsStream(ASCII.encode(part.contentInfo.toString())))
                .add(part.entity.asByteStream())
                .add(valueAsStream(ASCII.encode("\r\n\r\n"))))
          .add(valueAsStream(ASCII.encode("--$boundary--\r\n")));
    return concatStreams(streams);
  }    
}

// Use this to include custom part headers
abstract class PartContentInfo implements ContentInfo {
  Dictionary<Header, dynamic> get customHeaders;
  
  PartContentInfo with_({
    Dictionary<Header, dynamic> customHeaders,
    Iterable<ContentEncoding> encodings,
    Iterable<Language> languages,
    int length,
    Uri location,
    MediaRange mediaRange,
    ContentRange range 
  });
  
  ContentInfo without({
    final bool customHeaders: false,
    final bool encodings: false,
    final bool languages: false,
    final bool length: false,
    final bool location: false,
    final bool mediaRange:  false,
    final bool range : false
  });
}

class Part<T> {
  final PartContentInfo contentInfo;
  final T entity;
  
  Part(final ContentInfo contentInfo, this.entity):
      this.contentInfo = new _PartContentInfo(Persistent.EMPTY_DICTIONARY, contentInfo) {
    checkNotNull(contentInfo);
    checkNotNull(entity);
  }
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
                  Persistent.EMPTY_SEQUENCE_MULTIMAP.putAllFromMap(multipart.headers)), 
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

