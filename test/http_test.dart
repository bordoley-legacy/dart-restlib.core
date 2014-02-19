library restlib.http_test;

import "package:restlib_common/collections.dart";
import "package:restlib_common/collections.immutable.dart";
import "package:restlib_testing/testing.dart";

import "package:unittest/unittest.dart";

import "package:restlib_core/data.dart";

// FIXME: should not import this.
import "package:restlib_core/data.internal.dart";
import "package:restlib_core/http.dart";
import "package:restlib_core/data.media_ranges.dart";
import "package:restlib_core/net.dart";
import "package:restlib_parsing/parsing.dart";

part "src/http/preference_test.dart";
part "src/http/request_test.dart";

httpTestGroups() {
  group("class Preference", preferenceTests);
  group("class:Request", requestTests);
}

main() {
  httpTestGroups();
}