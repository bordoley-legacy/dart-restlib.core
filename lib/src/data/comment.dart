part of restlib.core.data;


abstract class Comment implements ImmutableSequence<Either<String, Comment>> {           
    Comment add(Either<String, Comment> value);
    
    Comment addAll(Iterable<Either<String, Comment>> elements);  
    
    Option<Either<String, Comment>> call(final int key);
    
    Comment remove(Either<String, Comment> element);
    
    Comment get tail;    
    
    Comment push(Either<String, Comment> value);
    
    Comment pushAll(final Iterable<Either<String, Comment>> other);
    
    Comment putAll(final Iterable<Pair<int, Either<String, Comment>>> other);
    
    Comment putAllFromMap(final Map<int,Either<String, Comment>> map);
    
    Comment put(final int key, final Either<String, Comment> value);
    
    Comment putPair(final Pair<int,Either<String, Comment>> pair);
    
    Comment removeAt(final int key);
    
    Comment subSequence(int start, int length);
}