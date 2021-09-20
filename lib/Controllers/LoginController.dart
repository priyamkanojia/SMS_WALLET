import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';

abstract class LoginController {
  static Future<http.Response> login(String phone, String password, String token) async {
    http.Response res;
    try {
      Map data = {"email": phone, "password": password, "remember_token":token};
      res = await http.post(Uri.parse(Urls.base_url + "login"),
          headers: {"Auth-key": Urls.auth_key}, body: data);
      if (res.statusCode == 200) {
        //String loginResponse = jsonDecode(utf8.decode(res.bodyBytes))['data'];
        //print('Login Resp: $loginResponse');
        UserDetails.fromJson(jsonDecode(utf8.decode(res.bodyBytes))['data']);
      }
    } catch (e) {}
    return res;
  }

  static Future<http.Response> mobileCheck(String phone) async {
    http.Response res;
    try {
      Map data = {"mobile": phone};
      res = await http.post(Uri.parse(Urls.base_url + "check_mobile"),
          headers: {"Auth-key": Urls.auth_key}, body: data);
    } catch (e) {}
    return res;
  }

  static Future<String> userInfo(String id, String token) async {
    String res = "err";
    try {
      var response = await http.get(Uri.parse(Urls.base_url + "userinfo/" + id),
          headers: {"api-token": token});
      if (response.statusCode == 200) {
        UserDetails.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes))['data']);
        res = "success";
      } else if (response.statusCode == 404) {
        res = "notfound";
      } else {
        res = "serr";
      }
    } catch (e) {}
    return res;
  }

  static Future<http.Response> register(
      phone, name, email, referal, password,token) async {
    http.Response res;

    try {
      Map data = {
        "fullname": name,
        "email": email,
        "mobile": phone,
        "referalcode": referal,
        "password": password,
        "remember_token":token
      };
      res = await http.post(Uri.parse(Urls.base_url + "usercreate"),
          headers: {"Auth-key": Urls.auth_key}, body: jsonEncode(data));
      if (res.statusCode == 200) {
        UserDetails.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
      }
    } catch (e) {
      print(e);
    }
    return res;
  }

  static Future<http.Response> profileUpdate(
      phone, fullname, email, username,gender,dob,state,city,country,address,interest) async {
    http.Response res;

    try {
      Map data = {
        "id": UserDetails.id,
        "username": username,
        "fullname": fullname,
        "email": email,
        'gender':gender,
        "mobile": phone,
        "dob": dob,
        'country':country,
        "state": state,
        "city": city,
        "address": address,
        'intrest':interest,
      };
      res = await http.post(Uri.parse(Urls.base_url + "user_profile"),
          headers: {"api-token": UserDetails.apiToken}, body: jsonEncode(data));
      if (res.statusCode == 200) {
        UserDetails.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
      }
    } catch (e) {
      print(e);
    }
    return res;
  }

  static Future<http.Response> resetPassPhone(password) async {
    http.Response res;

    try {
      Map data = {
        "id": UserDetails.id,
        "username": UserDetails.username,
        "fullname": UserDetails.fullname,
        "email": UserDetails.email,
        'gender':UserDetails.gender,
        "mobile": UserDetails.mobile,
        "dob": UserDetails.dob,
        'country':UserDetails.country,
        "city": UserDetails.city,
        "state": UserDetails.state,
        "address": UserDetails.address,
        'intrest':UserDetails.interest,
        "password": password,
      };
      res = await http.post(Uri.parse(Urls.base_url + "user_profile"),
          headers: {"api-token": UserDetails.apiToken}, body: jsonEncode(data));
      if (res.statusCode == 200) {
        UserDetails.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
      }
    } catch (e) {
      print(e);
    }
    return res;
  }

  static Future<String> updateImage(File image) async {
    String res = "err";
    try {
      String imageString;
      if (image != null) {
        List<int> imageBytes = image.readAsBytesSync();

        String rrrr = image.path.replaceAll(image.parent.path + "/", "");
        String rr = rrrr.substring(rrrr.indexOf(".") + 1, rrrr.length);
        imageString =
            Uri.dataFromBytes(imageBytes, mimeType: "image/" + rr).toString();
      }
      var response = await http.post(Uri.parse(Urls.base_url + "profile_image"),
          headers: {'api-token': UserDetails.apiToken},
          body: jsonEncode({"user_id": UserDetails.id, "image": imageString}));
      print(imageString);
      if (response.statusCode == 200) {
        // if (response.body.toString().toLowerCase().trim() == "success") {
        res = "success";
        // } else {
        //   res = "serr";
        // }
      } else {
        res = "serr";
      }
    } catch (e) {}
    return res;
  }

  static Future<http.Response> forgetPassword(String email) async {
    http.Response response;
    try {
      Map data = {"email": email};
      response = await http.post(Uri.parse(Urls.base_url + "forgot_password"),
          body: data);
    } catch (e) {
      print(e);
    }
    return response;
  }

  static Future<http.Response> checkOTP(String otp, String new_pass) async {
    http.Response response;
    try {
      Map data = {"otp": otp, "new_password": new_pass};
      response = await http
          .post(Uri.parse(Urls.base_url + "forgot_password_otp"), body: data);
    } catch (e) {
      print(e);
    }
    return response;
  }
  static Future<http.Response> deleteAc () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    String status,data;
    http.Response response;
    try{
      //Map data = {'status':status,'data':respData};
      response = await http.post(Uri.parse(Urls.base_url + 'del_user/$id'),headers: {'api-token': UserDetails.apiToken});
      print(' Delete response:$response.body');
      if (response.statusCode == 200){
        //print(response.body);
        status = jsonDecode(response.body)['status'].toString();//status
        data =  jsonDecode(response.body)['data'];
        print(status);
        print(data);
      }
      else print(response.statusCode);
    }catch(e){
      print(e);
    }
    return response;
  }
}
