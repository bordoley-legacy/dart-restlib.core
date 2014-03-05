part of http.internal;

class MethodImpl implements Method {

  final String name;

  const MethodImpl(this.name);

  int get hashCode => name.hashCode;

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Method) {
      return this.toString() == other.toString();
    } else {
      return false;
    }
  }

  String toString() => name;
}