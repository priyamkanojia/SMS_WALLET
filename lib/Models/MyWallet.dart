class MyWallet {
  String walletShoping;
  String walletReward;
  String walletStaking;
  String walletEscrow;
  String walletGaming;

  MyWallet(
      {this.walletShoping,
      this.walletReward,
      this.walletStaking,
      this.walletEscrow,
      this.walletGaming});

  MyWallet.fromJson(Map<String, dynamic> json) {
    walletShoping = json['wallet_shoping']!=null?json['wallet_shoping']:"0";
    walletReward = json['wallet_reward']!=null?json['wallet_reward']:"0";
    walletStaking = json['wallet_staking']!=null?json['wallet_staking']:"0";
    walletEscrow = json['wallet_escrow']!=null?json['wallet_escrow']:"0";
    walletGaming = json['wallet_gaming']!=null?json['wallet_gaming']:"0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_shoping'] = this.walletShoping;
    data['wallet_reward'] = this.walletReward;
    data['wallet_staking'] = this.walletStaking;
    data['wallet_escrow'] = this.walletEscrow;
    data['wallet_gaming'] = this.walletGaming;
    return data;
  }
}