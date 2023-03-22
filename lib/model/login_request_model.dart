class LoginRequestModel {
  LoginRequestModel({
    this.username,
    this.password,
  });
  late final String? username;
  late final String? password;

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['address'] = password;
    return _data;
  }
}
