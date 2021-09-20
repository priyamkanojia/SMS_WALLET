import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Models/BannerSlider.dart';
import 'package:sms_wallet/Models/News.dart';
import 'package:sms_wallet/Models/Pages.dart';
import 'package:sms_wallet/Models/Sliders.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Models/faq_class.dart';
import 'package:sms_wallet/Pages/Home/HomePageClasses.dart';

abstract class HomeController {
static Future<List<Pages>> getPages() async {
      List<Pages> lstPages=[];
    try {
      var response =await http.get(Uri.parse(Urls.base_url + "pages"),headers: {"Auth-key":Urls.auth_key});
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        jsonResponse = jsonResponse.reversed.toList();
        lstPages = jsonResponse.map((e) => Pages.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return lstPages;
  }
static Future<List<News>> getNews() async {
      List<News> lstNews=[];
    try {
      var response =await http.get(Uri.parse(Urls.base_url + "news"),headers: {"api-token":UserDetails.apiToken});
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        jsonResponse = jsonResponse.reversed.toList();
        lstNews = jsonResponse.map((e) => News.fromJson(e)).toList();
        
      }
    } catch (e) {
      print(e);
    }
    return lstNews;
  }

static Future<List<FaqClass>> getFaq() async {
  List<FaqClass> lstFaq=[];
  try {
    var response =await http.get(Uri.parse(Urls.base_url + "faq"));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      jsonResponse = jsonResponse.reversed.toList();
      lstFaq = jsonResponse.map((e) => FaqClass.fromJson(e)).toList();
    }
  } catch (e) {
    print(e);
  }
  return lstFaq;
}
///SMS HUB APT
static Future<List<SmsHubClass>> getSMSHub() async {
  List<SmsHubClass> lstSmsHub=[];
  try {
    var response =await http.get(Uri.parse(Urls.base_url + "sms_hub"),headers: {"api-token":UserDetails.apiToken});
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      jsonResponse = jsonResponse.reversed.toList();
      lstSmsHub = jsonResponse.map((e) => SmsHubClass.fromJson(e)).toList();
    }
  } catch (e) {
    print(e);
  }
  return lstSmsHub;
}

///SERVICES API

static Future<List<ServicesClass>> getServices() async {
  List<ServicesClass> lstServicesClass =[];
  try {
    var response =await http.get(Uri.parse(Urls.base_url + "services"),headers: {"api-token":UserDetails.apiToken});
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      jsonResponse = jsonResponse.reversed.toList();
      lstServicesClass = jsonResponse.map((e) => ServicesClass.fromJson(e)).toList();
    }
  } catch (e) {
    print(e);
  }
  return lstServicesClass ;
}
/// CATEGORY API

static Future<List<CategoryClass>> getCategory() async {
  List<CategoryClass> lstCategoryClass =[];
  try {
    var response =await http.get(Uri.parse(Urls.base_url + "category"),headers: {"api-token":UserDetails.apiToken});
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      jsonResponse = jsonResponse.reversed.toList();
      lstCategoryClass = jsonResponse.map((e) => CategoryClass.fromJson(e)).toList();
    }
  } catch (e) {
    print(e);
  }
  return lstCategoryClass ;
}

static Future<List<Sliders>> getSliders() async {
      List<Sliders> lstSliders=[];
    try {
      var response =await http.get(Uri.parse(Urls.base_url + "app_slider"));
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        lstSliders = jsonResponse.map((e) => Sliders.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return lstSliders;
  }


static Future<List<BannerSliders>> getBanner() async {
  List<BannerSliders> lstBanner=[];
  try {
    var response =await http.get(Uri.parse(Urls.base_url + "app_banner"));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      lstBanner = jsonResponse.map((e) => BannerSliders.fromJson(e)).toList();
    }
  } catch (e) {
    print(e);
  }
  return lstBanner;
}
  
}
