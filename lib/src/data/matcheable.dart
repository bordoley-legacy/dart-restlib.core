part of restlib.core.data;

abstract class Matcheable<T> {
  // Defines the quality of the match of this to that. For instance,
  // for a MediaRange this text/* would match any that text/ 
  // MediaRange, however text/html would not match text/*
  // @param that
  // @return The quality of the match. 0 is no match, 1000 is an exact match.
  // Values in between are defined by the implementation.
  int match(T that);
}