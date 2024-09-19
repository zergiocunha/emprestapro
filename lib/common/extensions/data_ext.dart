import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserExtensions on User {
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'emailVerified': emailVerified,
      'creationTime': metadata.creationTime?.toIso8601String(),
      'lastSignInTime': metadata.lastSignInTime?.toIso8601String(),
    };
  }
}
