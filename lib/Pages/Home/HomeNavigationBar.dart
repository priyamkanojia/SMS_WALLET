import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/MyTeam.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Pages/Drawer/KYCformWidget.dart';
import 'package:sms_wallet/Pages/Drawer/MyTeamListWidget.dart';
import 'package:sms_wallet/Pages/Drawer/ProfileEditWidget.dart';
import 'package:sms_wallet/Pages/Drawer/ReferAndEarnWidget.dart';
import 'package:sms_wallet/Pages/Home/HomePage.dart';
import 'package:sms_wallet/Pages/Wallet/WalletWidget.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../ad_state.dart';
import '../../google_ads.dart';
import '../../interstitialAd.dart';

int _currentIndex =2 ;

class HomeNavigationBarWidget extends StatefulWidget {
  final String id;
  final int index;
  HomeNavigationBarWidget({
    Key key,
    @required this.id,
    @required this.index,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeNavigationBarState();
  }
}

showAlertDialogAppUpdate(BuildContext context, String type) {
  Widget okButton = InkWell(
    child: Container(
      color: Colors.green,
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * 0.3,
      child: Text(
        "Update",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6.apply(
            color: Colors.white, fontSizeFactor: 0.8, fontWeightDelta: 30),
      ),
    ),
    onTap: () {
      StoreRedirect.redirect(
          androidAppId: "com.dishaInno.bada_bhalu", iOSAppId: "585027354");
      if (type != "force") {
        Navigator.of(context).pop();
      }
    },
  );
  Widget cancel = InkWell(
    child: Container(
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * 0.3,
      child: Text(
        "No thanks",
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6
            .apply(fontSizeFactor: 0.8, fontWeightDelta: 30),
      ),
    ),
    onTap: () {
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Update SMS Wallet ?",
      style: Theme.of(context)
          .textTheme
          .headline6
          .apply(fontSizeFactor: 0.9, fontWeightDelta: 30),
    ),
    content: Text(
        "SMS Wallet recommends you to update the application with latest available version."),
    actions: [
      type != "force" ? cancel : null,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: type == "force" ? false : true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _HomeNavigationBarState extends State<HomeNavigationBarWidget> {
  @override
  void initState() {
    super.initState();
   // _currentIndex=2;
   // _currentIndex = widget.index;
    PackageInfo.fromPlatform().then((value) {
      String appName = value.appName;
      String packageName = value.packageName;
      String version = value.version;
      String buildNumber = value.buildNumber;

      AppSettingsController.appUpdate().then((value1) {
 if (!UserDetails.kycPopShowed &&
        (UserDetails.isKycDone.toLowerCase() == "0" ||
            UserDetails.isKycDone.toLowerCase() == "rejected")) {
      _kycPopup();
      UserDetails.kycPopShowed = true;
    }
        print(value1);
        if (value1 != null) {
          if ((version + "-" + buildNumber) != value1) {
            if (value1.substring(0, value1.indexOf("-") ) ==
                    version &&
                int.parse(buildNumber) <
                    int.parse(value1.replaceAll(
                        value1.substring(0, value1.indexOf("-")+1),
                        "")))
              showAlertDialogAppUpdate(context, "force");
            else if (value1
                    .substring(0, value1.indexOf("-") ) !=
                version) {
                  
                }
          }
        }
      });
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you really want to exit SMS Wallet?'),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (context) =>NativeAd()));
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (context) =>NativeAd()));

                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  //int _currentIndex =2 ;

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_currentIndex) {
      case 0:
        //Navigator.push(context,Mater)
        child = WalletWidget();
        break;
      case 1:
        child = MyTeamListWidget();
        break;
      case 2:
        child = HomePage();
        break;
        case 3:
        child = ProfileEditWidget();
        break;
      case 4:
        child = ReferAndEarn();
        break;
      default :
        child = HomePage();
        break;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.id != null
          ? Stack(children: <Widget>[
              IndexedStack(
                sizing: StackFit.loose,

                index: _currentIndex,

                children: [
                  WalletWidget(),
                  MyTeamListWidget(),
                  HomePage(),
                  ProfileEditWidget(),
                  ReferAndEarn(),
                ], //viewContainer,

                alignment: Alignment.topRight,
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(canvasColor: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      ),
                      child: BottomNavigationBar(
                        currentIndex:_currentIndex,
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: MyColors.darkBlue,
                        selectedItemColor: Colors.white,
                        unselectedItemColor: MyColors.lightBlue,
                        selectedFontSize: 13,
                        unselectedFontSize:10,
                        onTap: (value) {
                          setState(() => _currentIndex = value);
                          //child;
                          //Navigator.of(context).pushNamed(_currentIndex.toString());
                        },
                        items: [
                          BottomNavigationBarItem(
                            title: Text(
                              'Wallet',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize:12.0),
                            ),
                            icon: Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 20,
                            ),
                          ),
                          BottomNavigationBarItem(
                            title: Text(
                              'My Team',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),
                            ),
                            icon: Icon(
                              Icons.card_giftcard,
                              size: 20,
                            ),
                          ),
                          BottomNavigationBarItem(
                            title: Text(
                              'Home',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize:12.0),
                            ),
                            icon: Icon(
                              Icons.home_outlined,
                              size: 20,
                            ),
                          ),
                          BottomNavigationBarItem(
                            title: Text(
                              'Account',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),
                            ),
                            icon: Icon(
                              Icons.account_circle_outlined,
                              size: 20,
                            ),
                          ),
                          BottomNavigationBarItem(
                            title: Text(
                              'Refer & Earn',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),
                            ),
                            icon: Icon(
                              Icons.share_outlined,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ])
          : Container(),
    );
  }
  Future<bool> _kycPopup() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'KYC',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)),
                height: 100,
                child: Text(
                    "Your KYC Is Not Complete, Please Complete KYC For Better Experience.",
                    )),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>KYCformWidget()));
                },
                child: Text('Continue', style: TextStyle(fontWeight: FontWeight.bold, color:Colors.blue[700])),
              ),
            ],
          ),
        ) ??
        false;
  }
}
