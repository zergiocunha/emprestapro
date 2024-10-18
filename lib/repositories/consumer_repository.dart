import 'package:emprestapro/common/constants/collections.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/data/data_result.dart';
import 'package:emprestapro/data/exceptions.dart';
import 'package:emprestapro/services/firestore_service.dart';

class ConsumerRepository {
  const ConsumerRepository({
    required this.firestoreService,
  });
  final FirestoreService firestoreService;

  Future<DataResult<List<ConsumerModel>>> get({
    required String fieldName,
    required String value,
  }) async {
    try {
      final result = await firestoreService.getByField(
        collection: Collections.consumers,
        fieldName: fieldName,
        value: value,
      );

      if (result.isEmpty) {
        throw const LoanDataException(code: 'not-found');
      }

      final loanModels =
          result.map((doc) => ConsumerModel.fromMap(map: doc)).toList();

      return DataResult.success(loanModels);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> insert({
    required ConsumerModel consumerModel,
  }) async {
    try {
      await firestoreService.insert(
        collection: Collections.consumers,
        uid: consumerModel.uid!,
        params: consumerModel.toMap(),
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> update({
    required ConsumerModel consumerModel,
  }) async {
    try {
      await firestoreService.update(
        collection: Collections.consumers,
        uid: consumerModel.uid!,
        params: consumerModel.toMap(),
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> delete({
    required ConsumerModel consumerModel,
  }) async {
    try {
      await firestoreService.delete(
        collection: Collections.consumers,
        uid: consumerModel.uid!,
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }
}
