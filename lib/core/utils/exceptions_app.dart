class NetworkException extends BaseAppException {
  NetworkException(String message) : super(message: message);
}

class ExceptionGeneral extends BaseAppException {
  ExceptionGeneral({
    super.message,
  });
}
abstract class BaseAppException implements Exception {
  final String message;

  BaseAppException({this.message = ""});
}
