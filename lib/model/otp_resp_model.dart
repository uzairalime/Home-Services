class OtpResponseModel {
  String? username;
  String? firstName;
  String? lastName;
  String? mobile;
  String? access;
  String? refresh;

  OtpResponseModel(
      {this.username, this.firstName, this.lastName, this.mobile, this.access, this.refresh});

  OtpResponseModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    access = json['access'];
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['access'] = access;
    data['refresh'] = refresh;
    return data;
  }
}
