import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sms_wallet/Models/AppSettings.dart';
import 'package:sms_wallet/Models/AppVersion.dart';
import 'package:sms_wallet/Models/MyTeam.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';

abstract class TeamController {
  static Future<List<MyTeam>> getMyTeam() async {
    List<MyTeam> lstMyTeam = [];
    try {
      var response = await http.get(Uri.parse(Urls.base_url + "myteam/"+UserDetails.id),
          headers: {"api-token": UserDetails.apiToken});
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        lstMyTeam = jsonResponse.map((e) => MyTeam.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return lstMyTeam;
  }
}
