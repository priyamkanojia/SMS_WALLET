import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Controllers/HomeController.dart';
import 'package:sms_wallet/Controllers/Timer.dart';
import 'package:sms_wallet/Controllers/WalletController.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sms_wallet/Models/MyWallet.dart';
import 'package:sms_wallet/Models/faq_class.dart';
import 'package:sms_wallet/Pages/Wallet/RewardHistoryWidget.dart';
import 'package:sms_wallet/Pages/Wallet/ShoppingWalletTansectionHistoryWidget.dart';
import 'package:sms_wallet/Pages/Wallet/EscrowWalletTransectionWidget.dart';
import 'package:sms_wallet/Pages/faq.dart';

import '../../ad_state.dart';

class WalletWidget extends StatefulWidget {
  WalletWidget({
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return WalletWidgetState();
  }
}

class WalletWidgetState extends State<WalletWidget> {
  bool _saving = false;

  void submit() {
    setState(() {
      _saving = true;
    });
  }
  var latFaq;
  @override
  void initState() {
    super.initState();
    latFaq = HomeController.getFaq();
  }

  Widget progress() {
    return Center(
      child: SpinKitThreeBounce(
        color: MyColors.orange,
        size: 32,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      progressIndicator: progress(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Wallets",
            style: Theme.of(context)
                .textTheme
                .headline6
                .apply(color: Colors.white),
          ),
          backgroundColor: MyColors.darkBlue,
          iconTheme: Theme.of(context)
              .iconTheme
              .merge(IconThemeData(color: Colors.white)),
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5.0,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0,2.0,5.0,2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Reward/Hr: '),
                          Text('0.00001000'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0,2.0,5.0,2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Remaining Time: '),
                          CountDownTimer(),
                        ],
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.fromLTRB(5.0,2.0,5.0,2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Reward Per Sec: '),
                          RewardPreSec(),
                        ],
                      ),
                    ),*/
                  ],
                ),
              ),

              FutureBuilder<List<MyWallet>>(
                  future: WalletController.getWallets(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              ShoppingWalletTransectionHistoryWidget()));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      height: MediaQuery.of(context).size.width * 0.4,
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[400],
                                                blurRadius: 3,
                                                spreadRadius: 0.5)
                                          ],
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            "assets/logo.png",
                                            width: MediaQuery.of(context).size.width *
                                                0.20,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width *
                                                    0.4 -
                                                24,
                                            child: Column(
                                              children: [
                                                Text("Shopping",
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .apply(
                                                          color: Colors.black,
                                                          fontWeightDelta: 30,
                                                          fontSizeFactor: 0.6,
                                                        )),
                                                Text(
                                                    snapshot
                                                            .data[0].walletShoping,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .apply(
                                                          color: Colors.black,
                                                          fontWeightDelta: 30,
                                                          fontSizeFactor: 0.6,
                                                        )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              RewardHistoryWidget()));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      height: MediaQuery.of(context).size.width * 0.4,
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[400],
                                                blurRadius: 3,
                                                spreadRadius: 0.5)
                                          ],
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            "assets/logo.png",
                                            width: MediaQuery.of(context).size.width *
                                                0.20,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.4 -
                                                    24,
                                                child: Text("Reward",
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .apply(
                                                          color: Colors.black,
                                                          fontWeightDelta: 30,
                                                          fontSizeFactor: 0.6,
                                                        )),
                                              ),
                                              Text(snapshot.data[0].walletReward,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .apply(
                                                        color: Colors.black,
                                                        fontWeightDelta: 30,
                                                        fontSizeFactor: 0.6,
                                                      )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.width * 0.4,
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[400],
                                              blurRadius: 3,
                                              spreadRadius: 0.5)
                                        ],
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          "assets/logo.png",
                                          width: MediaQuery.of(context).size.width *
                                              0.20,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width *
                                                  0.4 -
                                              24,
                                          child: Column(
                                            children: [
                                              Text("Stacking",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .apply(
                                                        color: Colors.black,
                                                        fontWeightDelta: 30,
                                                        fontSizeFactor: 0.6,
                                                      )),
                                              Text(
                                                  snapshot
                                                          .data[0].walletStaking,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .apply(
                                                        color: Colors.black,
                                                        fontWeightDelta: 30,
                                                        fontSizeFactor: 0.6,
                                                      )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                       Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                               EcrowWalletTransectionHistoryWidget() ));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      height: MediaQuery.of(context).size.width * 0.4,
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[400],
                                                blurRadius: 3,
                                                spreadRadius: 0.5)
                                          ],
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            "assets/logo.png",
                                            width: MediaQuery.of(context).size.width *
                                                0.20,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width *
                                                    0.4 -
                                                24,
                                            child: Column(
                                              children: [
                                                Text("Escrow",
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .apply(
                                                          color: Colors.black,
                                                          fontWeightDelta: 30,
                                                          fontSizeFactor: 0.6,
                                                        )),
                                                Text(
                                                    snapshot
                                                            .data[0].walletEscrow,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .apply(
                                                          color: Colors.black,
                                                          fontWeightDelta: 30,
                                                          fontSizeFactor: 0.6,
                                                        )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.width * 0.4,
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[400],
                                              blurRadius: 3,
                                              spreadRadius: 0.5)
                                        ],
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          "assets/logo.png",
                                          width: MediaQuery.of(context).size.width *
                                              0.20,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width *
                                                  0.4 -
                                              24,
                                          child: Column(
                                            children: [
                                              Text("Gaming",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .apply(
                                                        color: Colors.black,
                                                        fontWeightDelta: 30,
                                                        fontSizeFactor: 0.6,
                                                      )),
                                              Text(
                                                  snapshot
                                                          .data[0].walletGaming,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .apply(
                                                        color: Colors.black,
                                                        fontWeightDelta: 30,
                                                        fontSizeFactor: 0.6,
                                                      )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.width * 0.4,
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[400],
                                              blurRadius: 3,
                                              spreadRadius: 0.5)
                                        ],
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          "assets/logo.png",
                                          width: MediaQuery.of(context).size.width *
                                              0.20,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width *
                                                  0.4 -
                                              24,
                                          child: Text("Others",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .apply(
                                                    color: Colors.black,
                                                    fontWeightDelta: 30,
                                                    fontSizeFactor: 0.6,
                                                  )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              ShowBannerAdd(),
                              SizedBox(height:5.0,),
                            ],
                          ),
                        );
                      }
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width,
                        child:
                            Center(child: Text("Server Error!\nTry After Sometime.")),
                      );
                    }
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: SpinKitThreeBounce(
                        color: MyColors.darkBlue,
                        size: 32,
                      )),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
