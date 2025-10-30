import 'dart:convert';

/// Parameters for sending a custom TLV tag to the fiscal register.
class SendTagParams {
  /// COM port number.
  final int comNumber;

  /// Baud rate.
  final int baudRate;

  /// Timeout in milliseconds.
  final int timeout;

  /// Operator password.
  final int operatorPassword;

  /// Tag number (e.g., 1008 for email, 1228 for TIN).
  final int tagNumber;

  /// Tag data type (use TagType constants).
  final int tagType;

  /// Tag value as string.
  final String tagValue;

  /// Creates parameters for sending a tag.
  SendTagParams({
    required this.comNumber,
    required this.baudRate,
    required this.timeout,
    required this.operatorPassword,
    required this.tagNumber,
    required this.tagType,
    required this.tagValue,
  });

  /// Converts to a Map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comNumber': comNumber,
      'baudRate': baudRate,
      'timeout': timeout,
      'operatorPassword': operatorPassword,
      'tagNumber': tagNumber,
      'tagType': tagType,
      'tagValue': tagValue,
    };
  }

  /// Creates from a Map.
  factory SendTagParams.fromMap(Map<String, dynamic> map) {
    return SendTagParams(
      comNumber: map['comNumber'] as int,
      baudRate: map['baudRate'] as int,
      timeout: map['timeout'] as int,
      operatorPassword: map['operatorPassword'] as int,
      tagNumber: map['tagNumber'] as int,
      tagType: map['tagType'] as int,
      tagValue: map['tagValue'] as String,
    );
  }

  /// Encodes to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes from JSON.
  factory SendTagParams.fromJson(String source) =>
      SendTagParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
