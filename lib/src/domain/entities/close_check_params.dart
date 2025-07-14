import 'dart:convert';

/// Parameters used to close a check.
class CloseCheckParams {
  /// COM port number.
  final int comNumber;

  /// Baud rate of the connection.
  final int baudRate;

  /// Communication timeout in milliseconds.
  final int timeout;

  /// Operator password.
  final int operatorPassword;

  /// Total payment in type 1.
  final int summ1;

  /// Total payment in type 2.
  final int summ2;

  /// Total payment in type 3.
  final int summ3;

  /// Total payment in type 4.
  final int summ4;

  /// Discount applied to the check.
  final double discountOnCheck;

  /// Tax code 1.
  final int tax1;

  /// Tax code 2.
  final int tax2;

  /// Tax code 3.
  final int tax3;

  /// Tax code 4.
  final int tax4;

  /// Additional text printed at the bottom of the check.
  final String text;

  /// Creates a new instance of [CloseCheckParams].
  CloseCheckParams({
    required this.comNumber,
    required this.baudRate,
    required this.timeout,
    required this.operatorPassword,
    required this.summ1,
    required this.summ2,
    required this.summ3,
    required this.summ4,
    required this.discountOnCheck,
    required this.tax1,
    required this.tax2,
    required this.tax3,
    required this.tax4,
    required this.text,
  });

  /// Converts this object to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comNumber': comNumber,
      'baudRate': baudRate,
      'timeout': timeout,
      'operatorPassword': operatorPassword,
      'summ1': summ1,
      'summ2': summ2,
      'summ3': summ3,
      'summ4': summ4,
      'discountOnCheck': discountOnCheck,
      'tax1': tax1,
      'tax2': tax2,
      'tax3': tax3,
      'tax4': tax4,
      'text': text,
    };
  }

  /// Creates an instance from a [Map].
  factory CloseCheckParams.fromMap(Map<String, dynamic> map) {
    return CloseCheckParams(
      comNumber: map['comNumber'] as int,
      baudRate: map['baudRate'] as int,
      timeout: map['timeout'] as int,
      operatorPassword: map['operatorPassword'] as int,
      summ1: map['summ1'] as int,
      summ2: map['summ2'] as int,
      summ3: map['summ3'] as int,
      summ4: map['summ4'] as int,
      discountOnCheck: map['discountOnCheck'] as double,
      tax1: map['tax1'] as int,
      tax2: map['tax2'] as int,
      tax3: map['tax3'] as int,
      tax4: map['tax4'] as int,
      text: map['text'] as String,
    );
  }

  /// Encodes to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes from JSON.
  factory CloseCheckParams.fromJson(String source) =>
      CloseCheckParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
