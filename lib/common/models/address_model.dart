class AddressModel {
  final String? country;
  final String? state;
  final String? city;
  final String? street;
  final String? number;
  final String? zipCode;

  AddressModel({
    this.country,
    this.state,
    this.city,
    this.street,
    this.number,
    this.zipCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'state': state,
      'city': city,
      'street': street,
      'number': number,
      'zipCode': zipCode,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      country: map['country'],
      state: map['state'],
      city: map['city'],
      street: map['street'],
      number: map['number'],
      zipCode: map['zipCode'],
    );
  }
}
