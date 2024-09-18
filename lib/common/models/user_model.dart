import 'package:emprestapro/common/constants/enums/user_type.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String imageUrl;
  final DateTime creationDate;
  final DateTime updateDate;
  final UserType userType; // Define se o usuário é um credor ou consumidor
  final bool active;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.imageUrl,
    required this.creationDate,
    required this.updateDate,
    required this.userType,
    required this.active,
  });

  // Método de conversão para Map, útil para o Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'imageUrl': imageUrl,
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
      'userType': userType.name, // Salvando o valor como string no Firebase
      'active': active,
    };
  }

  // Método de criação de um UserModel a partir de um Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
      creationDate: DateTime.parse(map['creationDate']),
      updateDate: DateTime.parse(map['updateDate']),
      userType: UserType.values.byName(map['userType']), // Convertendo string para enum
      active: map['active'],
    );
  }
}
