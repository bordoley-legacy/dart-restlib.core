import "../../dart-restlib.server/test/connector_test.dart";
import "data_test.dart";
import "http_test.dart";
import "http_syntax_test.dart";
import "../../dart-restlib.server/test/server_test.dart";

void main() {  
  connectorTestGroups();
  dataTestGroups();
  httpTestGroups();
  httpSyntaxTestGroups();
  serverTestGroups();
}