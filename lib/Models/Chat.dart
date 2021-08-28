class Chat {
  String chatId;
  String userId;
  String profileImage;
  String fullname;
  String msg;
  String created;

  Chat(
      {this.chatId,
      this.userId,
      this.profileImage,
      this.fullname,
      this.msg,
      this.created});

  Chat.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    userId = json['user_id'];
    profileImage = json['profile_image'];
    fullname = json['fullname'];
    msg = json['msg'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['user_id'] = this.userId;
    data['profile_image'] = this.profileImage;
    data['fullname'] = this.fullname;
    data['msg'] = this.msg;
    data['created'] = this.created;
    return data;
  }
}