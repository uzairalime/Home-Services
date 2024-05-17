class PhoneAuthRespModel {
  String? type;
  String? code;
  String? detail;

  PhoneAuthRespModel({this.type, this.code, this.detail});

  PhoneAuthRespModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['code'] = code;
    data['detail'] = detail;
    return data;
  }
}
