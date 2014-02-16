part of restlib.core.data;

const String _CLOSE_PARENTHESES_CHAR = ")";
const int _CLOSE_PARENTHESES_CHAR_CODE = 41;

const String _ESCAPE_CHAR = "\\";    
const int _ESCAPE_CHAR_CODE = 92;

const String _OPEN_PARENTHESES_CHAR = "(";
const int _OPEN_PARENTHESES_CHAR_CODE = 40;

final Parser<Comment> COMMENT =
  (OPEN_PARENTHESES + _COMMENT_SEGMENT.many() + CLOSE_PARENTHESES)
    .map((final Iterable e) =>
      new Comment._internal(
        EMPTY_SEQUENCE.addAll(e.elementAt(1))));

final Parser<Either<String, Comment>> _COMMENT_SEGMENT =
  (_COMMENT_TEXT ^ rec(() => COMMENT));

const Parser<String> _COMMENT_TEXT = const _CommentTextParser();

class _CommentTextParser extends AbstractParser<String> { 
  const _CommentTextParser();
  
  Option<String> doParse(final StringIterator itr) {
    StringBuffer sb = null;  
    final int startIndex = itr.index;
     
    createBuffer() {
      if (sb == null) {
        sb = new StringBuffer(
            itr.string.substring(startIndex + 1 , itr.index - 1));
      }
    } 
    
    write(final int char) {
      if (sb != null) {
        sb.write(new String.fromCharCode(char));
      }
    }

    while (itr.moveNext()) {      
      if (itr.current == _ESCAPE_CHAR_CODE) {
        if (!itr.moveNext() || !QUOTED_CPAIR_CHAR.matches(itr.current)) {
          return Option.NONE;
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
      return new Option(sb.toString());
    } else if (startIndex + 1 < endIndex){
      return new Option(itr.string.substring(startIndex+1, endIndex));
    } else {
      return Option.NONE;
    }
  }
} 

class Comment {       
  static String _encodeCommentText(String comment) { 
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
  
  final ImmutableSequence<Either<String, Comment>> _contents;
  
  Comment._internal(this._contents);
  
  int get hashCode => computeHashCode(_contents);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Comment) {
      return this._contents == other._contents;
    } else {
      return false;
    }
  }
  
  String toString() =>       
      (new StringBuffer()
        ..write(_OPEN_PARENTHESES_CHAR)
        ..write(
            _contents.map((final Either<String, Comment> either) => 
                either.fold(_encodeCommentText, objectToString)).join(""))
        ..write(_CLOSE_PARENTHESES_CHAR)     
      ).toString();
}