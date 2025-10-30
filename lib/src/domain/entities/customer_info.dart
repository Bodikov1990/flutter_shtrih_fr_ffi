import 'validation_exception.dart';

/// Information about the customer for fiscal receipt.
/// Used to send electronic receipts and identify customers.
class CustomerInfo {
  /// Customer email address (tag 1008).
  /// Used for sending electronic receipt to customer.
  final String? email;

  /// Customer phone number (tag 1008).
  /// Can be used instead of email for receipt delivery.
  final String? phone;

  /// Customer TIN - Tax Identification Number (tag 1228).
  /// ИИН/БИН for Kazakhstan - 12 digits.
  final String? tin;

  /// Creates customer information.
  ///
  /// At least one field should be provided.
  /// Throws [ValidationException] if validation fails.
  CustomerInfo({
    this.email,
    this.phone,
    this.tin,
  }) {
    // Validate email format if provided
    if (email != null && !_isValidEmail(email!)) {
      throw ValidationException(
        'Invalid email format',
        parameterName: 'email',
      );
    }

    // Validate TIN format if provided (12 digits for Kazakhstan)
    if (tin != null && !_isValidTIN(tin!)) {
      throw ValidationException(
        'TIN must contain exactly 12 digits',
        parameterName: 'tin',
      );
    }

    // Validate phone format if provided
    if (phone != null && phone!.isEmpty) {
      throw ValidationException(
        'Phone number cannot be empty',
        parameterName: 'phone',
      );
    }
  }

  /// Checks if any customer information is provided.
  bool get hasAnyInfo => email != null || phone != null || tin != null;

  /// Validates email format.
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email) && email.length <= 64;
  }

  /// Validates TIN format (12 digits).
  bool _isValidTIN(String tin) {
    return RegExp(r'^\d{12}$').hasMatch(tin);
  }

  @override
  String toString() {
    final parts = <String>[];
    if (email != null) parts.add('email: $email');
    if (phone != null) parts.add('phone: $phone');
    if (tin != null) parts.add('tin: $tin');
    return 'CustomerInfo(${parts.join(', ')})';
  }
}
