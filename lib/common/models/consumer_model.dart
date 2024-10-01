import 'package:emprestapro/common/models/address_model.dart';

class ConsumerModel {
  final String uid;
  final String? userId;
  final String name;
  final String pix;
  final String phone;
  final String imageUrl;
  final String email;
  final DateTime creationTime;
  final DateTime updateTime;
  final List<String> loanIds; // Lista de IDs dos empréstimos
  final bool active;
  final AddressModel address;

  ConsumerModel({
    required this.uid,
    this.userId,
    required this.name,
    required this.pix,
    required this.phone,
    required this.imageUrl,
    required this.email,
    required this.creationTime,
    required this.updateTime,
    required this.loanIds,
    required this.active,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userId': userId,
      'name': name,
      'pix': pix,
      'phone': phone,
      'imageUrl': imageUrl,
      'email': email,
      'creationTime': creationTime.toIso8601String(),
      'updateTime': updateTime.toIso8601String(),
      'loanIds': loanIds,
      'active': active,
      'address': address.toMap(),
    };
  }

  factory ConsumerModel.fromMap(Map<String, dynamic> map) {
    return ConsumerModel(
      uid: map['uid'],
      name: map['name'],
      userId: map['userId'],
      pix: map['pix'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
      email: map['email'],
      creationTime: DateTime.parse(map['creationTime']),
      updateTime: DateTime.parse(map['updateTime']),
      loanIds: List<String>.from(map['loanIds']),
      active: map['active'],
      address: AddressModel.fromMap(map['address']),
    );
  }
}
