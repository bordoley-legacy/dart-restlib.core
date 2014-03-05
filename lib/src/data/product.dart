part of data;

abstract class Product {
  static final Parser<Product> parser = PRODUCT;

  String get name;
  String get version;
}