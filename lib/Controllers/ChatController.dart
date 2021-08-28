import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sms_wallet/Models/Chat.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';

abstract class ChatController {
  static Future<Chat> chatPost(String userId, String message) async {
    // String res = "err";
    Chat chat;
    try {
      Map data = {
        "user_id": userId,
        "msg": message,
      };
      var response = await http.post(
          Uri.parse(Urls.base_url + "send_msg_group"),
          headers: {"api-token": UserDetails.apiToken},
          body: data);
      if (response.statusCode == 200) {
        chat = Chat.fromJson(jsonDecode(utf8.decode(response.bodyBytes))[0]);
      }
    } catch (e) {
      print(e);
    }
    return chat;
  }
}
