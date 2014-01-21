library restlib.core.http;

import "package:restlib_common/collections.dart";
import "package:restlib_common/collections.immutable.dart";
import "package:restlib_common/collections.mutable.dart";
import "package:restlib_common/objects.dart";
import "package:restlib_common/preconditions.dart";

import "package:restlib_parsing/parsing.dart";

import "data.dart";
import "http_syntax.dart";

part "src/http/content_info.dart";
part "src/http/header.dart";
part "src/http/header_parsers.dart";
part "src/http/method.dart";
part "src/http/preference.dart";
part "src/http/request.dart";
part "src/http/request_extension_filter.dart";
part "src/http/request_preconditions.dart";
part "src/http/request_preferences.dart";
part "src/http/response.dart";
part "src/http/status.dart";

Option<Uri> _parseUri(final String uri) {
  checkNotNull(uri);

  if (uri.isEmpty) {
    return Option.NONE;
  } else {
    // FIXME: Try catch for exceptions.
    final Uri result = Uri.parse(uri);
    return new Option(result);
  }
}

abstract class _Parseable {
  SequenceMultimap<Header, String> get _headers;
  
  Option _parse(final Parser parser, final Header header) =>
      // FIXME: verify the join is correct
      parser.parse(_headers[header].join(","));
}