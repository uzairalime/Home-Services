class MetaDataModel {
  String? whatsapp;
  String? supportEmail;
  String? mobile;
  String? facebook;
  String? instagram;
  String? linkedin;
  String? twitter;
  String? tiktok;
  String? youtube;

  MetaDataModel(
      {this.whatsapp,
      this.supportEmail,
      this.mobile,
      this.facebook,
      this.instagram,
      this.linkedin,
      this.twitter,
      this.tiktok,
      this.youtube});

  MetaDataModel.fromJson(Map<String, dynamic> json) {
    whatsapp = json['whatsapp'];
    supportEmail = json['support_email'];
    mobile = json['mobile'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    linkedin = json['linkedin'];
    twitter = json['twitter'];
    tiktok = json['tiktok'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['whatsapp'] = whatsapp;
    data['support_email'] = supportEmail;
    data['mobile'] = mobile;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['linkedin'] = linkedin;
    data['twitter'] = twitter;
    data['tiktok'] = tiktok;
    data['youtube'] = youtube;
    return data;
  }
}
