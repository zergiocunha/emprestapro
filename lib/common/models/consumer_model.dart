import 'package:emprestapro/common/models/address_model.dart';

class ConsumerModel {
  final String? uid;
  final String? creditorId;
  final String? name;
  final String? pix;
  final String? phone;
  final String? imageUrl;
  final String? email;
  final DateTime? creationTime;
  final DateTime? updateTime;
  final bool? active;
  final AddressModel? address;

  ConsumerModel({
    this.uid,
    this.creditorId,
    this.name,
    this.pix,
    this.phone,
    this.imageUrl,
    this.email,
    this.creationTime,
    this.updateTime,
    this.active,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'creditorId': creditorId,
      'name': name,
      'pix': pix,
      'phone': phone,
      'imageUrl': imageUrl,
      'email': email,
      'creationTime': creationTime?.toIso8601String(),
      'updateTime': updateTime?.toIso8601String(),
      'active': active,
      'address': address?.toMap(),
    };
  }

  factory ConsumerModel.fromMap({required Map<String, dynamic> map}) {
    return ConsumerModel(
      uid: map['uid'],
      name: map['name'],
      creditorId: map['creditorId'],
      pix: map['pix'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
      email: map['email'],
      creationTime: map['creationTime'] != null ? DateTime.parse(map['creationTime']) : null,
      updateTime: map['updateTime'] != null ? DateTime.parse(map['updateTime']) : null,
      active: map['active'],
      address: map['address'] != null ? AddressModel.fromMap(map['address']) : null,
    );
  }
}
