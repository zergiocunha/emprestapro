class AddressModel {
  final String id;
  final String country;
  final String state;
  final String city;
  final String street;
  final String number;
  final String zipCode;
  final DateTime creationDate;
  final DateTime updateDate;

  AddressModel({
    required this.id,
    required this.country,
    required this.state,
    required this.city,
    required this.street,
    required this.number,
    required this.zipCode,
    required this.creationDate,
    required this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'country': country,
      'state': state,
      'city': city,
      'street': street,
      'number': number,
      'zipCode': zipCode,
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      street: map['street'],
      number: map['number'],
      zipCode: map['zipCode'],
      creationDate: DateTime.parse(map['creationDate']),
      updateDate: DateTime.parse(map['updateDate']),
    );
  }
}
