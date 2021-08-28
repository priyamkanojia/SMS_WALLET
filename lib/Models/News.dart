class News {
  String id;
  String title;
  String image;
  String description;
  String createdAt;
  String status;

  News(
      {this.id,
      this.title,
      this.image,
      this.description,
      this.createdAt,
      this.status});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    return data;
  }
}