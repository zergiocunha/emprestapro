class AddressModel {
  final String? uid;
  final String? country;
  final String? state;
  final String? city;
  final String? street;
  final String? number;
  final String? zipCode;
  final DateTime? creationTime;
  final DateTime? updateTime;

  AddressModel({
    this.uid,
    this.country,
    this.state,
    this.city,
    this.street,
    this.number,
    this.zipCode,
    this.creationTime,
    this.updateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'country': country,
      'state': state,
      'city': city,
      'street': street,
      'number': number,
      'zipCode': zipCode,
      'creationTime': creationTime?.toIso8601String(),
      'updateTime': updateTime?.toIso8601String(),
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      uid: map['uid'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      street: map['street'],
      number: map['number'],
      zipCode: map['zipCode'],
      creationTime: DateTime.parse(map['creationTime']),
      updateTime: DateTime.parse(map['updateTime']),
    );
  }
}
