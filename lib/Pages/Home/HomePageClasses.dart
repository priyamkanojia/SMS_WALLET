class SmsHubClass {
  String id;
  String type;
  String icon;
  String name;
  String link;
  String status;

  SmsHubClass(
      {this.id,
        this.type,
        this.icon,
        this.name,this.link,this.status});

  SmsHubClass.fromJson(Map <String, dynamic> json) {
    id = json['id'];
    type=json['type'];
    icon = json['icon'];
    name = json['name'];
    link=json['link'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type']=this.type;
    data['icon'] = this.icon;
    data['name']=this.name;
    data['link']=this.link;
    data['status'] = this.status;
    return data;
  }
}
class ServicesClass {
  String id;
  String type;
  String icon;
  String name;
  String link;
  String status;

  ServicesClass(
      {this.id,
        this.type,
        this.icon,
        this.name,this.link,this.status});

  ServicesClass.fromJson(Map <String, dynamic> json) {
    id = json['id'];
    type=json['type'];
    icon = json['icon'];
    name = json['name'];
    link=json['link'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type']=this.type;
    data['icon'] = this.icon;
    data['name']=this.name;
    data['link']=this.link;
    data['status'] = this.status;
    return data;
  }
}

class CategoryClass {
  String id;
  String type;
  String icon;
  String name;
  String link;
  String status;

  CategoryClass(
      {this.id,
        this.type,
        this.icon,
        this.name,this.link,this.status});

  CategoryClass.fromJson(Map <String, dynamic> json) {
    id = json['id'];
    type=json['type'];
    icon = json['icon'];
    name = json['name'];
    link=json['link'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> categorydata = new Map<String, dynamic>();
    categorydata['id'] = this.id;
    categorydata['type']=this.type;
    categorydata['icon'] = this.icon;
    categorydata['name']=this.name;
    categorydata['link']=this.link;
    categorydata['status'] = this.status;
    return categorydata;
  }
}