import 'dart:convert';

/// Parameters required for the `Sale` command.
class SaleParams {
  /// COM port number.
  final int comNumber;

  /// Baud rate.
  final int baudRate;

  /// Timeout in milliseconds.
  final int timeout;

  /// Operator password.
  final int operatorPassword;

  /// Quantity of goods.
  final double quantity;

  /// Price in kopeks.
  final int price;

  /// Department number.
  final int department;

  /// Tax code 1.
  final int tax1;

  /// Tax code 2.
  final int tax2;

  /// Tax code 3.
  final int tax3;

  /// Tax code 4.
  final int tax4;

  /// Text to print in the check.
  final String text;

  /// Creates an instance of [SaleParams].
  SaleParams({
    required this.comNumber,
    required this.baudRate,
    required this.timeout,
    required this.operatorPassword,
    required this.quantity,
    required this.price,
    required this.department,
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
      'quantity': quantity,
      'price': price,
      'department': department,
      'tax1': tax1,
      'tax2': tax2,
      'tax3': tax3,
      'tax4': tax4,
      'text': text,
    };
  }

  /// Creates an instance from a [Map].
  factory SaleParams.fromMap(Map<String, dynamic> map) {
    return SaleParams(
      comNumber: map['comNumber'] as int,
      baudRate: map['baudRate'] as int,
      timeout: map['timeout'] as int,
      operatorPassword: map['operatorPassword'] as int,
      quantity: map['quantity'] as double,
      price: map['price'] as int,
      department: map['department'] as int,
      tax1: map['tax1'] as int,
      tax2: map['tax2'] as int,
      tax3: map['tax3'] as int,
      tax4: map['tax4'] as int,
      text: map['text'] as String,
    );
  }

  /// Encodes parameters to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes parameters from JSON.
  factory SaleParams.fromJson(String source) =>
      SaleParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
