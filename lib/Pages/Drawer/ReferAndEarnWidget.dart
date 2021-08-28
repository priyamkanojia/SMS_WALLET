import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Controllers/HomeController.dart';
import 'package:sms_wallet/Models/AppSettings.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Models/faq_class.dart';
import 'package:sms_wallet/Pages/faq.dart';


class ReferAndEarn extends StatefulWidget {
  ReferAndEarn({Key key}) : super(key: key);

  @override
  _ReferAndEarnState createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {

  List<AppSettings> lstAppSettings;
  String refererPoints = '', referedPoints = '' , dailyReward = '';
  var latFaq;
  @override
  void initState() {

    AppSettingsController.getRefererReferedAndDaylyRewardPoints().then((value) => {
          setState(() {
            refererPoints = jsonDecode(value.body)[0]['referer_points'];
            referedPoints = jsonDecode(value.body)[0]['refered_points'];
            dailyReward = jsonDecode(value.body)[0]['daily_reward'];
           }) 
        });
    latFaq = HomeController.getFaq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 22,),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        backgroundColor: MyColors.darkBlue,
        elevation: 0.0,
        title: Text(
          "Refer And Earn",
          style: Theme.of(context)
              .textTheme
              .headline6
              .apply(fontWeightDelta: 30, fontSizeFactor: 0.9, color:Colors.white),
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
            Image(image: AssetImage('assets/logo.png'), height: MediaQuery.of(context).size.height*0.3),
            Padding(
              padding: const EdgeInsets.fromLTRB(24,24,24,8),
              child: Text("Invite Your Friends And Earn "+" " + refererPoints + ' '+"Points.",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .apply(fontWeightDelta: 30, fontSizeFactor: 0.8, color:Colors.black)),
            ),
            
            SizedBox(
              height: 30,
            ),
            Text("Your Referral Code"),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.grey[350],
              height: 40,
              width: MediaQuery.of(context).size.width * 0.4,
              alignment: Alignment.center,
              child: Text(
                UserDetails.referalcode.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                
                Share.share('Use this referral code: ' +
                    UserDetails.referalcode.toString() +
                    '\nto earn ' +
                    referedPoints +
                    ' Points. Install SMS Wallet app from below link' +
                    '\nhttps://play.google.com/store/apps/details?id=com.walletsms.selfmadesociety');
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RazorpayPaymentPage(amount: donationController.text.trim())));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: MyColors.darkBlue),
                child: Text(
                  "Refer Now",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.apply(
                      fontWeightDelta: 30,
                      fontSizeFactor: 0.7,
                      color: Colors.white),
                ),
              ),
            ),
              SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
