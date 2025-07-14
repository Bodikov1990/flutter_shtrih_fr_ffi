import 'package:flutter_shtrih_fr_ffi/src/domain/entities/connection_params.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/entities/item_model.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/repositories/kkm_repository.dart';

/// Use case for sequential sale operations followed by closing the check.
class SaleAndCloseCheckUseCase {
  /// Repository used for the action.
  final KkmRepository repository;

  /// Creates the use case with the provided [repository].
  SaleAndCloseCheckUseCase(this.repository);

  /// Performs sale for each item and then `closeCheck`.
  Future<void> execute({
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
    await repository.saleAndCloseCheck(
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
