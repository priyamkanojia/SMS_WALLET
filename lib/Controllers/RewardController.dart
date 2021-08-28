import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sms_wallet/Models/Pages.dart';
import 'package:sms_wallet/Models/RewardHistory.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';

abstract class RewardController {
  static Future<List<RewardHistory>> getRewardHistory() async {
    List<RewardHistory> lstRewardHistory = [];
    try {
      var response = await http.get(
          Uri.parse(Urls.base_url + "reward_wallet_history/" + UserDetails.id),
          headers: {"api-token": UserDetails.apiToken});
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        jsonResponse = jsonResponse.reversed.toList();
        lstRewardHistory =
            jsonResponse.map((e) => RewardHistory.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return lstRewardHistory;
  }
}
