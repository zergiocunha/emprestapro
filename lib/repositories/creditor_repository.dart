import 'package:emprestapro/common/constants/collections.dart';
import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/data/data_result.dart';
import 'package:emprestapro/data/exceptions.dart';
import 'package:emprestapro/services/firestore_service.dart';

class CreditorRepository {
  const CreditorRepository({
    required this.firestoreService,
  });
  final FirestoreService firestoreService;

  Future<DataResult<CreditorModel>> get({
    required String fieldName,
    required String value,
  }) async {
    try {
      final result = await firestoreService.getByField(
        collection: Collections.creditors,
        fieldName: fieldName,
        value: value,
      );

      if (result.isEmpty) {
        throw const CreditorDataException(code: 'not-found');
      }
      final creditorModel = CreditorModel.fromMap(
        map: result.first,
      );

      return DataResult.success(creditorModel);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> insert({
    required CreditorModel creditorModel,
  }) async {
    try {
      await firestoreService.insert(
        collection: Collections.creditors,
        uid: creditorModel.uid!,
        params: creditorModel.toMap(),
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }
}
