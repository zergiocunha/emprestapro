class CreditorModel {
  final String id;
  final String? userId;
  final String name;
  final String pix;
  final String phone;
  final String imageUrl;
  final String email;
  final DateTime creationDate;
  final DateTime updateDate;
  final List<String> loanIds; // Lista de IDs dos empréstimos
  final bool active;

  CreditorModel({
    required this.id,
    this.userId,
    required this.name,
    required this.pix,
    required this.phone,
    required this.imageUrl,
    required this.email,
    required this.creationDate,
    required this.updateDate,
    required this.loanIds,
    required this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'pix': pix,
      'phone': phone,
      'imageUrl': imageUrl,
      'email': email,
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
      'loanIds': loanIds,
      'active': active,
    };
  }

  factory CreditorModel.fromMap(Map<String, dynamic> map) {
    return CreditorModel(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      pix: map['pix'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
      email: map['email'],
      creationDate: DateTime.parse(map['creationDate']),
      updateDate: DateTime.parse(map['updateDate']),
      loanIds: List<String>.from(map['loanIds']),
      active: map['active'],
    );
  }
}
