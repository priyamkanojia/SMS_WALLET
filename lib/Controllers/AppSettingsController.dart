import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sms_wallet/Models/AppSettings.dart';
import 'package:sms_wallet/Models/AppVersion.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';

abstract class AppSettingsController {
  static Future<List<AppSettings>> getSettings() async {
    List<AppSettings> lstAboutUs = [];
    try {
      var response = await http.get(Uri.parse(Urls.base_url + "app_settings"),
          headers: {"Auth-key": Urls.auth_key});
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        lstAboutUs = jsonResponse.map((e) => AppSettings.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return lstAboutUs;
  }

  static Future<http.Response> getRefererReferedAndDaylyRewardPoints() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(Urls.base_url + "referel"),
          headers: {"Auth-key": Urls.auth_key});
     
    } catch (e) {
      print(e);
    }
    return response;
  }

  static Future<String> appUpdate() async {
    String res = "err";
    try {
      var response = await http.get(Uri.parse(Urls.base_url + "app_settings"),
          headers: {"Auth-key": Urls.auth_key});
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        jsonResponse.retainWhere((element) => element['key'] == "app_version");
        AppVersion.version = jsonResponse[0]["value"];
        if (AppVersion.version != null) {
          res = "success";
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return AppVersion.version;
  }

  static Future<String> getWalletAmount() async {
    String res = "error";
    try {
      var response = await http.get(
          Uri.parse(Urls.base_url + "getwallet?user_id=" + UserDetails.id));
      if (response.statusCode == 200) {
        res = response.body.toString().trim();
      }
    } catch (e) {
      print(e);
    }
    return res;
  }

  static Future<String> feedback(String message) async {
    String res = "err";
    try {
      Map data = {"user_id": UserDetails.id, "message": message};
      var response = await http.post(Uri.parse(Urls.base_url + "userfeedback"),
          headers: {"api-token": UserDetails.apiToken}, body: jsonEncode(data));
      if (response.statusCode == 200) {
        res = "success";
      } else {
        res = "serr";
      }
    } catch (e) {}
    return res;
  }
  ///KYC
  static Future<http.Response> kycSubmit(
      String idNumber, String idType, File file, File file2,status) async {
              http.Response res;
    try {
      String imageString, imageString2;
      if (file != null) {
        List<int> imageBytes = file.readAsBytesSync();

        String rrrr = file.path.replaceAll(file.parent.path + "/", "");
        String rr = rrrr.substring(rrrr.indexOf(".") + 1, rrrr.length);
        imageString =
            Uri.dataFromBytes(imageBytes, mimeType: "image/" + rr).toString();
      }
      if (file2 != null) {
        List<int> imageBytes2 = file2.readAsBytesSync();

        String rrrr2 = file2.path.replaceAll(file2.parent.path + "/", "");
        String rr2 = rrrr2.substring(rrrr2.indexOf(".") + 1, rrrr2.length);
        imageString2 =
            Uri.dataFromBytes(imageBytes2, mimeType: "image/" + rr2).toString();
      }

      Map data = {
        "user_id": UserDetails.id,
        "document": idType,
        "document_number":idNumber,
        "front": imageString,
        "back": imageString2,
        'status': status,
      };
      res = await http.post(Uri.parse(Urls.base_url + "kyc_update"),
          headers: {"api-token": UserDetails.apiToken}, body: jsonEncode(data));
      
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  static String phoneWithoutCode(String phone) {
    String ph = phone;
    for (var i = 0; i < lstCountryCodes.length; i++) {
      if (phone.contains(lstCountryCodes[i])) {
        ph = phone.replaceAll(lstCountryCodes[i], "");
        break;
      }
    }
    return ph;
  }

  static List<String> lstCountryCodes = [
    "+7 840",
    "+93",
    "+355",
    "+213",
    "+1 684",
    "+376",
    "+244",
    "+1 264",
    "+1 268",
    "+54",
    "+374",
    "+297",
    "+247",
    "+61",
    "+672",
    "+43",
    "+994",
    "+1 242",
    "+973",
    "+880",
    "+1 246",
    "+1 268",
    "+375",
    "+32",
    "+501",
    "+229",
    "+1 441",
    "+975",
    "+591",
    "+387",
    "+267",
    "+55",
    "+246",
    "+1 284",
    "+673",
    "+359",
    "+226",
    "+257",
    "+855",
    "+237",
    "+1",
    "+238",
    "+ 345",
    "+236",
    "+235",
    "+56",
    "+86",
    "+61",
    "+61",
    "+57",
    "+269",
    "+242",
    "+243",
    "+682",
    "+506",
    "+385",
    "+53",
    "+599",
    "+537",
    "+420",
    "+45",
    "+246",
    "+253",
    "+1 767",
    "+1 809",
    "+670",
    "+56",
    "+593",
    "+20",
    "+503",
    "+240",
    "+291",
    "+372",
    "+251",
    "+500",
    "+298",
    "+679",
    "+358",
    "+33",
    "+596",
    "+594",
    "+689",
    "+241",
    "+220",
    "+995",
    "+49",
    "+233",
    "+350",
    "+30",
    "+299",
    "+1 473",
    "+590",
    "+1 671",
    "+502",
    "+224",
    "+245",
    "+595",
    "+509",
    "+504",
    "+852",
    "+36",
    "+354",
    "+91",
    "+62",
    "+98",
    "+964",
    "+353",
    "+972",
    "+39",
    "+225",
    "+1 876",
    "+81",
    "+962",
    "+7 7",
    "+254",
    "+686",
    "+965",
    "+996",
    "+856",
    "+371",
    "+961",
    "+266",
    "+231",
    "+218",
    "+423",
    "+370",
    "+352",
    "+853",
    "+389",
    "+261",
    "+265",
    "+60",
    "+960",
    "+223",
    "+356",
    "+692",
    "+596",
    "+222",
    "+230",
    "+262",
    "+52",
    "+691",
    "+1 808",
    "+373",
    "+377",
    "+976",
    "+382",
    "+1664",
    "+212",
    "+95",
    "+264",
    "+674",
    "+977",
    "+31",
    "+599",
    "+1 869",
    "+687",
    "+64",
    "+505",
    "+227",
    "+234",
    "+683",
    "+672",
    "+850",
    "+1 670",
    "+47",
    "+968",
    "+92",
    "+680",
    "+970",
    "+507",
    "+675",
    "+595",
    "+51",
    "+63",
    "+48",
    "+351",
    "+1 787",
    "+974",
    "+262",
    "+40",
    "+7",
    "+250",
    "+685",
    "+378",
    "+966",
    "+221",
    "+381",
    "+248",
    "+232",
    "+65",
    "+421",
    "+386",
    "+677",
    "+27",
    "+500",
    "+82",
    "+34",
    "+94",
    "+249",
    "+597",
    "+268",
    "+46",
    "+41",
    "+963",
    "+886",
    "+992",
    "+255",
    "+66",
    "+670",
    "+228",
    "+690",
    "+676",
    "+1 868",
    "+216",
    "+90",
    "+993",
    "+1 649",
    "+688",
    "+1 340",
    "+256",
    "+380",
    "+971",
    "+44",
    "+1",
    "+598",
    "+998",
    "+678",
    "+58",
    "+84",
    "+1 808",
    "+681",
    "+967",
    "+260",
    "+255",
    "+263"
  ];
}
