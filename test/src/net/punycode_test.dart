part of restlib.core.net_test;

// see: https://github.com/bestiejs/punycode.js/blob/master/tests/tests.js
void _doTestPunyCodeEncode(final String description, final String decoded, final String encoded) =>
    group(description, () {
      test("toDomainName()", () => 
          expect(_toASCII(decoded), equals(encoded)));
      test("toInternationalDomainName()", () =>
          expect(_toUnicode(encoded), equals(decoded)));
    });

void testPunyCodeEncode() {
  group("punycode encode()", () {
    _doTestPunyCodeEncode("a single basic code point", "Bach", "xn--Bach-");
    _doTestPunyCodeEncode("a single non-ASCII character", "\xFC", "xn--tda");
    
    _doTestPunyCodeEncode(
    "multiple non-ASCII characters",
      "\xFC\xEB\xE4\xF6\u2665",
      "xn--4can8av2009b");
    _doTestPunyCodeEncode(
    "mix of ASCII and non-ASCII characters",
      "b\xFCcher",
      "xn--bcher-kva"
    );
    
    _doTestPunyCodeEncode(
    "long string with both ASCII and non-ASCII characters",
      "Willst du die Bl\xFCthe des fr\xFChen, die Fr\xFCchte des sp\xE4teren Jahres",
      "xn--Willst du die Blthe des frhen, die Frchte des spteren Jahres-x9e96lkal"
    );
    
// http://tools.ietf.org/html/rfc3492#section-7.1
    _doTestPunyCodeEncode(
    "Arabic (Egyptian)",
      "\u0644\u064A\u0647\u0645\u0627\u0628\u062A\u0643\u0644\u0645\u0648\u0634\u0639\u0631\u0628\u064A\u061F",
      "xn--egbpdaj6bu4bxfgehfvwxn"
    );
    
    _doTestPunyCodeEncode(
    "Chinese (simplified)",
      "\u4ED6\u4EEC\u4E3A\u4EC0\u4E48\u4E0D\u8BF4\u4E2d\u6587",
      "xn--ihqwcrb4cv8a8dqg056pqjye"
    );
    
    _doTestPunyCodeEncode(
    "Chinese (traditional)",
      "\u4ED6\u5011\u7232\u4EC0\u9EBD\u4E0D\u8AAA\u4E2D\u6587",
      "xn--ihqwctvzc91f659drss3x8bo0yb"
    );
    
    _doTestPunyCodeEncode(
    "Czech",
      "Pro\u010Dprost\u011Bnemluv\xED\u010Desky",
      "xn--Proprostnemluvesky-uyb24dma41a"
    );
    
    _doTestPunyCodeEncode(
    "Hebrew",
      "\u05DC\u05DE\u05D4\u05D4\u05DD\u05E4\u05E9\u05D5\u05D8\u05DC\u05D0\u05DE\u05D3\u05D1\u05E8\u05D9\u05DD\u05E2\u05D1\u05E8\u05D9\u05EA",
      "xn--4dbcagdahymbxekheh6e0a7fei0b"
    );
    
    _doTestPunyCodeEncode(
    "Hindi (Devanagari)",
      "\u092F\u0939\u0932\u094B\u0917\u0939\u093F\u0928\u094D\u0926\u0940\u0915\u094D\u092F\u094B\u0902\u0928\u0939\u0940\u0902\u092C\u094B\u0932\u0938\u0915\u0924\u0947\u0939\u0948\u0902",
      "xn--i1baa7eci9glrd9b2ae1bj0hfcgg6iyaf8o0a1dig0cd"
    );
    
    _doTestPunyCodeEncode(
    "Japanese (kanji and hiragana)",
      "\u306A\u305C\u307F\u3093\u306A\u65E5\u672C\u8A9E\u3092\u8A71\u3057\u3066\u304F\u308C\u306A\u3044\u306E\u304B",
      "xn--n8jok5ay5dzabd5bym9f0cm5685rrjetr6pdxa"
    );
    
    _doTestPunyCodeEncode(
    "Korean (Hangul syllables)",
      "\uC138\uACC4\uC758\uBAA8\uB4E0\uC0AC\uB78C\uB4E4\uC774\uD55C\uAD6D\uC5B4\uB97C\uC774\uD574\uD55C\uB2E4\uBA74\uC5BC\uB9C8\uB098\uC88B\uC744\uAE4C",
      "xn--989aomsvi5e83db1d2a355cv1e0vak1dwrv93d5xbh15a0dt30a5jpsd879ccm6fea98c"
    );
    
    /**
     * As there"s no way to do it in JavaScript, Punycode.js doesn"t support
     * mixed-case annotation (which is entirely optional as per the RFC).
     * So, while the RFC sample string encodes to:
     * `b1abfaaepdrnnbgefbaDotcwatmq2g4l`
     * Without mixed-case annotation it has to encode to:
     * `b1abfaaepdrnnbgefbadotcwatmq2g4l`
     * https://github.com/bestiejs/punycode.js/issues/3
     */
    
    _doTestPunyCodeEncode(
    "Russian (Cyrillic)",
      "\u043F\u043E\u0447\u0435\u043C\u0443\u0436\u0435\u043E\u043D\u0438\u043D\u0435\u0433\u043E\u0432\u043E\u0440\u044F\u0442\u043F\u043E\u0440\u0443\u0441\u0441\u043A\u0438",
      "xn--b1abfaaepdrnnbgefbadotcwatmq2g4l"
    );
    
    _doTestPunyCodeEncode(
    "Spanish",
      "Porqu\xE9nopuedensimplementehablarenEspa\xF1ol",
      "xn--PorqunopuedensimplementehablarenEspaol-fmd56a"
    );
    
    _doTestPunyCodeEncode(
    "Vietnamese",
      "T\u1EA1isaoh\u1ECDkh\xF4ngth\u1EC3ch\u1EC9n\xF3iti\u1EBFngVi\u1EC7t",
      "xn--TisaohkhngthchnitingVit-kjcr8268qyxafd2f1b9g"
    );
    
    _doTestPunyCodeEncode("",
      "3\u5E74B\u7D44\u91D1\u516B\u5148\u751F",
      "xn--3B-ww4c5e180e575a65lsy2b"
    );
    
    _doTestPunyCodeEncode("", 
      "\u5B89\u5BA4\u5948\u7F8E\u6075-with-SUPER-MONKEYS",
      "xn---with-SUPER-MONKEYS-pc58ag80a8qai00g7n9n"
    );
    
    _doTestPunyCodeEncode("",
      "Hello-Another-Way-\u305D\u308C\u305E\u308C\u306E\u5834\u6240",
      "xn--Hello-Another-Way--fc4qua05auwb3674vfr0b"
    );
    
    _doTestPunyCodeEncode("",
      "\u3072\u3068\u3064\u5C4B\u6839\u306E\u4E0B2",
      "xn--2-u9tlzr9756bt3uc0v"
    );
    
    _doTestPunyCodeEncode("",
      "Maji\u3067Koi\u3059\u308B5\u79D2\u524D",
      "xn--MajiKoi5-783gue6qz075azm5e"
    );
    
    _doTestPunyCodeEncode("",
      "\u30D1\u30D5\u30A3\u30FCde\u30EB\u30F3\u30D0",
      "xn--de-jg4avhby1noc0d"
    );
    
    _doTestPunyCodeEncode("",
      "\u305D\u306E\u30B9\u30D4\u30FC\u30C9\u3067",
      "xn--d9juau41awczczp"
    );
    
    /**
     * This example is an ASCII string that breaks the existing rules for host
     * name labels. (It"s not a realistic example for IDNA, because IDNA never
     * encodes pure ASCII labels.)
     */
    _doTestPunyCodeEncode(
    "ASCII string that breaks the existing rules for host-name labels",
      "-> \$1.00 <-",
      "xn---> \$1.00 <--");
    
    _doTestPunyCodeEncode(
        "",
       "ma\xF1ana.com",
      "xn--maana-pta.com"
    );
    
    _doTestPunyCodeEncode(
        "",
    "b\xFCcher.com",
      "xn--bcher-kva.com"
    );
    
    _doTestPunyCodeEncode(
        "",
    "caf\xE9.com",
      "xn--caf-dma.com"
    );
    
    _doTestPunyCodeEncode("",
    "\u2603-\u2318.com",
      "xn----dqo34k.com"
    );
    
    _doTestPunyCodeEncode("",
    "\uD400\u2603-\u2318.com",
      "xn----dqo34kn65z.com"
    );
    
    _doTestPunyCodeEncode(
    "Emoji",
       "\u1F4A9.la",
      "xn--ls8h.la"
    );
    
    _doTestPunyCodeEncode("Using U+002E as separator",
                      "ma\xF1ana\x2Ecom",
                     "xn--maana-pta.com"
                   );
    _doTestPunyCodeEncode(
                    "Using U+3002 as separator",
                      "ma\xF1ana\u3002com",
                     "xn--maana-pta.com"
                   );
    
    _doTestPunyCodeEncode(
                    "Using U+FF0E as separator",
                      "ma\xF1ana\uFF0Ecom",
                     "xn--maana-pta.com"
                   );
    
    _doTestPunyCodeEncode(
                    "Using U+FF61 as separator",
                      "ma\xF1ana\uFF61com",
                     "xn--maana-pta.com"
                   );
  });
}