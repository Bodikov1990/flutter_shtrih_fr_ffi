import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter_shtrih_fr_ffi/src/bindings.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/entities/check_type.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/entities/connection_type.dart';
import 'package:flutter_shtrih_fr_ffi/src/kkm_errors.dart';

/// Low level driver that wraps the native `classic_fr_drv_ng` library.
class StrihFrDriver {
  late Pointer<Void> _ctx;
  bool _initialized = false;

  void _ensureContext() {
    if (!_initialized) {
      _ctx = StrihFrBindings.cInit(nullptr);
      if (_ctx == nullptr) throw Exception('Init error');
      _initialized = true;
    }
  }

  /// Releases allocated resources.
  void deinit() {
    if (_initialized) {
      StrihFrBindings.cDeinit(_ctx);
      _initialized = false;
    }
  }

  String _strihErrorMessage(int code) => getErrorKey(code);

  /// Configures port parameters and connects to the device.
  ///
  /// [comNumber] — 0 → COM1
  /// [baudRate] — usually 115200
  /// [timeout]  — timeout in milliseconds.
  Future<void> connect({
    required int comNumber,
    required int baudRate,
    required int timeout,
  }) async {
    _ensureContext();

    try {
      StrihFrBindings.setComNumber(_ctx, comNumber);
      StrihFrBindings.setBaudRate(_ctx, baudRate);
      StrihFrBindings.setTimeout(_ctx, timeout);
      StrihFrBindings.setConnType(_ctx, ConnectionType.local);
      final code = StrihFrBindings.connect(_ctx);
      if (code != 0) throw Exception(_strihErrorMessage(code));
    } catch (e) {
      throw Exception('Connect failed: $e');
    }
  }

  /// Prints a shift report without cleaning.
  /// [operatorPassword] — operator password (0…99999999).
  Future<void> printReportWithoutCleaning({
    required int operatorPassword,
  }) async {
    _ensureContext();
    try {
      // Set operator password
      StrihFrBindings.setPassword(_ctx, operatorPassword);
      // Print report without cleaning
      final code = StrihFrBindings.printReportWithoutCleaning(_ctx);
      if (code != 0) throw Exception(_strihErrorMessage(code));
    } catch (e) {
      throw Exception('printReportWithoutCleaning failed: $e');
    }
  }

  /// Prints a shift report with cleaning.
  /// [operatorPassword] — operator password (0…99999999).
  Future<void> printReportWithCleaning({required int operatorPassword}) async {
    _ensureContext();
    try {
      // Set operator password
      StrihFrBindings.setPassword(_ctx, operatorPassword);
      // Print report without cleaning
      final code = StrihFrBindings.printReportWithCleaning(_ctx);
      if (code != 0) throw Exception(_strihErrorMessage(code));
    } catch (e) {
      throw Exception('printReportWithCleaning failed: $e');
    }
  }

  /// Executes a sale operation.
  ///
  /// [quantity] — quantity of goods,
  /// [price] — price in kopeks,
  /// [department] — department number,
  /// [tax1..4] — tax codes (0..15),
  /// [text] — arbitrary string printed in the check.
  Future<void> sale({
    required double quantity,
    required int price,
    required int department,
    required int operatorPassword,
    int tax1 = 0,
    int tax2 = 0,
    int tax3 = 0,
    int tax4 = 0,
    String text = '',
  }) async {
    _ensureContext();
    try {
      StrihFrBindings.setPassword(_ctx, operatorPassword);
      StrihFrBindings.setQuantity(_ctx, quantity);
      StrihFrBindings.setPrice(_ctx, price);
      StrihFrBindings.setDepartment(_ctx, department);
      StrihFrBindings.setTax1(_ctx, tax1);
      StrihFrBindings.setTax2(_ctx, tax2);
      StrihFrBindings.setTax3(_ctx, tax3);
      StrihFrBindings.setTax4(_ctx, tax4);
      final ptr = text.toNativeUtf8();
      StrihFrBindings.setStringForPrinting(_ctx, ptr, text.length);
      final code = StrihFrBindings.sale(_ctx);
      calloc.free(ptr);
      if (code != 0) throw Exception(_strihErrorMessage(code));
    } catch (e) {
      throw Exception('sale failed: $e');
    }
  }

  /// Closes the current check.
  ///
  /// [summ1..4] — totals in kopeks,
  /// [discountOnCheck] — discount on the check,
  /// [tax1..4] — tax codes,
  /// [text] — arbitrary text at the end of the check.
  Future<void> closeCheck({
    required int operatorPassword,
    required int summ1,
    required int summ2,
    required int summ3,
    required int summ4,
    required double discountOnCheck,
    required int tax1,
    required int tax2,
    required int tax3,
    required int tax4,
    String text = '',
  }) async {
    _ensureContext();
    try {
      StrihFrBindings.setPassword(_ctx, operatorPassword);
      StrihFrBindings.setSumm1(_ctx, summ1);
      StrihFrBindings.setSumm2(_ctx, summ2);
      StrihFrBindings.setSumm3(_ctx, summ3);
      StrihFrBindings.setSumm4(_ctx, summ4);
      StrihFrBindings.setDiscountOnCheck(_ctx, discountOnCheck);
      StrihFrBindings.setTax1(_ctx, tax1);
      StrihFrBindings.setTax2(_ctx, tax2);
      StrihFrBindings.setTax3(_ctx, tax3);
      StrihFrBindings.setTax4(_ctx, tax4);
      final ptr = text.toNativeUtf8();
      StrihFrBindings.setStringForPrinting(_ctx, ptr, text.length);
      final code = StrihFrBindings.closeCheck(_ctx);
      calloc.free(ptr);
      if (code != 0) throw Exception(_strihErrorMessage(code));
    } catch (e) {
      throw Exception('closeCheck failed: $e');
    }
  }

  /// Cancels the current check.
  /// [operatorPassword] — operator password.
  Future<void> cancelCheck({required int operatorPassword}) async {
    _ensureContext();
    try {
      StrihFrBindings.setPassword(_ctx, operatorPassword);
      final code = StrihFrBindings.cancelCheck(_ctx);
      if (code != 0) throw Exception(_strihErrorMessage(code));
    } catch (e) {
      throw Exception('cancelCheck failed: $e');
    }
  }

  /// Opens a check of the specified type with the operator password.
  Future<void> openCheck({
    required int operatorPassword,
    int checkType = CheckType.sale,
  }) async {
    _ensureContext();

    try {
      StrihFrBindings.setPassword(_ctx, operatorPassword);
      StrihFrBindings.setCheckType(_ctx, checkType);
      final code = StrihFrBindings.openCheck(_ctx);
      if (code != 0) throw Exception(_strihErrorMessage(code));
    } catch (e) {
      throw Exception('openCheck failed: $e');
    }
  }

  /// Executes a return sale operation.
  ///
  /// [quantity]        — quantity of goods
  /// [price]           — price in kopeks
  /// [department]      — department number
  /// [operatorPassword] — operator password
  /// [tax1..tax4]      — tax codes (0..15)
  /// [text]            — text printed in the check
  Future<void> returnSale({
    required double quantity,
    required int price,
    required int department,
    required int operatorPassword,
    int tax1 = 0,
    int tax2 = 0,
    int tax3 = 0,
    int tax4 = 0,
    String text = '',
  }) async {
    _ensureContext();

    try {
      // 1) Set operator password
      StrihFrBindings.setPassword(_ctx, operatorPassword);
      // 2) Switch to return mode
      StrihFrBindings.setCheckType(_ctx, CheckType.returnSale);
      // 3) Open return check
      final openCode = StrihFrBindings.openCheck(_ctx);
      if (openCode != 0) throw Exception(_strihErrorMessage(openCode));

      // 4) Set item parameters
      StrihFrBindings.setQuantity(_ctx, quantity);
      StrihFrBindings.setPrice(_ctx, price);
      StrihFrBindings.setDepartment(_ctx, department);
      StrihFrBindings.setTax1(_ctx, tax1);
      StrihFrBindings.setTax2(_ctx, tax2);
      StrihFrBindings.setTax3(_ctx, tax3);
      StrihFrBindings.setTax4(_ctx, tax4);
      final ptr = text.toNativeUtf8();
      StrihFrBindings.setStringForPrinting(_ctx, ptr, text.length);

      // 5) Print return item
      final returnCode = StrihFrBindings.returnSale(_ctx);
      calloc.free(ptr);
      if (returnCode != 0) throw Exception(_strihErrorMessage(returnCode));
    } catch (e) {
      throw Exception('returnSale failed: $e');
    }
  }
}
