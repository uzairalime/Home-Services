class RefreshTokenModel {
  String? access;
  String? refresh;

  RefreshTokenModel({this.access, this.refresh});

  RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['refresh'] = refresh;
    return data;
  }
}
