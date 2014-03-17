part of http.internal;

Parser<Preference> preferenceParser(final Parser<Matcheable> valueParser) {
    final Parser<Iterable<KeyValuePair>> KEY_VALUE_PAIRS =
        (OWS_SEMICOLON_OWS + KVP.sepBy1(OWS_SEMICOLON_OWS))
             .map((final Pair<String, Iterable<KeyValuePair>> e) => e.e1)
             .orElse([]);

    final Parser<int> FRACTIONAL_PART =
        (PERIOD + DIGIT + DIGIT.orElse(0) + DIGIT.orElse(0))
          .map((final Tuple4<int, int, int, int> e){
            final int _100s = e.e1 * 100;
            final int _10s = e.e2 * 10;
            final int _1s = e.e3;

            return _100s + _10s + _1s;
          }).orElse(0);

    final Parser<int> QF_PARSER =
        (DIGIT + FRACTIONAL_PART).map((final Pair<int,int> e){
          final int _1000s = e.e0 * 1000;
          final int retval = _1000s + e.e1;

          if (retval > 1000) {
            return null;
          }
          return retval;
        });

    return (valueParser + KEY_VALUE_PAIRS)
      .map((final Pair<Matcheable, Iterable<KeyValuePair>> e) {
        final Matcheable value = e.e0;
        final Iterable<KeyValuePair> parameters = e.e1;

        if (parameters.isEmpty) {
          return new Preference(value);
        }

        final KeyValuePair qfPair = parameters.first;
        if (qfPair.e0.toLowerCase() != "q") {
          return null;
        }

        final Option<int> qfValue = QF_PARSER.parse(qfPair.e1).left;
        if (qfValue.isEmpty) {
          return null;
        }

        return new Preference(value, qualityFactor: qfValue.value, parameters: EMPTY_SEQUENCE_MULTIMAP.putAll(parameters.skip(1)));
      });
  }