import 'dart:convert';

import 'validation_exception.dart';

/// Parameters required to establish a connection with the fiscal register.
class ConnectionParams {
  /// COM port number (0 -> COM1).
  final int comNumber;

  /// Baud rate, usually `115200`.
  final int baudRate;

  /// Connection timeout in milliseconds.
  final int timeout;

  /// Operator password used for commands.
  final int operatorPassword;

  /// Creates a new set of connection parameters.
  ///
  /// Throws [ValidationException] if any parameter is invalid:
  /// - [comNumber] must be between 0 and 255
  /// - [baudRate] must be positive
  /// - [timeout] must be positive (recommended >= 5000)
  /// - [operatorPassword] must be between 0 and 99999999
  ConnectionParams({
    required this.comNumber,
    required this.baudRate,
    required this.timeout,
    required this.operatorPassword,
  }) {
    if (comNumber < 0 || comNumber > 255) {
      throw ValidationException(
        'Must be between 0 and 255',
        parameterName: 'comNumber',
      );
    }
    if (baudRate <= 0) {
      throw ValidationException(
        'Must be positive',
        parameterName: 'baudRate',
      );
    }
    if (timeout <= 0) {
      throw ValidationException(
        'Must be positive (recommended >= 5000 ms)',
        parameterName: 'timeout',
      );
    }
    if (operatorPassword < 0 || operatorPassword > 99999999) {
      throw ValidationException(
        'Must be between 0 and 99999999',
        parameterName: 'operatorPassword',
      );
    }
  }

  /// Converts the params into a [Map] for JSON encoding.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comNumber': comNumber,
      'baudRate': baudRate,
      'timeout': timeout,
      'operatorPassword': operatorPassword,
    };
  }

  /// Creates an instance from a [Map].
  factory ConnectionParams.fromMap(Map<String, dynamic> map) {
    return ConnectionParams(
      comNumber: map['comNumber'] as int,
      baudRate: map['baudRate'] as int,
      timeout: map['timeout'] as int,
      operatorPassword: map['operatorPassword'] as int,
    );
  }

  /// Encodes parameters to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes parameters from JSON.
  factory ConnectionParams.fromJson(String source) =>
      ConnectionParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
