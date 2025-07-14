import 'dart:convert';

/// Parameters for the `ReturnSale` command.
class ReturnSaleParams {
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

  /// Creates a new [ReturnSaleParams] instance.
  ReturnSaleParams({
    required this.comNumber,
    required this.baudRate,
    required this.timeout,
    required this.operatorPassword,
    required this.quantity,
    required this.price,
    required this.department,
    this.tax1 = 0,
    this.tax2 = 0,
    this.tax3 = 0,
    this.tax4 = 0,
    this.text = '',
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
  factory ReturnSaleParams.fromMap(Map<String, dynamic> map) {
    return ReturnSaleParams(
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
  factory ReturnSaleParams.fromJson(String source) =>
      ReturnSaleParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
