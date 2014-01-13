part of restlib.core.data;

final Parser<Either<Product, Comment>> _PRODUCT_OR_COMMENT =
  (RWS + (PRODUCT ^ COMMENT))
    .map((final Iterable e) => 
        e.elementAt(1));

final Parser<UserAgent> USER_AGENT =
  (PRODUCT + _PRODUCT_OR_COMMENT.many())
    .map((final Iterable e) => 
        new UserAgent._internal(
            Persistent.EMPTY_SEQUENCE
              .add(new Either.leftValue(e.elementAt(0)))
              .addAll(e.elementAt(1))));

class UserAgent {    
  final ImmutableSequence<Either<Product, Comment>> _productsAndComments;
  
  const UserAgent._internal(this._productsAndComments);
  
  int get hashCode => computeHashCode(_productsAndComments);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is UserAgent) {
      return this._productsAndComments == other._productsAndComments;
    } else {
      return false;
    }
  }
  
  String toString() =>
      _productsAndComments
        .map((final Either<Product, Comment> either) =>
            either.fold(objectToString, objectToString)).join(" ");
}