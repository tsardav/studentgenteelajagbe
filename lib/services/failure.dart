abstract class Failure {
  String failureMessage();
}

class ValidationFailure implements Failure {
  late String message;
  ValidationFailure(this.message);

  @override
  String failureMessage() {
    return message;
  }
}

class CancelFailure implements Failure {
  @override
  String failureMessage() {
    return "request_to_server_was_cancelled";
  }
}

class ServerFailure implements Failure {
  @override
  String failureMessage() {
    return "something_went_wrong_and_your_request_could_not_be_completed";
  }
}

class InternetFailure implements Failure {
  @override
  String failureMessage() {
    return "no_internet_connection";
  }
}

class BadResponseFailure implements Failure {
  final dynamic message;

  BadResponseFailure({this.message});

  @override
  String failureMessage() {
    return message ?? "Bad response from the server";
  }
}

class ConnectionTimeOutFailure implements Failure {
  @override
  String failureMessage() {
    return "connection_timeout_with_server";
  }
}

class ReceivedTimeOutFailure implements Failure {
  @override
  String failureMessage() {
    return "";
  }
}

class SendTimeOutFailure implements Failure {
  @override
  String failureMessage() {
    return "send_timeout_in_connection_with_server";
  }
}

class ConnectionFailure implements Failure {
  @override
  String failureMessage() {
    return "Connection to server failed due to internet connection";
  }
}

class BadCertificateFailure implements Failure {
  @override
  String failureMessage() {
    return "Bad Certificate";
  }
}

class BadRequestFailure implements Failure {
  @override
  String failureMessage() {
    return "";
  }
}

class DBFailure implements Failure {
  final dynamic message;

  DBFailure({this.message});
  @override
  String failureMessage() {
    return message ?? "Something went wrong";
  }
}
