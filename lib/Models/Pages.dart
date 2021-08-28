class Pages {
  String id;
  String pageName;
  String description;

  Pages({this.id, this.pageName, this.description});

  Pages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageName = json['page_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['page_name'] = this.pageName;
    data['description'] = this.description;
    return data;
  }
}