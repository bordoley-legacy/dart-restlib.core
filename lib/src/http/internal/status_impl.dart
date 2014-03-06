part of http.internal;

class StatusImpl implements Status {
  static final MutableDictionary<Status, Response> _statusResponses = new MutableDictionary.hash();

  final int code;
  final String message;
  final String reason;
  final StatusClass statusClass;

  const StatusImpl(this.code, this.reason, this.message,  this.statusClass);

  int get hashCode => computeHashCode([code]);

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Status) {
      return this.code == other.code;
    } else {
      return false;
    }
  }

  Response toResponse() =>
      _statusResponses[this].orCompute(() {
        final Response response = new Response(this, entity : this.message);
        _statusResponses[this] = response;
        return response;
      });


  String toString() {
    return "$code $reason";
  }
}