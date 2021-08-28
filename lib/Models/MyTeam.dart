class MyTeam {
  String id;
  String profileImage;
  String fullname;
  String username;
  String email;
  String mobile;
  int team;

  MyTeam(
      {this.id,
      this.profileImage,
      this.fullname,
      this.username,
      this.email,
      this.mobile,
      this.team});

  MyTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profile_image'];
    fullname = json['fullname'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    team = json['team'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_image'] = this.profileImage;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['team'] = this.team;
    return data;
  }
}