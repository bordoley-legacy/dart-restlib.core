part of data.internal;

final Parser<String> _OPTIONAL_FORWARD_SLASH_TOKEN =
  (FORWARD_SLASH + TOKEN)
    .optional()
    .map((final Option<Pair<int,String>> opt) =>
        opt.map((final Pair<int,String> e) => e.e1).orElse(""));

final Parser<Product> PRODUCT =
  (TOKEN + _OPTIONAL_FORWARD_SLASH_TOKEN)
    .map((final Pair<String, String> e) =>
        new ProductImpl._internal(e.e0, e.e1));

class ProductImpl implements Product {
  final String name;
  final String version;

  ProductImpl._internal(this.name, this.version);

  int get hashCode => computeHashCode([name, version]);

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Product) {
      return this.name == other.name &&
          this.version == other.version;
    } else {
      return false;
    }
  }

  String toString() =>
    name + (version.isEmpty ? "" : "/"  + version);
}