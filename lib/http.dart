library http;

import "package:restlib_common/collections.dart";
import "package:restlib_common/collections.immutable.dart";
import "package:restlib_common/collections.mutable.dart";
import "package:restlib_common/objects.dart";
import "package:restlib_common/preconditions.dart";

import "package:restlib_parsing/parsing.dart";

import "data.dart";
import "data.dart" as data;
import "data.internal.dart" as DataInternal;
import "http.headers.dart";
import "http.internal.dart";
import "http.methods.dart";
import "http.statuses.dart";
import "net.dart";

part "src/http/content_info.dart";
part "src/http/header.dart";
part "src/http/header_parsers.dart";
part "src/http/method.dart";
part "src/http/preference.dart";
part "src/http/request.dart";
part "src/http/request_extension_filter.dart";
part "src/http/request_method_override_filter.dart";
part "src/http/request_preconditions.dart";
part "src/http/request_preferences.dart";
part "src/http/response.dart";
part "src/http/status.dart";

abstract class _Parseable {
  SequenceMultimap<Header, String> get _headers;

  Option _parse(final Parser parser, final Header header) {
    // Special case Set-Cookie per RFC
    if (header == SET_COOKIE) {
      final Iterable parsed =
          _headers[header].expand((final String setCookie) =>
              parser.parse(setCookie).left);
      return parsed.isEmpty ? Option.NONE : new Option(parsed);
    } else {
      return parser.parse(_headers[header].join(",")).left;
    }
  }
}
