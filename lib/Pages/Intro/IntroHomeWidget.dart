import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Pages/Intro/IntroScreen1.dart';
import 'package:sms_wallet/Pages/Intro/IntroScreen2.dart';
import 'package:sms_wallet/Pages/Intro/IntroScreen3.dart';
import 'package:sms_wallet/Pages/LoginPage.dart';

class IntroHomeWidget extends StatefulWidget {
  @override
  _IntroHomeWidgetState createState() => _IntroHomeWidgetState();
}

class _IntroHomeWidgetState extends State<IntroHomeWidget> {
  int selecteIndex;
  @override
  void initState() {
    selecteIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color backGroundColor;
    Widget introWidget;
    switch (selecteIndex) {
      case 1:
        backGroundColor = MyColors.darkBlue;
        introWidget = Listener(

          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.6,
            child: Center(child: introScren1(context)),
          ),
        );

        break;
      case 2:
        backGroundColor =MyColors.darkBlue;
        introWidget = Container(decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.6,
          child: Center(child: introScren2(context)),
        );

        break;
      case 3:
        backGroundColor = MyColors.darkBlue;
        introWidget = Container(decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.6,
          child: Center(child: introScren3(context)),
        );

       

        break;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: backGroundColor),
          ),
          
                 Positioned(
            top: 0,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: MyColors.darkBlue,
                ),
                child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           SizedBox(height: 16),
                          // Text("Welcome To",
                          //     textAlign: TextAlign.center,
                          //     style:
                          //         Theme.of(context).textTheme.headline6.apply(
                          //             fontSizeFactor: 0.7,
                          //             // fontWeightDelta: 30,
                          //             color: Colors.white)),
                          SizedBox(height: 3),
                          
                          Text(Urls.intro_home_head,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontSizeFactor: 1.1,
                                      fontWeightDelta: 30,
                                      color: Colors.white))
                        ]),
                  )
                ])),
          ),              

          
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            child: introWidget),
          Positioned(
            bottom: 0,
            child: Container(
              height:MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
               
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: selecteIndex != 1
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              selecteIndex--;
                            });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_back_ios_outlined,
                                  size: 20,
                                      color: MyColors.darkBlue.withOpacity(0.5)),
                                  Text("    "),
                                ],
                              )))
                      : Container(),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.all(8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: selecteIndex == 1
                                    ? MyColors.darkBlue
                                    : MyColors.darkBlue.withOpacity(0.4)),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: selecteIndex == 2
                                    ? MyColors.darkBlue
                                    : MyColors.darkBlue.withOpacity(0.4)),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: selecteIndex == 3
                                    ? MyColors.darkBlue
                                    :MyColors.darkBlue.withOpacity(0.4)),
                          ),
                          
                        ])),
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: selecteIndex != 3
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              selecteIndex++;
                            });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("    "),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                      color: MyColors.darkBlue.withOpacity(0.5)),
                                ],
                              )))
                      : InkWell(
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setBool('intro', true);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginWidget()));
                          },
                          child: Row(
                            children: [
                              Text("    "),
                              Container(
                                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                decoration: BoxDecoration(
                                  color:Colors.greenAccent[700],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "Get Started",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .apply(
                                          fontSizeFactor: 0.6,
                                          color: Colors.white,
                                          fontWeightDelta: 30,
                                          fontFamily: 'Poppins'),
                                ),
                              ),
                            ],
                          )),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
