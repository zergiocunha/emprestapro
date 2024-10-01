import 'package:emprestapro/common/constants/collections.dart';
import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/services/firestore_service.dart';

class CreditorRepository {
  const CreditorRepository({
    required this.firestoreService,
  });
  final FirestoreService firestoreService;

  Future<CreditorModel> get({required String uid}) async {
    try {
      final result = await firestoreService.get(
        collection: Collections.creditors,
        uid: uid,
      );

      if (result.isEmpty) {
        return CreditorModel();
      }
      return CreditorModel.fromMap(
        map: result,
      );
    } catch (e) {
      throw(e.toString());
    }
  }

  Future<void> insert({
    required CreditorModel creditorModel,
  }) async {
    try {
      await firestoreService.insert(
        collection: Collections.creditors,
        uid: creditorModel.uid!,
        params: creditorModel.toMap(),
      );
    } catch (e) {
      throw(e.toString());
    }
  }
}
