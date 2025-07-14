import 'package:flutter_shtrih_fr_ffi/src/domain/entities/item_model.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/entities/connection_params.dart';

/// Contract for repository implementations that communicate with the KKM.
abstract class KkmRepository {
  /// Executes sale commands for each item and then closes the check.
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
  });

  /// Executes a return sale and closes the check.
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
  });

  /// Prints a shift report without cleaning.
  Future<void> printReportWithoutCleaning({
    required ConnectionParams reportParams,
  });

  /// Prints a shift report with cleaning.
  Future<void> printReportWithCleaning({
    required ConnectionParams reportParams,
  });
}
