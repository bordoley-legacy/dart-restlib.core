part of restlib.core.http_syntax;

class _QuotedStringParser extends AbstractParser<String> {
  final int _DQUOTE_CHAR = 34;
  final int _ESCAPE_CHAR = 92;
  
  const _QuotedStringParser();
  
  Option<String> doParse(final StringIterator itr) {
    int startIndex = itr.index;
    int endIndex = startIndex;
    
    // Only use a buffer if there are escaped chars in the string.
    StringBuffer buffer = null;
    
    if (!itr.moveNext() || itr.current != _DQUOTE_CHAR) {
      return null;
    }
    
    while(itr.moveNext()) {
      int c = itr.current;
      
      if (QD_TEXT.matches(c)) {
        if (buffer != null) {
          buffer.writeCharCode(c); 
        } else {
          endIndex++;
        }
      } else if (c == _ESCAPE_CHAR) {
        // Create a new buffer if needed and copy all of the already parsed string 
        // into the buffer.
        if (buffer == null) {
          buffer = new StringBuffer(itr.string.substring(startIndex, endIndex));
        }
        
        if (!itr.moveNext()) {
          return Option.NONE;
        } 
        
        if (QUOTED_PAIR_CHAR.matches(itr.current)) {
          buffer.writeCharCode(itr.current);
        } else {
          return Option.NONE;
        }
      } else if (c == _DQUOTE_CHAR) {        
        if (buffer != null) {
          return new Option(buffer.toString());
        } else {
          endIndex++;
          return new Option(itr.string.substring(startIndex + 2, endIndex + 1));
        }
      } else {
        return Option.NONE;
      }
    }
    
    return Option.NONE;
  }
  
  String toString() => "QuotedStringParser";
}