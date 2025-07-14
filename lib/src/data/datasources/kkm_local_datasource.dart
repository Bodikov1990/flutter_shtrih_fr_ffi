import 'package:flutter/foundation.dart';
import 'package:flutter_shtrih_fr_ffi/src/data/datasources/background_tasks.dart';

/// Datasource that executes driver commands in a background isolate.
abstract class KkmLocalDatasource {
  /// Sends a `Sale` command to the driver.
  Future<void> sale(String jsonParams);

  /// Sends a `CloseCheck` command to the driver.
  Future<void> closeCheck(String jsonParams);

  /// Sends a `ReturnSale` command to the driver.
  Future<void> returnSale(String jsonParams);

  /// Prints a report without cleaning.
  Future<void> printReportWithoutCleaning(String jsonParams);

  /// Prints a report with cleaning.
  Future<void> printReportWithCleaning(String jsonParams);
}

/// Default implementation of [KkmLocalDatasource] using `compute` to run
/// heavy driver calls in a separate isolate.
class KkmLocalDatasourceImpl implements KkmLocalDatasource {
  @override
  /// Runs a sale command in a background isolate.
  Future<void> sale(String jsonParams) => compute(backgroundSale, jsonParams);

  @override
  /// Runs a close check command in a background isolate.
  Future<void> closeCheck(String jsonParams) =>
      compute(backgroundCloseCheck, jsonParams);

  @override
  /// Runs a return sale command in a background isolate.
  Future<void> returnSale(String jsonParams) =>
      compute(backgroundReturnSale, jsonParams);

  @override
  /// Runs print report without cleaning in a background isolate.
  Future<void> printReportWithoutCleaning(String jsonParams) =>
      compute(backgroundPrintReportWithoutCleaning, jsonParams);

  @override
  /// Runs print report with cleaning in a background isolate.
  Future<void> printReportWithCleaning(String jsonParams) =>
      compute(backgroundPrintReportWithCleaning, jsonParams);
}
