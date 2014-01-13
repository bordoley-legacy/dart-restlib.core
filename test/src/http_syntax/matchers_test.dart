part of restlib.http_syntax_test;

matchersTests() {
  test("WS", (){
    for (int i = 0; i < 0x100; i++) {
      bool match = WS.matches(i);
      if (i != "\t".runes.single && 
          i != " ".runes.single) {
        expect(match, isFalse);
      } else {
        expect(match, isTrue);
      }
    }
  });
  
  test("OBS_TEXT", (){
    for (int i = 0; i < 0x100; i++) {
      bool match = OBS_TEXT.matches(i);
      if (i >= 0x80 && i <= 0xFF) {
        expect(match, isTrue);
      } else {
        expect(match, isFalse);
      }
      
    }
  });
  
  test("QD_TEXT", (){
    for (int i = 0; i < 0x100; i++) {
      bool match = QD_TEXT.matches(i);
      if (i < "\t".runes.single) { expect(match, isFalse, reason:"$i"); }
    }
  });
}