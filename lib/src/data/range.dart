part of restlib.core.data;

const String _BYTES_UNIT = "bytes";

final Parser<ByteRangeSpec> _BYTE_RANGE_SPEC =
  (INTEGER + DASH + INTEGER.optional())
    .map((final Iterable e) => 
        new ByteRangeSpec._internal(e.elementAt(0), e.elementAt(2)));

final Parser<SuffixByteRangeSpec> _SUFFIX_BYTE_RANGE_SPEC =
  (DASH + INTEGER)
    .map((final Iterable e) =>
        new SuffixByteRangeSpec._internal(e.elementAt(1)));

final Parser<Iterable<Either<ByteRangeSpec, SuffixByteRangeSpec>>> _BYTE_RANGE_SET =
  (_BYTE_RANGE_SPEC ^ _SUFFIX_BYTE_RANGE_SPEC).sepBy1(COMMA);

final Parser<ByteRangesSpecifier> _BYTE_RANGES_SPECIFIER = 
  (string(_BYTES_UNIT) + EQUALS + _BYTE_RANGE_SET)
    .map ((final Iterable e) => 
        // FIXME: Ideally this would be an ordered set
        new ByteRangesSpecifier._internal(Persistent.EMPTY_SEQUENCE.addAll(e.elementAt(2))));

final Parser<OtherRangesSpecifier> _OTHER_RANGES_SPECIFIER =
  (TOKEN + EQUALS + CHAR.many1())
    .map((final Iterable e) =>
        new OtherRangesSpecifier._internal(new RangeUnit._internal(e.elementAt(0)), e.elementAt(2)));

final Parser<Range> RANGE = 
  (_BYTE_RANGES_SPECIFIER  ^ _OTHER_RANGES_SPECIFIER)
    .map((final Either<ByteRangesSpecifier, OtherRangesSpecifier> rangesSpecifier) =>
        rangesSpecifier.value);

abstract class Range {
  RangeUnit get rangeUnit;
  String toString();
}

class ByteRangesSpecifier 
    implements Range {
  final RangeUnit rangeUnit = RangeUnit.BYTES;
  final ImmutableSequence<Either<ByteRangeSpec, SuffixByteRangeSpec>> byteRangeSet;
  
  ByteRangesSpecifier._internal(this.byteRangeSet);
  
  String toString() =>
      "bytes=" + byteRangeSet.map((final Either<ByteRangeSpec, SuffixByteRangeSpec> either) => 
          either.value.toString()).join(",");
}

class OtherRangesSpecifier implements Range {
  final RangeUnit rangeUnit;
  final String set;
  
  OtherRangesSpecifier._internal(this.rangeUnit, this.set);

  String toString() =>
      "${rangeUnit.toString()}=$set";
}

class ByteRangeSpec {
  final int firstBytePos;
  final Option<int> lastBytePos;
  
  factory ByteRangeSpec.startAt(int firstBytePos) =>
      new ByteRangeSpec._internal(firstBytePos, Option.NONE);
  
  factory ByteRangeSpec.range(int firstBytePos, int lastBytePos) {
    checkArgument(lastBytePos > firstBytePos);
    return  new ByteRangeSpec._internal(firstBytePos, new Option(lastBytePos));
  }
  
  const ByteRangeSpec._internal(this.firstBytePos, this.lastBytePos);
  
  int get hashCode =>
      computeHashCode([firstBytePos, lastBytePos]);
      
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ByteRangeSpec) {
      ByteRangeSpec that = other;
      return this.firstBytePos == that.firstBytePos &&
          this.lastBytePos == that.lastBytePos;
    } else {
      return false;
    }
  }
  
  String toString() =>
      "$firstBytePos-${lastBytePos.orElse("")}";
}

class SuffixByteRangeSpec {
  final int suffixLength;
  
  factory SuffixByteRangeSpec(int suffixLength) {
    checkArgument (suffixLength > 0);
    return new SuffixByteRangeSpec._internal(suffixLength);
  }
  
  const SuffixByteRangeSpec._internal(this.suffixLength);
  
  int get hashCode =>
      suffixLength;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is SuffixByteRangeSpec) {
      SuffixByteRangeSpec that = other;
      return this.suffixLength == that.suffixLength;
    } else {
      return false;
    }
  }
  
  String toString() =>
      "-$suffixLength";
}