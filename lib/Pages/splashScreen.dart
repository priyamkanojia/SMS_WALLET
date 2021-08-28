import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Controllers/LoginController.dart';
import 'package:sms_wallet/Models/AppSettings.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Pages/Home/HomeNavigationBar.dart';
import 'package:sms_wallet/Pages/Home/HomePage.dart';
import 'package:sms_wallet/Pages/Intro/IntroHomeWidget.dart';
import 'package:sms_wallet/Pages/LoginPage.dart';
import 'package:sms_wallet/Pages/notApproved.dart';
import 'package:sms_wallet/interstitialAd.dart';

class SplashScreen extends StatefulWidget {
  String id, api_token;
  bool intro;
  SplashScreen(
      {Key key,
      @required this.id,
      @required this.api_token,
      @required this.intro})
      : super(key: key);

  @override
  SplashScreenState createState() => new SplashScreenState(id: id);
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  String id;
  SplashScreenState({Key key, @required this.id});
  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    AppSettingsController.getSettings().then((value) {
                  UserDetails.kycPopShowed=false;

      List<AppSettings> lst = [];
      lst.addAll(value);
      lst.retainWhere((element) => element.keyName == "login-two-factor-auth");
      if (lst.length == 1 && lst[0].value == "false") {
        UserDetails.isOtpVerificationOn = false;
      } else {
        UserDetails.isOtpVerificationOn = true;
      }
       if (widget.intro != null && widget.intro) {
      if (id != null) {
        LoginController.userInfo(id, widget.api_token).then((value) {
          if (value == "success") {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    //NativeAd()
                    HomeNavigationBarWidget(id: id, index: 0)
            ));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ErrorssWidget(
                      parameter:
                          "Server Error!\n(Check Your Internet Connection)",
                      from: "splash",
                    )));
          }
        });
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginWidget()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>IntroHomeWidget()));
      //IntroHomeWidget()
    }
    });
   
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 4));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  'assets/logo.png',
                  width: 240,
                  height: 240,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
