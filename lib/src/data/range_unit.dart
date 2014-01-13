part of restlib.core.data;

final Parser<RangeUnit> BYTES_UNIT =
  string("bytes")
    .map((final String bytes) =>
        RangeUnit.BYTES);

final Parser<RangeUnit> RANGE_UNIT =
  TOKEN.map((final String token) => 
      new RangeUnit._internal(token));

class RangeUnit {
  /**
   * The range-unit used to indicate that a representation is broken 
   * into byte subranges.
   */
  static const RangeUnit BYTES = const RangeUnit._internal("bytes");
  
  /**
   * The range-unit sent by servers that do not accept any kind of range request. 
   * May be sent by a resource to advise the client not to attempt a range request.
   */
  static const RangeUnit ACCEPT_NONE = const RangeUnit._internal("none");
  
  final String _rangeUnit;
  
  const RangeUnit._internal(this._rangeUnit);
  
  int get hashCode =>
      _rangeUnit.hashCode;
  
  bool equals(final other){
    if (identical(this, other)) {
      return true;
    } else if (other is RangeUnit) {
      return this._rangeUnit == other._rangeUnit;
    } else {
      return false;
    }
  }
  
  String toString() =>
      _rangeUnit;
}