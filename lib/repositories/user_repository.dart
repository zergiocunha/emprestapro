import 'package:emprestapro/common/constants/collections.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/data/data_result.dart';
import 'package:emprestapro/data/exceptions.dart';
import 'package:emprestapro/services/firestore_service.dart';

class UserRepository {
  const UserRepository({
    required this.firestoreService,
  });
  final FirestoreService firestoreService;

  Future<DataResult<UserModel>> get({required String uid}) async {
    try {
      final result = await firestoreService.get(
        collection: Collections.users,
        uid: uid,
      );

      if (result.isEmpty) {
        throw const UserDataException(code: 'not-found');
      }

      final userModel = UserModel.fromMap(
        map: result,
        displayName: result['displayName'],
      );

      return DataResult.success(userModel);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }

  Future<DataResult<bool>> insert({
    required String uid,
    required UserModel userModel,
  }) async {
    try {
      await firestoreService.insert(
        collection: Collections.users,
        uid: uid,
        params: userModel.toMap(),
      );

      return DataResult.success(true);
    } on Failure catch (e) {
      return DataResult.failure(e);
    }
  }
}
