import 'package:emprestapro/common/constants/enums/user_type.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final DateTime? creationDate;
  final DateTime? updateDate;
  final DateTime? lastSignInTime;
  final UserType? userType;
  final bool? active;
  final bool? emailVerified;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.creationDate,
    this.updateDate,
    this.lastSignInTime,
    this.userType,
    this.active = true,
    this.emailVerified,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'creationDate': creationDate!.toIso8601String(),
      'updateDate': updateDate?.toIso8601String(),
      'lastSignInTime': lastSignInTime?.toIso8601String(),
      'userType': userType?.name,
      'active': active,
      'emailVerified': emailVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String? name) {
    return UserModel(
      id: map['uid'],
      name: name ?? map['displayName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      creationDate: DateTime.parse(map['creationTime']),
      updateDate: null,
      lastSignInTime: DateTime.parse(map['lastSignInTime']),
      userType: UserType.creditor,
      active: true,
      emailVerified: map['emailVerified'],
    );
  }
}
