class EscrowWalletTransection {
  String id;
  String transactionId;
  String userId;
  String senderId;
  String amount;
  String status;
  String note;
  String dateTime;
  String updatedAt;

  EscrowWalletTransection(
      {this.id,
      this.transactionId,
      this.userId,
      this.senderId,
      this.amount,
      this.status,
      this.note,
      this.dateTime,
      this.updatedAt});

  EscrowWalletTransection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    userId = json['user_id'];
    senderId = json['sender_id'];
    amount = json['amount'];
    status = json['status'];
    note = json['note'];
    dateTime = json['date_time'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['user_id'] = this.userId;
    data['sender_id'] = this.senderId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['note'] = this.note;
    data['date_time'] = this.dateTime;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}