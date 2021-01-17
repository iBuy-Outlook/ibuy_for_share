class UserProfile {

  String userName;
  String address1;
  String address2;
  String address3;
  String city;
  String state;
  String country;
  String postalCode;
  String cardNumberLastFour;
  String cardType;

  UserProfile(
    this.userName,
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.cardNumberLastFour,
    this.cardType,
  );

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'address1': address1,
    'address2': address2,
    'address3': address3,
    'city': city,
    'state': state,
    'country': country,
    'postalCode': postalCode,
    'cardNumberLastFour': cardNumberLastFour,
    'cardType': cardType,
  };
}