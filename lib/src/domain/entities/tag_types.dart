/// Types of data for TLV tags used by the fiscal register.
class TagType {
  /// Single byte value (0-255)
  static const int byte = 0;

  /// Unsigned 16-bit integer
  static const int uint16 = 1;

  /// Unsigned 32-bit integer
  static const int uint32 = 2;

  /// Variable length number
  static const int vln = 3;

  /// Floating point variable length number
  static const int fvln = 4;

  /// String value
  static const int string = 5;

  /// Unix timestamp
  static const int unixtime = 6;

  /// Structured TLV (nested structure)
  static const int stlv = 7;

  /// Byte array
  static const int byteArray = 8;
}

/// Commonly used tag numbers for fiscal operations.
class TagNumber {
  /// Customer email or phone number (for electronic receipt delivery)
  static const int customerEmail = 1008;

  /// Customer email (alternative tag)
  static const int customerEmailAlt = 1117;

  /// Customer TIN (Tax Identification Number) - ИИН/БИН for Kazakhstan
  static const int customerTIN = 1228;

  /// Customer phone number
  static const int customerPhone = 1008;
}
