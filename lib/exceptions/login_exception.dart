class LoginException implements Exception {
  String cause;

  LoginException(this.cause);
}

class ExceptionHandler {
  getExceptionString(error) {
    return error;
  }
}
