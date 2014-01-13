part of restlib.core.data;

final Parser<UnsatisfiedRange> _UNSATISFIED_CONTENT_RANGE =
  (GLOB + FORWARD_SLASH + INTEGER)
    .map((final Iterable e) =>
        new UnsatisfiedRange._internal(e.elementAt(2)));

final Parser _BYTE_RANGE_RESP =
  (INTEGER + DASH + INTEGER + FORWARD_SLASH  + (INTEGER ^ GLOB))
    .map((final Iterable e) {
      final int size = 
          (e.elementAt(4) as Either)
            .fold(
                (final int size) => size,
                (final String glob) => null);
      
      return new ByteRangeResp._internal(e.elementAt(0), e.elementAt(2), size);
    });

final Parser<BytesContentRange> _BYTES_CONTENT_RANGE = 
  (BYTES_UNIT + SP + (_BYTE_RANGE_RESP ^ _UNSATISFIED_CONTENT_RANGE))
    .map((final Iterable e) =>
        new BytesContentRange._internal(e.elementAt(2)));

final Parser<OtherContentRange> _OTHER_CONTENT_RANGE =
  (TOKEN + SP + CHAR.many())
    .map((final Iterable e) =>
        new OtherContentRange._internal(new RangeUnit._internal(e.elementAt(0)), e.elementAt(2)));

final Parser<ContentRange> CONTENT_RANGE =
  (_BYTES_CONTENT_RANGE ^ _OTHER_CONTENT_RANGE)
    .map((final Either<BytesContentRange, OtherContentRange> either) => 
        either.value);

abstract class ContentRange {
  factory ContentRange.byteRange(final int firstBytePosition, final int lastBytePosition, [int size = null]) {
    final ByteRangeResp byteRangeResp = new ByteRangeResp._internal(firstBytePosition, lastBytePosition, size);
    return new BytesContentRange._internal(new Either.leftValue(byteRangeResp));
  }
  
  factory ContentRange.unsatisfiable(final int length) =>
      new BytesContentRange._internal(
          new Either.rightValue(
              new UnsatisfiedRange._internal(length)));
      
  
  RangeUnit get rangeUnit;
  String toString();
}

class OtherContentRange implements ContentRange {
  final RangeUnit rangeUnit;
  final String rangeResp;
  
  OtherContentRange._internal(this.rangeUnit, this.rangeResp);
  
  String toString() =>
      "${rangeUnit.toString()}=$rangeResp";
}

class BytesContentRange implements ContentRange {
  final RangeUnit rangeUnit = RangeUnit.BYTES;
  final Either<ByteRangeResp, UnsatisfiedRange> rangeResp;
  
  BytesContentRange._internal(this.rangeResp);
  
  String toString() =>
      "${rangeUnit.toString()}=${rangeResp.value.toString()}";
}

class UnsatisfiedRange {
  final int length;
  
  const UnsatisfiedRange._internal(this.length);
  
  int get hashCode =>
      length;
  
  bool equals(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is UnsatisfiedRange) {
      return this.length == other.length;
    } else {
      return false;
    }
  }
  
  String toString() =>
      "bytes */$length";
}

class ByteRangeResp {   
  final int firstBytePosition;
  final int lastBytePosition;
  final Option<int> size;
  
  ByteRangeResp._internal(this.firstBytePosition, this.lastBytePosition, final int size):
    this.size = new Option(size);
  
  int get hashCode =>
      computeHashCode([firstBytePosition, lastBytePosition, size]);

  bool equals(final other) {
    if (identical (this, other)) {
      return true;
    } else if (other is ByteRangeResp) {
      return this.firstBytePosition == other.firstBytePosition &&
          this.lastBytePosition == other.lastBytePosition &&
          this.size == other.size;
    } else {
      return false;
    }
  }
  
  String toString() =>
      "$firstBytePosition-$lastBytePosition/${size.map(objectToString).orElse("*")}";
}