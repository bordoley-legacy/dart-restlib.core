part of restlib.core.data;

abstract class ContentRange {
  static final Parser<ContentRange> parser = CONTENT_RANGE;

  factory ContentRange.byteRange(final int firstBytePosition, final int lastBytePosition, [int size = null]) {
    final ByteRangeResp byteRangeResp = new ByteRangeRespImpl(firstBytePosition, lastBytePosition, size);
    return new BytesContentRangeImpl(new Either.leftValue(byteRangeResp));
  }

  factory ContentRange.unsatisfiable(final int length) =>
      new BytesContentRangeImpl(
          new Either.rightValue(
              new UnsatisfiedRangeImpl(length)));

  RangeUnit get rangeUnit;
}

abstract class OtherContentRange implements ContentRange {
  RangeUnit get rangeUnit;
  String get rangeResp;
}

abstract class BytesContentRange implements ContentRange {
  RangeUnit get rangeUnit =>
      RangeUnit.BYTES;

  Either<ByteRangeResp, UnsatisfiedRange> get rangeResp;
}

abstract class UnsatisfiedRange {
  int get length;
}

abstract class ByteRangeResp {
  int get firstBytePosition;
  int get lastBytePosition;
  Option<int> get size;
}