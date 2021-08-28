import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'HomePageClasses.dart';
class SmsHub extends StatefulWidget {
  List<SmsHubClass> lstMessages;
  SmsHub({@required this.lstMessages});
  @override
  _SmsHubState createState() => _SmsHubState();
}

class _SmsHubState extends State<SmsHub> {
  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  void initState(){
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _widget(widget.lstMessages),
      ],
    );
  }
  Widget _widget(List<SmsHubClass> item){
    List<Widget> lstW = [];
    for(var i =0; i<item.length;i++){
      lstW.add(
        InkWell(
          onTap:(){
            // WebView(
            //   initialUrl:'${item[i].link}',
            //   javascriptMode: JavascriptMode.unrestricted,
            // );
            _launchURL(item[i].link);
            },
          child: Container(height: 75,
            width: 80,
            child: Column(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceEvenly,
                children: [
                  Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        image:DecorationImage(
                          image:
                          NetworkImage('https://wallet.jainalufoils.com/'+'${item[i].icon}'),fit:BoxFit.fill,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.2),
                              offset: Offset(0.5, 0.5),
                              blurRadius: 8,
                              spreadRadius: 0.3)
                        ],
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(10),
                      )),
                  Text("${item[i].name}",
                      style: Theme.of(
                          context)
                          .textTheme
                          .headline6
                          .apply(
                          fontSizeFactor:
                          0.50,
                          color: MyColors
                              .darkBlue,
                          fontWeightDelta:
                          18,
                          fontFamily:
                          'Poppins'))
                ]),
          ),
        ),
      );
    }
    return Wrap(children: lstW.reversed.toList(),);
  }
}
