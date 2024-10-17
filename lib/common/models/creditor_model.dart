class CreditorModel {
  String? uid;
  String? userId;
  String? name;
  String? pix;
  String? phone;
  String? photoURL;
  String? email;
  String? message;
  DateTime? creationTime;
  DateTime? updateTime;
  List<String>? loanIds;
  bool? active;

  CreditorModel({
    this.uid,
    this.userId,
    this.name,
    this.pix,
    this.phone,
    this.photoURL,
    this.email,
    this.message,
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
      'photoURL': photoURL,
      'email': email,
      'message': message,
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
      photoURL: map['photoURL'],
      email: map['email'],
      message: map['message'],
      creationTime: DateTime.parse(map['creationTime']),
      updateTime: map['updateTime'] != null ?DateTime.parse(map['updateTime']) : null,
      loanIds: List<String>.from(map['loanIds']),
      active: map['active'],
    );
  }
}
