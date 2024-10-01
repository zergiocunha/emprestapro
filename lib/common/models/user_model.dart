import 'package:emprestapro/common/constants/enums/user_type.dart';

class UserModel {
  final String? uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final DateTime? creationTime;
  final DateTime? updateTime;
  final DateTime? lastSignInTime;
  final UserType? userType;
  final bool? active;
  final bool? emailVerified;

  UserModel({
    this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.creationTime,
    this.updateTime,
    this.lastSignInTime,
    this.userType,
    this.active = true,
    this.emailVerified,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'creationTime': creationTime!.toIso8601String(),
      'updateTime': updateTime?.toIso8601String(),
      'lastSignInTime': lastSignInTime?.toIso8601String(),
      'userType': userType?.name,
      'active': active,
      'emailVerified': emailVerified,
    };
  }

  factory UserModel.fromMap({
    required Map<String, dynamic> map,
    String? displayName,
  }) {
    return UserModel(
      uid: map['uid'],
      displayName: displayName ?? map['displayName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      creationTime: DateTime.parse(map['creationTime']),
      updateTime: null,
      lastSignInTime: DateTime.parse(map['lastSignInTime']),
      userType: UserType.creditor,
      active: true,
      emailVerified: map['emailVerified'],
    );
  }
}
