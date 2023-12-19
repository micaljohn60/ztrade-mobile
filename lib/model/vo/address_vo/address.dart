import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String cartsToJson(Address data) => json.encode(data.toJson());

class Address {
  Data data;

  Address({this.data});

  Address.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  int userId;
  String street;
  String city;
  String state;
  int postalCode;
  String phone;
  String country;
  String createdAt;
  String updatedAt;
  User user;

  Data(
      {this.id,
      this.userId,
      this.street,
      this.city,
      this.state,
      this.postalCode,
      this.phone,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    country = json['country'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['postal_code'] = postalCode;
    data['phone'] = phone;
    data['country'] = country;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String factoryName;
  String profilePic;
  Null emailVerifiedAt;
  String verificationCode;
  int isVerified;
  Null apiToken;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.factoryName,
      this.profilePic,
      this.emailVerifiedAt,
      this.verificationCode,
      this.isVerified,
      this.apiToken,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    factoryName = json['factory_name'];
    profilePic = json['profile_pic'];
    emailVerifiedAt = json['email_verified_at'];
    verificationCode = json['verification_code'];
    isVerified = json['is_verified'];
    apiToken = json['api_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['factory_name'] = factoryName;
    data['profile_pic'] = profilePic;
    data['email_verified_at'] = emailVerifiedAt;
    data['verification_code'] = verificationCode;
    data['is_verified'] = isVerified;
    data['api_token'] = apiToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
