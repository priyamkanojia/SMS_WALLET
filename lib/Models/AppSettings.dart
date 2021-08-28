class AppSettings {
  String sId;
  String keyName;
  String value;

  AppSettings({this.sId, this.keyName, this.value});

  AppSettings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    keyName = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['key'] = this.keyName;
    data['value'] = this.value;
    return data;
  }
}
