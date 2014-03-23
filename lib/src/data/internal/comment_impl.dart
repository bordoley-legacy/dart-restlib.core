part of data.internal;

const String _CLOSE_PARENTHESES_CHAR = ")";
const int _CLOSE_PARENTHESES_CHAR_CODE = 41;

const String _ESCAPE_CHAR = "\\";
const int _ESCAPE_CHAR_CODE = 92;

const String _OPEN_PARENTHESES_CHAR = "(";
const int _OPEN_PARENTHESES_CHAR_CODE = 40;

final Parser<Comment> COMMENT =
  (OPEN_PARENTHESES + _COMMENT_SEGMENT.many() + CLOSE_PARENTHESES)
    .map((final Tuple3<int, Iterable<Either<String, Comment>>, int> e) =>
        _Comment.EMPTY.addAll(e.e1));

final Parser<Either<String, Comment>> _COMMENT_SEGMENT =
  (_COMMENT_TEXT ^ rec(() => COMMENT));

const Parser<String> _COMMENT_TEXT = const _CommentTextParser();

class _CommentTextParser extends ParserBase<String> {
  const _CommentTextParser();

  ParseResult<String> parseFrom(final IterableString str) {
    final CodePointIterator itr = str.iterator;
    StringBuffer sb = null;

    createBuffer() {
      if (sb == null) {
        sb = new StringBuffer(str.substring(0, itr.index - 1).toString());
      }
    }

    write(final int char) {
      if (sb != null) {
        sb.write(new String.fromCharCode(char));
      }
    }

    while (itr.moveNext()) {
      if (itr.current == _ESCAPE_CHAR_CODE) {
        if (!itr.moveNext()) {
          return new ParseResult.eof(str);
        }

        if (!QUOTED_CPAIR_CHAR.matches(itr.current)) {
          return new ParseResult.failure(str);
        }

        createBuffer();
      } else if (!CTEXT.matches(itr.current)) {
        itr.movePrevious();
        break;
      }
      write(itr.current);
    }

    final int endIndex = itr.index + 1;

    if (sb != null) {
      return new ParseResult.success(sb.toString(), str.substring(endIndex));
    } else if (1 < endIndex){
      return new ParseResult.success(str.substring(0, endIndex).toString(), str.substring(endIndex));
    } else {
      return new ParseResult.eof(str);
    }
  }
}

String _encodeCommentText(String comment) {
    StringBuffer buffer = null;

    write(final int c) {
      if (buffer != null) {
        buffer.write(new String.fromCharCode(c));
      }
    }

    createBuffer(final int index) {
      if (buffer == null) {
        buffer = new StringBuffer(comment.substring(0, index));
      }
    }

    for (int i = 0; i < comment.length; i++) {
      int c = comment.codeUnitAt(i);
      if (CTEXT.matches(c)) {
        write(c);
      } else if (
          c == _OPEN_PARENTHESES_CHAR_CODE  ||
          c == _CLOSE_PARENTHESES_CHAR_CODE ||
          c == _ESCAPE_CHAR_CODE) {
        createBuffer(i);
        write(_ESCAPE_CHAR_CODE);
        write(c);
      } else {
        throw new ArgumentError();
      }
    }

    return buffer != null ? buffer.toString() : comment;
  }

class _Comment
    extends Object
    with ForwardingIterable<Either<String, Comment>>,
      ForwardingAssociative<int, Either<String, Comment>>,
      ForwardingSequence<Either<String, Comment>>
    implements Comment {
  static final Comment EMPTY = new _Comment(EMPTY_SEQUENCE);

  final ImmutableSequence<Either<String, Comment>> delegate;

  _Comment(this.delegate);

  int get hashCode =>
      delegate.hashCode;

  bool operator==(final other) =>
      delegate == other;

  Comment add(final Either<String, Comment> value) {
    // Validate the text
    value.left.map(_encodeCommentText);
    return new _Comment(delegate.add(value));
  }

  Comment addAll(final Iterable<Either<String, Comment>> elements) =>
      elements.fold(this, (final Comment acc, final Either<String, Comment> element) =>
          this.add(element));

  Option<Either<String, Comment>> call(final int key) =>
      this[key];

  Comment remove(final Either<String, Comment> element) =>
      new _Comment(delegate.remove(element));

  Comment get tail =>
      new _Comment(delegate.tail);

  Comment push(final Either<String, Comment> value) =>
      add(value);

  Comment pushAll(final Iterable<Either<String, Comment>> other) =>
      addAll(other);

  Comment putAll(final Iterable<Pair<int, Either<String, Comment>>> other) =>
      other.fold(this, (final Comment acc, Pair<int, Either<String, Comment>> value) =>
          acc.putPair(value));

  Comment putAllFromMap(final Map<int,Either<String, Comment>> map) {
    Comment retval = this;
    map.forEach((final int key, final Either<String, Comment> value) {
      retval = retval.put(key, value);
    });
    return retval;
  }

  Comment put(final int key, final Either<String, Comment> value) {
    value.left.map(_encodeCommentText);
    return new _Comment(delegate.put(key, value));
  }

  Comment putPair(final Pair<int,Either<String, Comment>> pair) =>
      put(pair.e0, pair.e1);

  Comment removeAt(final int key) =>
      new _Comment(delegate.removeAt(key));

  Comment subSequence(final int start, final int length) =>
      new _Comment(delegate.subSequence(start, length));

  String toString() =>
      (new StringBuffer()
        ..write(_OPEN_PARENTHESES_CHAR)
        ..write(
            map((final Either<String, Comment> either) =>
                either.fold(_encodeCommentText, objectToString)).join(""))
        ..write(_CLOSE_PARENTHESES_CHAR)
      ).toString();
}