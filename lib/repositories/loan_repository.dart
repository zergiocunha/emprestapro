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
