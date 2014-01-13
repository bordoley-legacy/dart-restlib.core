library restlib.http_test;

import "package:restlib_common/collections.dart";
import "package:restlib_testing/testing.dart";

import "package:unittest/unittest.dart";

import "package:restlib_core/data.dart";
import "package:restlib_core/http.dart";
import "package:restlib_parsing/parsing.dart";

part "src/http/preference_test.dart";

httpTestGroups() {
  group("class Preference", preferenceTests);
}

main() {
  httpTestGroups();
}