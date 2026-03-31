/// Normalised application exceptions.
///
/// Maps to the failure model in `agents/shared/api-contract.md`:
/// network · timeout · parse · not-found · unknown
library;

sealed class AppException implements Exception {
  const AppException(this.message, [this.originalError]);

  final String message;
  final Object? originalError;

  @override
  String toString() => '$runtimeType: $message';
}

/// Device is offline or the server is unreachable.
class NetworkException extends AppException {
  const NetworkException([
    super.message = 'Network error – check your connection',
    super.originalError,
  ]);
}

/// The request did not complete in time.
class TimeoutException extends AppException {
  const TimeoutException([
    super.message = 'Request timed out',
    super.originalError,
  ]);
}

/// The response could not be parsed into the expected format.
class ParseException extends AppException {
  const ParseException([
    super.message = 'Failed to parse response',
    super.originalError,
  ]);
}

/// The requested resource does not exist.
class NotFoundException extends AppException {
  const NotFoundException([
    super.message = 'Resource not found',
    super.originalError,
  ]);
}

/// Any error that does not fit the categories above.
class UnknownException extends AppException {
  const UnknownException([
    super.message = 'An unexpected error occurred',
    super.originalError,
  ]);
}
