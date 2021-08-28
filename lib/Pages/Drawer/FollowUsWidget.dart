import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Controllers/ShimmerController.dart';
import 'package:sms_wallet/Models/AppSettings.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../ad_state.dart';

class FollowUsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FollowUsWidgetState();
  }
}

Future<List<AppSettings>> lstNotifications;

class FollowUsWidgetState extends State<FollowUsWidget> {
  TextEditingController searchCon = new TextEditingController();

  @override
  void initState() {
    lstNotifications = AppSettingsController.getSettings();
lstNotifications.then((value) {
        valuessss.addAll(value);
        valuessss.retainWhere((element) =>
            element.keyName.toLowerCase().contains("facebook") ||
            element.keyName.toLowerCase().contains("instagram") ||
            element.keyName.toLowerCase().contains("twitter"));
      });
    super.initState();
  }
List<AppSettings> valuessss=[];
  void setSt() {
    setState(() {
      lstNotifications = AppSettingsController.getSettings();
      lstNotifications.then((value) {
        valuessss.addAll(value);
        valuessss.retainWhere((element) =>
            element.keyName.toLowerCase().contains("facebook") ||
            element.keyName.toLowerCase().contains("instagram") ||
            element.keyName.toLowerCase().contains("twitter"));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
         leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: MyColors.darkBlue,
          elevation: 0,
          title: Text(
            "Follow Us",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      bottomNavigationBar: ShowBannerAdd(),
      body: FutureBuilder<List<AppSettings>>(
          future: lstNotifications,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (valuessss.length > 0) {
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 12, bottom: 60),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < valuessss.length)
                            return Container(
                                child: _product(valuessss[index]));
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text("No Any Link Found."));
              }
            } else {
              return Center(
                child: SpinKitThreeBounce(
                  color: MyColors.darkBlue,
                  size: 32,
                ),
              );
            }
          }),
    );
  }

  InkWell _product(AppSettings item) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  WebView(
      initialUrl: item.value,
      javascriptMode: JavascriptMode.unrestricted,
    ) ));
        
        },
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((item.keyName),
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.subtitle1.apply(
                                    fontSizeFactor: 1.0,
                                    color: MyColors.darkBlue,
                                    fontWeightDelta: 30
                                  )),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color:Colors.grey, size: 16,),
              ],
            )));
  }
}
