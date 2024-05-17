class PhoneAuthPostModel {
  String? source;
  String? credential;
  UserInfo? userInfo;

  PhoneAuthPostModel({this.source, this.credential, this.userInfo});

  PhoneAuthPostModel.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    credential = json['credential'];
    userInfo = json['user_info'] != null
        ? UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source'] = source;
    data['credential'] = credential;
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? firstName;
  String? lastName;

  UserInfo({this.firstName, this.lastName});

  UserInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
