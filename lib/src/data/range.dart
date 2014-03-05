part of data;

abstract class Range {
  static final Parser<Range> parser = RANGE;
  RangeUnit get rangeUnit;
}

abstract class ByteRangesSpecifier implements Range {
  RangeUnit get rangeUnit =>
      RangeUnit.BYTES;

  ImmutableSequence<Either<ByteRangeSpec, SuffixByteRangeSpec>> get byteRangeSet;
}

abstract class OtherRangesSpecifier implements Range {
  RangeUnit get rangeUnit;
  String get set;
}

abstract class ByteRangeSpec {
  int get firstBytePos;
  Option<int> get lastBytePos;

  factory ByteRangeSpec.startAt(int firstBytePos) =>
      new ByteRangeSpecImpl(firstBytePos, Option.NONE);

  factory ByteRangeSpec.range(int firstBytePos, int lastBytePos) {
    checkArgument(lastBytePos > firstBytePos);
    return  new ByteRangeSpecImpl(firstBytePos, new Option(lastBytePos));
  }
}

abstract class SuffixByteRangeSpec {
  final int suffixLength;

  factory SuffixByteRangeSpec(int suffixLength) {
    checkArgument (suffixLength > 0);
    return new SuffixByteRangeSpecImpl(suffixLength);
  }
}