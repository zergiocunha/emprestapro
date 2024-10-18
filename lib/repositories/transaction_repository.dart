import 'package:emprestapro/common/constants/collections.dart';
import 'package:emprestapro/common/models/transaction_model.dart';
import 'package:emprestapro/data/data_result.dart';
import 'package:emprestapro/data/exceptions.dart';
import 'package:emprestapro/services/firestore_service.dart';

class TransactionRepository {
  const TransactionRepository({
    required this.firestoreService,
  });
  final FirestoreService firestoreService;

  Future<DataResult<List<TransactionModel>>> get({
    required String fieldName,
    required String value,
  }) async {
    try {
      final result = await firestoreService.getByField(
        collection: Collections.transactions,
        fieldName: fieldName,
        value: value,
      );

      if (result.isEmpty) {
        throw const TransactionDataException(code: 'not-found');
      }

      final loanModels =
          result.map((doc) => TransactionModel.fromMap(map: doc)).toList();

      return DataResult.success(loanModels);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> insert({
    required TransactionModel transactionModel,
  }) async {
    try {
      await firestoreService.insert(
        collection: Collections.transactions,
        uid: transactionModel.uid!,
        params: transactionModel.toMap(),
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> update({
    required TransactionModel transactionModel,
  }) async {
    try {
      await firestoreService.update(
        collection: Collections.transactions,
        uid: transactionModel.uid!,
        params: transactionModel.toMap(),
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
        collection: Collections.transactions,
        value: value,
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }
}
