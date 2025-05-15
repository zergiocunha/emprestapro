import 'package:emprestapro/common/constants/collections.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/data/data_result.dart';
import 'package:emprestapro/data/exceptions.dart';
import 'package:emprestapro/services/firestore_service.dart';

class LoanRepository {
  const LoanRepository({
    required this.firestoreService,
  });
  final FirestoreService firestoreService;

  Future<DataResult<List<LoanModel>>> get({
    required String fieldName,
    required String value,
  }) async {
    try {
      final result = await firestoreService.getByField(
        collection: Collections.loans,
        fieldName: fieldName,
        value: value,
      );

      if (result.isEmpty) {
        throw const LoanDataException(code: 'not-found');
      }

      final loanModels =
          result.map((doc) => LoanModel.fromMap(map: doc)).toList();

      return DataResult.success(loanModels);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<List<LoanModel>>> getOverduLoans({
    required String creditorId,
  }) async {
    try {
      final result = await firestoreService.getByFilter(
        collection: Collections.loans,
        filters: {
          'creditorId ': FilterCondition(creditorId, FilterOperator.isEqualTo),
          'dueDate': FilterCondition(
              DateTime.now(), FilterOperator.isLessThanOrEqualTo),
          'concluded': const FilterCondition(false, FilterOperator.isEqualTo),
        },
      );

      if (result.isEmpty) {
        throw const LoanDataException(code: 'not-found');
      }

      final loanModels =
          result.map((doc) => LoanModel.fromMap(map: doc)).toList();
      return DataResult.success(loanModels);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> insert({
    required LoanModel loanModel,
  }) async {
    try {
      await firestoreService.insert(
        collection: Collections.loans,
        uid: loanModel.uid!,
        params: loanModel.toMap(),
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> deleteByField({
    required String value,
    required String fieldName,
  }) async {
    try {
      await firestoreService.deleteByField(
        fieldName: fieldName,
        collection: Collections.loans,
        value: value,
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> delete({
    required LoanModel loanModel,
  }) async {
    try {
      await firestoreService.delete(
        collection: Collections.loans,
        uid: loanModel.uid!,
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> update({
    required LoanModel loanModel,
  }) async {
    try {
      await firestoreService.update(
        collection: Collections.loans,
        uid: loanModel.uid!,
        params: loanModel.toMap(),
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }
}
