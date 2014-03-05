part of data.internal;

final Parser<UnsatisfiedRange> _UNSATISFIED_CONTENT_RANGE =
  (ASTERISK + FORWARD_SLASH + INTEGER)
    .map((final Iterable e) =>
        new UnsatisfiedRangeImpl(e.elementAt(2)));

final Parser _BYTE_RANGE_RESP =
  (INTEGER + DASH + INTEGER + FORWARD_SLASH  + (INTEGER ^ ASTERISK))
    .map((final Iterable e) {
      final int size = 
          (e.elementAt(4) as Either)
            .fold(
                (final int size) => size,
                (final String glob) => null);
      
      return new ByteRangeRespImpl(e.elementAt(0), e.elementAt(2), size);
    });

final Parser<BytesContentRange> _BYTES_CONTENT_RANGE = 
  (BYTES_UNIT + SP + (_BYTE_RANGE_RESP ^ _UNSATISFIED_CONTENT_RANGE))
    .map((final Iterable e) =>
        new BytesContentRangeImpl(e.elementAt(2)));

final Parser<OtherContentRange> _OTHER_CONTENT_RANGE =
  (TOKEN + SP + CHAR.many())
    .map((final Iterable e) =>
        new _OtherContentRange._internal(new RangeUnitImpl(e.elementAt(0)), e.elementAt(2)));

final Parser<ContentRange> CONTENT_RANGE =
  (_BYTES_CONTENT_RANGE ^ _OTHER_CONTENT_RANGE)
    .map((final Either<BytesContentRange, OtherContentRange> either) => 
        either.value);

class _OtherContentRange implements OtherContentRange {
  final RangeUnit rangeUnit;
  final String rangeResp;
  
  _OtherContentRange._internal(this.rangeUnit, this.rangeResp);
  
  String toString() =>
      "${rangeUnit.toString()}=$rangeResp";
}

class BytesContentRangeImpl implements BytesContentRange {
  final RangeUnit rangeUnit = RangeUnit.BYTES;
  final Either<ByteRangeResp, UnsatisfiedRange> rangeResp;
  
  BytesContentRangeImpl(this.rangeResp);
  
  String toString() =>
      "${rangeUnit.toString()}=${rangeResp.value.toString()}";
}


class UnsatisfiedRangeImpl implements UnsatisfiedRange {
  final int length;
  
  const UnsatisfiedRangeImpl(this.length);
  
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

class ByteRangeRespImpl implements ByteRangeResp {   
  final int firstBytePosition;
  final int lastBytePosition;
  final Option<int> size;
  
  ByteRangeRespImpl(this.firstBytePosition, this.lastBytePosition, final int size):
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