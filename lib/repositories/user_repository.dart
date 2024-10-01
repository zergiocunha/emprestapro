import 'package:emprestapro/common/constants/collections.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/services/firestore_service.dart';

class UserRepository {
  const UserRepository({
    required this.firestoreService,
  });
  final FirestoreService firestoreService;

  Future<UserModel> get({required String uid}) async {
    try {
      final result = await firestoreService.get(
        collection: Collections.users,
        uid: uid,
      );

      if (result.isEmpty) {
        return UserModel();
      }
      return UserModel.fromMap(
        map: result,
        displayName: result['displayName'],
      );
    } catch (e) {
      throw(e.toString());
    }
  }

  Future<void> insert({
    required String uid,
    required UserModel userModel,
  }) async {
    try {
      await firestoreService.insert(
        collection: Collections.users,
        uid: uid,
        params: userModel.toMap(),
      );
    } catch (e) {
      throw(e.toString());
    }
  }
}
