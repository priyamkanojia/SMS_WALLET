import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Controllers/WalletController.dart';
import 'package:sms_wallet/Models/AppSettings.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Pages/Home/MoneyTransferContactsWidget.dart';
import 'package:sms_wallet/Pages/Wallet/SendMoneyWidget.dart';

class MoneyTransferContactsDetailWidget extends StatefulWidget {
  MyContacts myContacts;
  MoneyTransferContactsDetailWidget({
    Key key,
    @required this.myContacts,
  }) : super(key: key);
  @override
  _MoneyTransferContactsDetailWidgetState createState() =>
      _MoneyTransferContactsDetailWidgetState();
}

List<AppSettings> lstAppSettings;
String refererPoints = '', referedPoints = '';

class _MoneyTransferContactsDetailWidgetState
    extends State<MoneyTransferContactsDetailWidget> {
  @override
  void initState() {
    AppSettingsController.getSettings().then((value) => {
          setState(() {
            lstAppSettings = value;
            lstAppSettings.forEach((element) {
              if (element.keyName.toLowerCase() == 'referer points') {
                refererPoints = element.value;
              }
              if (element.keyName.toLowerCase() == 'refered points') {
                referedPoints = element.value;
              }
            });
          })
        });
    super.initState();
    lstCont = WalletController.getContactsFromSrv(
        AppSettingsController.phoneWithoutCode(widget.myContacts.phone.trim()));
    lstCont.then((value) {
      if (value.length > 0) {
        setState(() {
          widget.myContacts.name = value[0].name;
          widget.myContacts.phone = value[0].phone;
          widget.myContacts.image = value[0].image;
        });
      }
    });
  }

  Future<List<MyContacts>> lstCont;
void filtering(){

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          titleSpacing: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.myContacts.name,
                    style: Theme.of(context).textTheme.headline6.apply(
                        fontSizeFactor: 0.7,
                        color: Colors.white,
                        fontWeightDelta: 30),
                  ),
                  Text(
                    widget.myContacts.phone,
                    style: Theme.of(context).textTheme.headline6.apply(
                        fontSizeFactor: 0.6,
                        color: Colors.white.withOpacity(0.6),
                        fontWeightDelta: 30),
                  ),
                ],
              ),
              Row(
                children: [
                  widget.myContacts.image,
                  SizedBox(width: 12),
                ],
              )
            ],
          ),
          backgroundColor: MyColors.darkBlue,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<MyContacts>>(
              future: lstCont,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                      MediaQuery.of(context).size.height * 0.20,
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.30,
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.height * 0.1,MediaQuery.of(context).size.height * 0.05,MediaQuery.of(context).size.height * 0.1,MediaQuery.of(context).size.height * 0.05),
                                  child: Image(
                                      image: AssetImage('assets/logo.png'))),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 0, 24, 8),
                                child: Text(
                                    "No Transections Found.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            fontSizeFactor: 0.7,
                                            color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // height:MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
          //                           showModalBottomSheet(
          //                       backgroundColor: Colors.transparent,
          //                       isScrollControlled: true,
          //                       context: context,
          //                       builder: (BuildContext bc) {
          //                         return Container(
          //                             decoration: BoxDecoration(
          //                               borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(30.0),
          //   topRight: Radius.circular(30.0),
            
          // ),
          //                                       color: Colors.white,

          //                             ),
          //                             height:
          //                                 MediaQuery.of(context).size.height *
          //                                     0.7,
          //                             width: MediaQuery.of(context).size.width,
          //                             child: SendMoneyWidget(
          //                               filtering: filtering,
          //                               user_id: UserDetails.id,
          //                               myContacts: widget.myContacts,
          //                             ));
          //                       });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: MyColors.darkBlue),
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      margin: EdgeInsets.all(16),
                                      child: Center(
                                          child: Text(
                                        "Send Money",
                                        textAlign: TextAlign.justify,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .apply(
                                                fontSizeFactor: 0.7,
                                                fontWeightDelta: 30,
                                                color: Colors.white),
                                      ))),
                                )
                              ]),
                        )
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      // border: Border.all(
                                      //     width: 1, color: MyColors.darkBlue),
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          MyColors.darkred.withOpacity(0.2)),
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.all(12),
                                  child: Center(
                                      child: Text(
                                    "The Person With This Number Is Not Yet On SMS Wallet. Invite Your Friends And Earn " +
                                        " " +
                                        refererPoints +
                                        ' ' +
                                        "Points.",
                                    // textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            fontSizeFactor: 0.7,
                                                                                        fontWeightDelta: 30,

                                            color: Colors.black),
                                  ))),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.30,
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.height * 0.1,MediaQuery.of(context).size.height * 0.05,MediaQuery.of(context).size.height * 0.1,MediaQuery.of(context).size.height * 0.05),
                                  child: Image(
                                      image: AssetImage('assets/logo.png'))),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 0, 24, 8),
                                child: Text(
                                    "Invite Your Friends\n&\nEarn " +
                                        " " +
                                        refererPoints +
                                        ' ' +
                                        "Points.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            fontWeightDelta: 30,
                                            fontSizeFactor: 0.8,
                                            color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // height:MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Share.share('Use this referral code: ' +
                                        UserDetails.referalcode.toString() +
                                        '\nto earn ' +
                                        referedPoints +
                                        ' Points. Install SMS Wallet app from below link' +
                                        '\nhttps://play.google.com/store/apps/details?id=com.walletsms.selfmadesociety');
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: MyColors.darkBlue),
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      margin: EdgeInsets.all(16),
                                      child: Center(
                                          child: Text(
                                        "Refer Now",
                                        textAlign: TextAlign.justify,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .apply(
                                                fontSizeFactor: 0.7,
                                                fontWeightDelta: 30,
                                                color: Colors.white),
                                      ))),
                                )
                              ]),
                        )
                      ],
                    );
                  }
                } else {
                  return Container(
                      height:
                          (((MediaQuery.of(context).size.width / 6) + 32) * 3) +
                              32 +
                              MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      child: SpinKitThreeBounce(
                        color: MyColors.darkBlue,
                        size: 32,
                      ));
                }
              }),
        ));
  }
}
