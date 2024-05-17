class AccessTokenModel {
  String? credential;
  String? source;

  AccessTokenModel({this.credential, this.source});

  AccessTokenModel.fromJson(Map<String, dynamic> json) {
    credential = json['credential'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['credential'] = credential;
    data['source'] = source;
    return data;
  }
}
