part of restlib.core.multipart;

class _Multipart<T>
    extends Object
    with ForwardingIterable<Part<T>>
    implements Multipart<T> {
  final String boundary;    
  final Iterable<Part<T>> delegate;
    
  _Multipart(this.boundary, this.delegate);
}    

class _PartContentInfo 
    extends Object
    with ContentInfoToString, 
      ContentInfoWith_,
      ForwardingContentInfo
    implements PartContentInfo {
  final ContentInfo delegate;
  
  _PartContentInfo(this.delegate);
}