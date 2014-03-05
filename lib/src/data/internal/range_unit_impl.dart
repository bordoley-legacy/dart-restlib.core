part of data.internal;

final Parser<RangeUnit> BYTES_UNIT =
  string("bytes")
    .map((final String bytes) =>
        RangeUnit.BYTES);

final Parser<RangeUnit> RANGE_UNIT =
  TOKEN.map((final String token) => 
      new RangeUnitImpl(token));


class RangeUnitImpl implements RangeUnit {  
  final String _rangeUnit;
  
  const RangeUnitImpl(this._rangeUnit);
  
  int get hashCode =>
      _rangeUnit.hashCode;
  
  bool equals(final other){
    if (identical(this, other)) {
      return true;
    } else if (other is RangeUnit) {
      return this.toString() == other.toString();
    } else {
      return false;
    }
  }
  
  String toString() =>
      _rangeUnit;
}