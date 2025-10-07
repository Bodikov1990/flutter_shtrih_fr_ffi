/// Exception thrown when parameter validation fails.
class ValidationException implements Exception {
  /// The error message describing the validation failure.
  final String message;

  /// The parameter name that failed validation.
  final String? parameterName;

  /// Creates a validation exception with the given [message] and optional [parameterName].
  ValidationException(this.message, {this.parameterName});

  @override
  String toString() {
    if (parameterName != null) {
      return 'ValidationException: $parameterName - $message';
    }
    return 'ValidationException: $message';
  }
}
