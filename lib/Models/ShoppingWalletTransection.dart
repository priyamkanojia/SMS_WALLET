class ShoppingWalletTransection {
  String id;
  String transactionId;
  String userId;
  String senderId;
  String type;
  String amount;
  String balance;
  String note;
  String dateTime;

  ShoppingWalletTransection(
      {this.id,
      this.transactionId,
      this.userId,
      this.senderId,
      this.type,
      this.amount,
      this.balance,
      this.note,
      this.dateTime});

  ShoppingWalletTransection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    userId = json['user_id'];
    senderId = json['sender_id'];
    type = json['type'];
    amount = json['amount'];
    balance = json['balance'];
    note = json['note'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['user_id'] = this.userId;
    data['sender_id'] = this.senderId;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['balance'] = this.balance;
    data['note'] = this.note;
    data['date_time'] = this.dateTime;
    return data;
  }
}