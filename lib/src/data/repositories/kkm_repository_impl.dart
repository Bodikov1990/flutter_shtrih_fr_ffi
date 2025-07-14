import 'package:flutter_shtrih_fr_ffi/src/data/datasources/kkm_local_datasource.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/entities/close_check_params.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/entities/connection_params.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/entities/item_model.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/repositories/kkm_repository.dart';

import '../../domain/entities/sale_params.dart';

/// Default implementation of [KkmRepository] that delegates work to a
/// [KkmLocalDatasource].
class KkmRepositoryImpl implements KkmRepository {
  /// Datasource used to execute commands.
  final KkmLocalDatasource remote;

  /// Creates the repository with the given [remote] datasource.
  KkmRepositoryImpl(this.remote);
  @override
  /// Sends the `printReportWithCleaning` command via the datasource.
  Future<void> printReportWithCleaning({
    required ConnectionParams reportParams,
  }) async {
    try {
      await remote.printReportWithCleaning(reportParams.toJson());
      // await compute(backgroundPrintReportWithCleaning, reportParams.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  /// Sends the `printReportWithoutCleaning` command via the datasource.
  Future<void> printReportWithoutCleaning({
    required ConnectionParams reportParams,
  }) async {
    try {
      await remote.printReportWithoutCleaning(reportParams.toJson());
      // await compute(
      //   backgroundPrintReportWithoutCleaning,
      //   reportParams.toJson(),
      // );
    } catch (e) {
      rethrow;
    }
  }

  @override
  /// Executes a return sale followed by closing the check.
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
  }) async {
    try {
      for (ItemModel discount in discounts) {
        final saleParams = SaleParams(
          comNumber: reportParams.comNumber,
          baudRate: reportParams.baudRate,
          timeout: reportParams.timeout,
          operatorPassword: reportParams.operatorPassword,
          quantity: discount.quantity.toDouble(),
          price: discount.price * 100, // example 100$ => 100.00$
          department: department,
          tax1: tax1,
          tax2: tax2,
          tax3: tax3,
          tax4: tax4,
          text: discount.name,
        );
        await remote.returnSale(saleParams.toJson());
        // await compute(backgroundReturnSale, saleParams.toJson());
      }
      final closeCheckParams = CloseCheckParams(
        comNumber: reportParams.comNumber,
        baudRate: reportParams.baudRate,
        timeout: reportParams.timeout,
        operatorPassword: reportParams.operatorPassword,
        summ1: totalSumm1 * 100, // example 100$ => 100.00$
        summ2: totalSumm2 * 100, // example 100$ => 100.00$
        summ3: totalSumm3 * 100, // example 100$ => 100.00$
        summ4: totalSumm4 * 100, // example 100$ => 100.00$
        discountOnCheck: discountOnCheck,
        tax1: tax1,
        tax2: tax2,
        tax3: tax3,
        tax4: tax4,
        text: '',
      );
      await remote.closeCheck(closeCheckParams.toJson());
      // await compute(backgroundCloseCheck, closeCheckParams.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  /// Executes sale operations for each item and closes the check.
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
  }) async {
    try {
      for (ItemModel discount in discounts) {
        final saleParams = SaleParams(
          comNumber: reportParams.comNumber,
          baudRate: reportParams.baudRate,
          timeout: reportParams.timeout,
          operatorPassword: reportParams.operatorPassword,
          quantity: discount.quantity.toDouble(),
          price: discount.price * 100, // example 100$ => 100.00$
          department: department,
          tax1: tax1,
          tax2: tax2,
          tax3: tax3,
          tax4: tax4,
          text: discount.name,
        );
        await remote.sale(saleParams.toJson());
        // await compute(backgroundSale, saleParams.toJson());
      }
      final closeCheckParams = CloseCheckParams(
        comNumber: reportParams.comNumber,
        baudRate: reportParams.baudRate,
        timeout: reportParams.timeout,
        operatorPassword: reportParams.operatorPassword,
        summ1: totalSumm1 * 100, // example 100$ => 100.00$
        summ2: totalSumm2 * 100, // example 100$ => 100.00$
        summ3: totalSumm3 * 100, // example 100$ => 100.00$
        summ4: totalSumm4 * 100, // example 100$ => 100.00$
        discountOnCheck: discountOnCheck,
        tax1: tax1,
        tax2: tax2,
        tax3: tax3,
        tax4: tax4,
        text: '',
      );
      await remote.closeCheck(closeCheckParams.toJson());
      // await compute(backgroundCloseCheck, closeCheckParams.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
