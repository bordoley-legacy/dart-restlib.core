library restlib.core.net_test;

import "dart:convert";

import "package:restlib_common/collections.dart";
import "package:restlib_core/net.dart";
import "package:restlib_parsing/parsing.dart" as parse;

import "package:unittest/unittest.dart";

part "src/net/authority_test.dart";
part "src/net/international_domain_name_test.dart";
part "src/net/punycode_test.dart";
part "src/net/uri_encoding_test.dart";
part "src/net/uri_test.dart";

main() {
  testPunyCodeEncode();
  uriTests();
  uriCodecTester();
}