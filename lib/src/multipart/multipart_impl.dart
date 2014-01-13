part of restlib.core.multipart;

abstract class ByteRange extends Streamable {
  Future<int> length();
  ByteRange subRange(int start, int end);
  
  // FIXME: Maybe remove this as optimization for File only. 
  Stream<List<int>> openRead([int start, int end]);
}

abstract class ByteRangeSubRange implements ByteRange {
  ByteRange subRange(int start, int end) =>
      new _ByteRangeableSubRange(this, start, end);
}

class _ByteRangeableSubRange implements ByteRange {
  final ByteRange delegate;
  final int start;
  final int end;
  
  _ByteRangeableSubRange(this.delegate, this.start, this.end);
  
  Stream<List<int>> openRead([int start, int end]) {
    start = firstNotNull(start, 0);
    end = firstNotNull(end, this.end - this.start);
    
    checkArgument(start >= 0);
    checkArgument(end >= 0);
    
    final int newStart = this.start + start;
    final int newEnd = this.start + end;
    
    checkArgument(newStart <= newEnd);
    checkArgument(newEnd <= this.end);
    
    return delegate.openRead(newStart, newEnd);
  }
  
  Future<int> length() =>
      new Future.value(end - start);
  
  ByteRange subRange(final int start, final int end) {
    checkArgument(start >= 0);
    checkArgument(end >= 0);
    
    final int newStart = this.start + start;
    final int newEnd = this.start + end;
    
    checkArgument(newStart <= newEnd);
    checkArgument(newEnd <= this.end);
    
    return delegate.subRange(newStart, newEnd);
  }
  
  Stream<List<int>> asStream() =>
      openRead();
}

class _MultipartOutput<T extends Streamable> 
    extends _Multipart<T>
    implements MultipartOutput<T> {
  
  _MultipartOutput(final Iterable<Part<Streamable>> delegate) : super(delegate);
}

class _Multipart<T>
    extends Object
    with ForwardingIterable<Part<T>>
    implements Multipart<T> {
  final Iterable<Part<T>> delegate;
    
  _Multipart(this.delegate);
}    