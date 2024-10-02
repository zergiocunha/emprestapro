class CreditorModel {
  final String? uid;
  final String? userId;
  final String? name;
  final String? pix;
  final String? phone;
  final String? imageUrl;
  final String? email;
  final DateTime? creationTime;
  final DateTime? updateTime;
  final List<String>? loanIds;
  final bool? active;

  CreditorModel({
    this.uid,
    this.userId,
    this.name,
    this.pix,
    this.phone,
    this.imageUrl,
    this.email,
    this.creationTime,
    this.updateTime,
    this.loanIds,
    this.active,
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
      'creationTime': creationTime!.toIso8601String(),
      'updateTime': updateTime?.toIso8601String(),
      'loanIds': loanIds,
      'active': active,
    };
  }

  factory CreditorModel.fromMap({
    required Map<String, dynamic> map,
  }) {
    return CreditorModel(
      uid: map['uid'],
      userId: map['userId'],
      name: map['name'],
      pix: map['pix'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
      email: map['email'],
      creationTime: DateTime.parse(map['creationTime']),
      updateTime: map['updateTime'] != null ?DateTime.parse(map['updateTime']) : null,
      loanIds: List<String>.from(map['loanIds']),
      active: map['active'],
    );
  }
}
