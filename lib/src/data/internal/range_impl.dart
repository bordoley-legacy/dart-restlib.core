part of data.internal;

const String _BYTES_UNIT = "bytes";

final Parser<ByteRangeSpec> _BYTE_RANGE_SPEC =
  (INTEGER + DASH + INTEGER.optional())
    .map((final Tuple3<int, int, Option<int>> e) =>
        new ByteRangeSpecImpl(e.e0, e.e2));

final Parser<SuffixByteRangeSpec> _SUFFIX_BYTE_RANGE_SPEC =
  (DASH + INTEGER)
    .map((final Pair<int, int> e) =>
        new SuffixByteRangeSpecImpl(e.e1));

final Parser<Iterable<Either<ByteRangeSpec, SuffixByteRangeSpec>>> _BYTE_RANGE_SET =
  (_BYTE_RANGE_SPEC ^ _SUFFIX_BYTE_RANGE_SPEC).sepBy1(COMMA);

final Parser<ByteRangesSpecifier> _BYTE_RANGES_SPECIFIER =
  (string(_BYTES_UNIT) + EQUALS + _BYTE_RANGE_SET)
    .map ((final Tuple3<String, int, Iterable<Either<ByteRangeSpec, SuffixByteRangeSpec>>> e) =>
        // FIXME: Ideally this would be an ordered set
        new ByteRangesSpecifierImpl._internal(EMPTY_SEQUENCE.addAll(e.e2)));

final Parser<OtherRangesSpecifier> _OTHER_RANGES_SPECIFIER =
  (TOKEN + EQUALS + CHAR.many1())
    .map((final Tuple3<String, int, IterableString> e) =>
        new OtherRangesSpecifierImpl(new RangeUnitImpl(e.e0), e.e2.toString()));

final Parser<data.Range> RANGE =
  (_BYTE_RANGES_SPECIFIER  ^ _OTHER_RANGES_SPECIFIER)
    .map((final Either<ByteRangesSpecifier, OtherRangesSpecifier> rangesSpecifier) =>
        rangesSpecifier.value);

class ByteRangesSpecifierImpl
    implements ByteRangesSpecifier {
  final RangeUnit rangeUnit = RangeUnit.BYTES;
  final ImmutableSequence<Either<ByteRangeSpec, SuffixByteRangeSpec>> byteRangeSet;

  ByteRangesSpecifierImpl._internal(this.byteRangeSet);

  String toString() =>
      "bytes=" + byteRangeSet.map((final Either<ByteRangeSpec, SuffixByteRangeSpec> either) =>
          either.value.toString()).join(",");
}

class OtherRangesSpecifierImpl implements OtherRangesSpecifier {
  final RangeUnit rangeUnit;
  final String set;

  OtherRangesSpecifierImpl(this.rangeUnit, this.set);

  String toString() =>
      "${rangeUnit.toString()}=$set";
}

class ByteRangeSpecImpl implements ByteRangeSpec{
  final int firstBytePos;
  final Option<int> lastBytePos;

  const ByteRangeSpecImpl(this.firstBytePos, this.lastBytePos);

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


class SuffixByteRangeSpecImpl implements SuffixByteRangeSpec {
  final int suffixLength;

  const SuffixByteRangeSpecImpl(this.suffixLength);

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