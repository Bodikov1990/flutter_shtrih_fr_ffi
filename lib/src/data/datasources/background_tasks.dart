import 'package:flutter_shtrih_fr_ffi/flutter_shtrih_fr_ffi.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/entities/close_check_params.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/entities/return_sale_params.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/entities/sale_params.dart';
import 'package:flutter_shtrih_fr_ffi/src/driver/strih_fr_driver.dart';

/// Executes a sale operation using [StrihFrDriver] in an isolate.
Future<void> backgroundSale(String params) async {
  final driver = StrihFrDriver();
  final saleParams = SaleParams.fromJson(params);

  try {
    await driver.connect(
      comNumber: saleParams.comNumber,
      baudRate: saleParams.baudRate,
      timeout: saleParams.timeout,
    );

    await driver.sale(
      quantity: saleParams.quantity,
      price: saleParams.price,
      department: saleParams.department,
      operatorPassword: saleParams.operatorPassword,
      tax1: saleParams.tax1,
      tax2: saleParams.tax2,
      tax3: saleParams.tax3,
      tax4: saleParams.tax4,
      text: saleParams.text,
    );
  } catch (e) {
    // cancel if something failed during return
    try {
      await driver.cancelCheck(operatorPassword: saleParams.operatorPassword);
    } catch (_) {}
    rethrow;
  } finally {
    driver.deinit();
  }
}

/// Executes close check logic using [StrihFrDriver].
Future<void> backgroundCloseCheck(String params) async {
  final driver = StrihFrDriver();
  final p = CloseCheckParams.fromJson(params);

  try {
    // 1) Connecting
    await driver.connect(
      comNumber: p.comNumber,
      baudRate: p.baudRate,
      timeout: p.timeout,
    );

    // 2) Attempt to close the check
    await driver.closeCheck(
      operatorPassword: p.operatorPassword,
      summ1: p.summ1,
      summ2: p.summ2,
      summ3: p.summ3,
      summ4: p.summ4,
      discountOnCheck: p.discountOnCheck,
      tax1: p.tax1,
      tax2: p.tax2,
      tax3: p.tax3,
      tax4: p.tax4,
      text: p.text,
    );
  } catch (e) {
    rethrow;
  } finally {
    driver.deinit();
  }
}

/// Executes a return sale operation using [StrihFrDriver].
Future<void> backgroundReturnSale(String jsonParams) async {
  final p = ReturnSaleParams.fromJson(jsonParams);
  final driver = StrihFrDriver();

  try {
    await driver.connect(
      comNumber: p.comNumber,
      baudRate: p.baudRate,
      timeout: p.timeout,
    );

    // switch to return mode and print
    await driver.returnSale(
      quantity: p.quantity,
      price: p.price,
      department: p.department,
      operatorPassword: p.operatorPassword,
      tax1: p.tax1,
      tax2: p.tax2,
      tax3: p.tax3,
      tax4: p.tax4,
      text: p.text,
    );
  } catch (e) {
    // cancel if something failed during return
    try {
      await driver.cancelCheck(operatorPassword: p.operatorPassword);
    } catch (_) {}
    rethrow;
  } finally {
    driver.deinit();
  }
}

/// Prints a report without cleaning in an isolate.
Future<void> backgroundPrintReportWithoutCleaning(String jsonParams) async {
  final p = ConnectionParams.fromJson(jsonParams);
  final driver = StrihFrDriver();
  try {
    await driver.connect(
      comNumber: p.comNumber,
      baudRate: p.baudRate,
      timeout: p.timeout,
    );
    await driver.printReportWithoutCleaning(
      operatorPassword: p.operatorPassword,
    );
  } catch (e) {
    rethrow;
  } finally {
    driver.deinit();
  }
}

/// Prints a report with cleaning in an isolate.
Future<void> backgroundPrintReportWithCleaning(String jsonParams) async {
  final p = ConnectionParams.fromJson(jsonParams);
  final driver = StrihFrDriver();
  try {
    await driver.connect(
      comNumber: p.comNumber,
      baudRate: p.baudRate,
      timeout: p.timeout,
    );
    await driver.printReportWithCleaning(operatorPassword: p.operatorPassword);
  } catch (e) {
    try {
      await driver.cancelCheck(operatorPassword: p.operatorPassword);
    } catch (_) {}
    rethrow;
  } finally {
    driver.deinit();
  }
}
