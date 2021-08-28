class BannerSliders {
  String id;
  String image;
  String status;

  BannerSliders({this.id, this.image, this.status});  

  BannerSliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}