library restlib.http_syntax_test;

import "package:restlib_core/http_syntax.dart";
import "package:unittest/unittest.dart";

part "src/http_syntax/matchers_test.dart";
part "src/http_syntax/primitive_parsers_test.dart";

httpSyntaxTestGroups() {
  group("matcher", matchersTests);
  group("parser", primitiveParserTests);
}

main() {
  httpSyntaxTestGroups();
}