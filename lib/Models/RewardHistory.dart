class RewardHistory {
  String id;
  String userId;
  String refererId;
  String type;
  String point;
  String totalPoint;
  String note;
  String dateTime;

  RewardHistory(
      {this.id,
      this.userId,
      this.refererId,
      this.type,
      this.point,
      this.totalPoint,
      this.note,
      this.dateTime});

  RewardHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    refererId = json['referer_id'];
    type = json['type'];
    point = json['point'];
    totalPoint = json['total_point'];
    note = json['note'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['referer_id'] = this.refererId;
    data['type'] = this.type;
    data['point'] = this.point;
    data['total_point'] = this.totalPoint;
    data['note'] = this.note;
    data['date_time'] = this.dateTime;
    return data;
  }
}