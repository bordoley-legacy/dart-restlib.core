part of data;

abstract class RangeUnit {
  static final Parser<RangeUnit> parser = RANGE_UNIT;
  /**
   * The range-unit used to indicate that a representation is broken
   * into byte subranges.
   */
  static const RangeUnit BYTES = const RangeUnitImpl("bytes");

  /**
   * The range-unit sent by servers that do not accept any kind of range request.
   * May be sent by a resource to advise the client not to attempt a range request.
   */
  static const RangeUnit ACCEPT_NONE = const RangeUnitImpl("none");
}