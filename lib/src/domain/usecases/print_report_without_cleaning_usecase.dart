import 'package:flutter_shtrih_fr_ffi/src/domain/entities/connection_params.dart';
import 'package:flutter_shtrih_fr_ffi/src/domain/repositories/kkm_repository.dart';

/// Use case for printing a shift report without cleaning.
class PrintReportWithoutCleaningUseCase {
  /// Repository used for the action.
  final KkmRepository repository;

  /// Creates a new instance with the provided [repository].
  PrintReportWithoutCleaningUseCase(this.repository);

  /// Executes the use case.
  Future<void> execute({required ConnectionParams reportParams}) async {
    await repository.printReportWithoutCleaning(reportParams: reportParams);
  }
}
