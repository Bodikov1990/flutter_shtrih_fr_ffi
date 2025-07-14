import 'package:flutter_shtrih_fr_ffi/flutter_shtrih_fr.dart';
import 'package:flutter_shtrih_fr_ffi/src/data/datasources/kkm_local_datasource.dart';
import 'package:flutter_shtrih_fr_ffi/src/data/repositories/kkm_repository_impl.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/repositories/kkm_repository.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/usecases/print_report_with_cleaning_usecase.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/usecases/print_report_without_cleaning_usecase.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/usecases/return_sale_usecase.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/usecases/sale_and_close_check_usecase.dart';

/// High level API for working with the Strih-FR driver.
///
/// This class exposes simple methods that internally use the repository
/// and usecases to communicate with the fiscal register.
class FlutterStrihFrFFI {
  /// Repository used for all operations.
  final KkmRepository _repo;

  /// Creates a new plugin instance.
  ///
  /// If [repo] is not provided a [KkmRepositoryImpl] backed by a
  /// [KkmLocalDatasourceImpl] will be created.
  FlutterStrihFrFFI([KkmRepository? repo])
    : _repo = repo ?? KkmRepositoryImpl(KkmLocalDatasourceImpl());

  /// Prints a shift report without cleaning.
  Future<void> printReportWithoutCleaning({
    required ConnectionParams reportParams,
  }) {
    return PrintReportWithoutCleaningUseCase(
      _repo,
    ).execute(reportParams: reportParams);
  }

  /// Prints a shift report with cleaning.
  Future<void> printReportWithCleaning({
    required ConnectionParams reportParams,
  }) {
    return PrintReportWithCleaningUseCase(
      _repo,
    ).execute(reportParams: reportParams);
  }

  /// Performs sale operations for each item and then closes the check.
  Future<void> saleAndCloseCheck({
    required ConnectionParams reportParams,
    required List<ItemModel> discounts,
    required int totalSumm1,
    required int totalSumm2,
    required int totalSumm3,
    required int totalSumm4,
    required int department,
    required int tax1,
    required int tax2,
    required int tax3,
    required int tax4,
    required double discountOnCheck,
  }) {
    return SaleAndCloseCheckUseCase(_repo).execute(
      reportParams: reportParams,
      discounts: discounts,
      totalSumm1: totalSumm1,
      totalSumm2: totalSumm2,
      totalSumm3: totalSumm3,
      totalSumm4: totalSumm4,
      department: department,
      tax1: tax1,
      tax2: tax2,
      tax3: tax3,
      tax4: tax4,
      discountOnCheck: discountOnCheck,
    );
  }

  /// Performs a return sale operation followed by closing the check.
  Future<void> returnSale({
    required ConnectionParams reportParams,
    required List<ItemModel> discounts,
    required int totalSumm1,
    required int totalSumm2,
    required int totalSumm3,
    required int totalSumm4,
    required int department,
    required int tax1,
    required int tax2,
    required int tax3,
    required int tax4,
    required double discountOnCheck,
  }) {
    return ReturnSaleUseCase(_repo).execute(
      reportParams: reportParams,
      discounts: discounts,
      totalSumm1: totalSumm1,
      totalSumm2: totalSumm2,
      totalSumm3: totalSumm3,
      totalSumm4: totalSumm4,
      department: department,
      tax1: tax1,
      tax2: tax2,
      tax3: tax3,
      tax4: tax4,
      discountOnCheck: discountOnCheck,
    );
  }
}
