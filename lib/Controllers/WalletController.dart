import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sms_wallet/Models/EscrowWalletTransections.dart';
import 'package:sms_wallet/Models/MyWallet.dart';
import 'package:sms_wallet/Models/Pages.dart';
import 'package:sms_wallet/Models/ShoppingWalletTransection.dart';
import 'package:sms_wallet/Models/Sliders.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Pages/Home/MoneyTransferContactsWidget.dart';

abstract class WalletController {
   static Future<http.Response> moneyTransferContact(
      userid, mobile, amount) async {
    http.Response res;

    try {
      Map data = {
        "user_id": userid,
        "mobile": mobile,
        "amount": amount,
      };
      res = await http.post(Uri.parse(Urls.base_url + "mony_transfer"),
          headers: {"api-token": UserDetails.apiToken}, body: data);
      // if (res.statusCode == 200) {
      //   UserDetails.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
      // }
    } catch (e) {
      print(e);
    }
    return res;
  }
  
  static Future<List<MyWallet>> getWallets() async {
     List<MyWallet> myWallet=[];
    try {
      var response =await http.get(Uri.parse(Urls.base_url + "mywallet/"+UserDetails.id), headers: {"api-token":UserDetails.apiToken});
      if (response.statusCode == 200) {
        myWallet.add( MyWallet.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }
    } catch (e) {
      print(e);
    }
    return myWallet;
  }
  static Future<List<ShoppingWalletTransection>> getSoppingWalletTransectionHistory() async {
    List<ShoppingWalletTransection> lstShoppingWalletTransection = [];
    try {
      var response = await http.get(
          Uri.parse(Urls.base_url + "shoping_wallet_transaction/" + UserDetails.id),
          headers: {"api-token": UserDetails.apiToken});
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        jsonResponse = jsonResponse.reversed.toList();
        lstShoppingWalletTransection =
            jsonResponse.map((e) => ShoppingWalletTransection.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return lstShoppingWalletTransection;
  }
  static Future<List<EscrowWalletTransection>> getEscrowWalletTransectionHistory() async {
    List<EscrowWalletTransection> lstEscrowWalletTransection = [];
    try {
      var response = await http.get(
          Uri.parse(Urls.base_url + "escrow_wallet_transaction/" + UserDetails.id),
          headers: {"api-token": UserDetails.apiToken});
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        jsonResponse = jsonResponse.reversed.toList();
        lstEscrowWalletTransection =
            jsonResponse.map((e) => EscrowWalletTransection.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return lstEscrowWalletTransection;
  }
  static Future<List<MyContacts>> getPerticularPhoneStatus(String mobile, int length) async {
    List<MyContacts> lstMyContacts = [];
    if(length==1){
    try {
      var response = await http.post(
          Uri.parse(Urls.base_url + "mobile_number_search"),
          headers: {"api-token": UserDetails.apiToken}, body:{"mobile":mobile});
      if (response.statusCode == 200) {
        print(response.body);
        List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        // jsonResponse = jsonResponse.reversed.toList();
        if(jsonResponse!=null && jsonResponse.length>0){
lstMyContacts =
            jsonResponse.map((e) => MyContacts.fromJson(e)).toList();

            lstMyContacts.retainWhere((element) => element.phone.contains("+"));
        }
        
      }
    } catch (e) {
      print(e);
    }
    }
    return lstMyContacts;
  }



static Future<List<MyContacts>> getContactsFromSrv(String mobile) async {
    List<MyContacts> lstMyContacts = [];
    try {
      var response = await http.post(
          Uri.parse(Urls.base_url + "mobile_number_search"),
          headers: {"api-token": UserDetails.apiToken}, body:{"mobile":mobile});
      if (response.statusCode == 200) {
        print(response.body);
        List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        // jsonResponse = jsonResponse.reversed.toList();
        if(jsonResponse!=null && jsonResponse.length>0){
lstMyContacts =
            jsonResponse.map((e) => MyContacts.fromJson(e)).toList();
        }
        
      }
    } catch (e) {
      print(e);
    }
    return lstMyContacts;
  }


}
