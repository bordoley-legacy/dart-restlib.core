part of restlib.core.data;

abstract class UserAgent implements ImmutableSequence<Either<Product, Comment>> {
  static final UserAgent EMPTY = new UserAgentImpl(EMPTY_SEQUENCE);

  UserAgent add(Either<Product, Comment> value);

  UserAgent addAll(Iterable<Either<Product, Comment>> elements);

  Option<Either<Product, Comment>> call(final int key);

  UserAgent remove(Either<Product, Comment> element);

  UserAgent get tail;

  UserAgent push(Either<Product, Comment> value);

  UserAgent pushAll(final Iterable<Either<Product, Comment>> other);

  UserAgent putAll(final Iterable<Pair<int, Either<Product, Comment>>> other);

  UserAgent putAllFromMap(final Map<int,Either<Product, Comment>> map);

  UserAgent put(final int key, final Either<Product, Comment> value);

  UserAgent putPair(final Pair<int,Either<Product, Comment>> pair);

  UserAgent removeAt(final int key);

  UserAgent subSequence(int start, int length);
}