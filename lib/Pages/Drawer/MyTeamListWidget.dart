import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Controllers/HomeController.dart';
import 'package:sms_wallet/Controllers/ShimmerController.dart';
import 'package:sms_wallet/Controllers/TeamController.dart';
import 'package:sms_wallet/Models/AppSettings.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/MyTeam.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/faq_class.dart';
import 'package:sms_wallet/Pages/faq.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyTeamListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyTeamListWidgetState();
  }
}

Future<List<MyTeam>> lstMyTeam;

class MyTeamListWidgetState extends State<MyTeamListWidget> {
  TextEditingController searchCon = new TextEditingController();
  var latFaq;
  @override
  void initState() {
    lstMyTeam = TeamController.getMyTeam();
    latFaq = HomeController.getFaq();
    super.initState();
  }
  void setSt() {
    setState(() {
      lstMyTeam = TeamController.getMyTeam();
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
          centerTitle: true,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.white),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          backgroundColor: MyColors.darkBlue,
          elevation: 0,
          title: Text(
            "My Team",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        actions: <Widget>[
          FutureBuilder<List<FaqClass>>(
              future: latFaq,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Faq(lstMessages: snapshot.data)));
                      },
                      icon: Icon(Icons.help_outline_outlined,size: 25.0,color: Colors.white,));
                }else{
                  return SizedBox();
                }
              }
          ),
        ],
      ),
      body: FutureBuilder<List<MyTeam>>(
          future: lstMyTeam,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 12, bottom: 60),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < snapshot.data.length)
                            return Container(
                                child: _product(snapshot.data[index]));
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text("No Member Found."));
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

  InkWell _product(MyTeam item) {
    return InkWell(
        onTap: () {
         
        
        },
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: item.profileImage != null &&
                                              item.profileImage.length >
                                                  0
                                          ? NetworkImage(
                                            Urls.image_urls+item.profileImage,
                                            )
                                          : AssetImage(
                                              "assets/userprofile.png")))),

                                              SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((item.fullname),
                          style:
                              Theme.of(context).textTheme.subtitle1.apply(
                                    fontSizeFactor: 0.9,
                                    color: MyColors.darkBlue,
                                    fontWeightDelta: 30
                                  )),
                                  Text((item.email!=null?item.email:""),
                          style:
                              Theme.of(context).textTheme.subtitle1.apply(
                                    fontSizeFactor: 0.8,
                                    color: Colors.grey,
                                    fontWeightDelta: 30
                                  )),
                                  Text((item.mobile!=null?item.mobile:""),
                          style:
                              Theme.of(context).textTheme.subtitle1.apply(
                                    fontSizeFactor: 0.8,
                                    color: Colors.grey,
                                    fontWeightDelta: 30
                                  )),
                                  Text(("Team: "+item.team.toString()),
                          style:
                              Theme.of(context).textTheme.subtitle1.apply(
                                    fontSizeFactor: 0.8,
                                    color: MyColors.darkred,
                                    fontWeightDelta: 30
                                  )),
                    ],
                  ),
                ),
              ],
            )));
  }
}
