part of restlib.core.data.internal;

final Parser<Either<Product, Comment>> _PRODUCT_OR_COMMENT =
  (RWS + (PRODUCT ^ COMMENT))
    .map((final Iterable e) =>
        e.elementAt(1));

final Parser<UserAgent> USER_AGENT =
  (PRODUCT + _PRODUCT_OR_COMMENT.many())
    .map((final Iterable e) =>
        new UserAgentImpl(
            EMPTY_SEQUENCE
              .add(new Either.leftValue(e.elementAt(0)))
              .addAll(e.elementAt(1))));

class UserAgentImpl
    extends Object
    with ForwardingIterable<Either<Product, Comment>>,
      ForwardingAssociative<int, Either<Product, Comment>>,
      ForwardingSequence<Either<Product, Comment>>
    implements UserAgent {

  final ImmutableSequence<Either<Product, Comment>> delegate;

  UserAgentImpl(this.delegate);

  UserAgent add(final Either<Product, Comment> value) =>
      new UserAgentImpl(delegate.add(value));

  UserAgent addAll(final Iterable<Either<Product, Comment>> elements) =>
      new UserAgentImpl(delegate.addAll(elements));

  Option<Either<Product, Comment>> call(final int key) =>
      delegate[key];

  UserAgent remove(final Either<Product, Comment> element) =>
      new UserAgentImpl(delegate.remove(element));

  UserAgent get tail =>
      new UserAgentImpl(delegate.tail);

  UserAgent push(final Either<Product, Comment> value) =>
      new UserAgentImpl(delegate.push(value));

  UserAgent pushAll(final Iterable<Either<Product, Comment>> other) =>
      new UserAgentImpl(delegate.pushAll(other));

  UserAgent putAll(final Iterable<Pair<int, Either<Product, Comment>>> other) =>
      new UserAgentImpl(delegate.putAll(other));

  UserAgent putAllFromMap(final Map<int,Either<Product, Comment>> map) =>
      new UserAgentImpl(delegate.putAllFromMap(map));

  UserAgent put(final int key, final Either<Product, Comment> value) =>
      new UserAgentImpl(delegate.put(key, value));

  UserAgent putPair(final Pair<int,Either<Product, Comment>> pair) =>
      new UserAgentImpl(delegate.putPair(pair));

  UserAgent removeAt(final int key) =>
      new UserAgentImpl(delegate.removeAt(key));

  UserAgent subSequence(int start, int length) =>
      new UserAgentImpl(delegate.subSequence(start, length));

  String toHeaderString() =>
      toString();

  String toString() =>
      map((final Either<Product, Comment> either) =>
          either.fold(objectToString, objectToString)).join(" ");
}