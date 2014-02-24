part of restlib.core.http.internal;

Parser<Preference> preferenceParser(final Parser<Matcheable> valueParser) {
    final Parser<Iterable<KeyValuePair>> KEY_VALUE_PAIRS =
        (OWS_SEMICOLON_OWS + KVP.sepBy1(OWS_SEMICOLON_OWS))
             .map((final Iterable e) =>
                 e.elementAt(1))
             .orElse([]);

    final Parser<int> FRACTIONAL_PART =
        (PERIOD + DIGIT + DIGIT.orElse(0) + DIGIT.orElse(0))
          .map((final Iterable e){
            final int _100s = e.elementAt(1) * 100;
            final int _10s = e.elementAt(2) * 10;
            final int _1s = e.elementAt(3);

            return _100s + _10s + _1s;
          }).orElse(0);

    final Parser<int> QF_PARSER =
        (DIGIT + FRACTIONAL_PART).map((final Iterable<int> e){
          final int _1000s = e.elementAt(0) * 1000;
          final int retval = _1000s + e.elementAt(1);

          if (retval > 1000) {
            return null;
          }
          return retval;
        });

    return (valueParser + KEY_VALUE_PAIRS)
      .map((final Iterable e) {
        final Matcheable value = e.elementAt(0);
        final Iterable<KeyValuePair> parameters = e.elementAt(1);

        if (parameters.isEmpty) {
          return new Preference(value);
        }

        final KeyValuePair qfPair = parameters.first;
        if (qfPair.fst.toLowerCase() != "q") {
          return null;
        }

        final Option<int> qfValue = QF_PARSER.parse(qfPair.snd);
        if (qfValue.isEmpty) {
          return null;
        }

        return new Preference(value, qualityFactor: qfValue.value, parameters: EMPTY_SEQUENCE_MULTIMAP.putAll(parameters.skip(1)));
      });
  }