import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.address,
    required this.username,
    required this.type,
    required this.createdAt,
  });
  late final String address;
  late final String username;
  late final String type;
  late final String createdAt;

  Data.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    username = json['username'];
    type = json['type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address'] = address;
    _data['username'] = username;
    _data['type'] = type;
    _data['createdAt'] = createdAt;
    return _data;
  }
}
