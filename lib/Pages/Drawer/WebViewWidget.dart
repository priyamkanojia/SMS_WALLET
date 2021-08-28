// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:m3_game_frm/Models/MyColors.dart';
// import 'package:m3_game_frm/Models/Urls.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';


// class LegalPolicyWidget extends StatefulWidget {
//   @override
//   _LegalPolicyWidgetState createState() => _LegalPolicyWidgetState();
// }

// class _LegalPolicyWidgetState extends State<LegalPolicyWidget> {
// static Future<List<AboutUs>> getAboutUs() async {
//       List<AboutUs> lstAboutUs=[];
//     try {
//       var response = await http.get(
//         Urls.base_url+"appsettings"
//            );
//       if (response.statusCode == 200) {
//         List jsonResponse = jsonDecode(response.body);
//         lstAboutUs = jsonResponse.map((e) => AboutUs.fromJson(e)).toList();
//       }
//     } catch (e) {
//       print(e);
//     }
//     return lstAboutUs;
//   }
//   @override
//   void initState() {
    
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<AboutUs>>(
//                     future: getAboutUs(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         snapshot.data.retainWhere((element) => element.keyName=="Legal Policy");
//                         if(snapshot.data.length>0)
//                         { 
//                           return Scaffold(
//       backgroundColor: Colors.grey[200],
//       // appBar: AppBar(
//       //   centerTitle: true,
//       //   title: Text(
//       //     'Terms & Conditions',
//       //     style: Theme.of(context).textTheme.headline6,
//       //   ),
//       //   backgroundColor: Colors.white,
//       //   iconTheme: Theme.of(context).iconTheme,
//       //   elevation: 0,
        
//       // ),
//       body: WebView(
//       initialUrl: snapshot.data[0].value,
//     ));}
//     return Scaffold( body:Center (child:Text("server error")));
//     }
//     return Scaffold( body:Center(
//       child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(MyColors.darkred)),
//     ));
//     });
//   }
// }
