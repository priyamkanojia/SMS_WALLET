import 'dart:async';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sms_wallet/Controllers/HomeController.dart';
import 'package:sms_wallet/Controllers/Timer.dart';
import 'package:sms_wallet/Models/BannerSlider.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/News.dart';
import 'package:sms_wallet/Models/Sliders.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Pages/Drawer/Drawer.dart';
import 'package:sms_wallet/Pages/Drawer/KYCformWidget.dart';
import 'package:sms_wallet/Pages/Home/FullSlider.dart';
import 'package:sms_wallet/Pages/Home/GetRewards.dart';
import 'package:sms_wallet/Pages/Home/HomeNavigationBar.dart';
import 'package:sms_wallet/Pages/Home/MoneyTransferContactsWidget.dart';
import 'package:sms_wallet/Pages/Home/NewsListWidget.dart';
import 'package:sms_wallet/Pages/Home/NewsSmallWidget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sms_wallet/Pages/Home/Services.dart';
import 'package:sms_wallet/Pages/Home/Tawk_Support.dart';
import 'package:sms_wallet/Pages/Home/bannerSlider.dart';
import 'package:sms_wallet/Pages/Home/caregory.dart';
import 'package:sms_wallet/Pages/Home/smshub.dart';
import 'package:sms_wallet/google_ads.dart';
import 'package:sms_wallet/main.dart';

import '../../ad_state.dart';
import 'HomePageClasses.dart';

//var clickOnTimer = new Count_Timer();
bool visible = true;
var endTimer=DateTime.now() ,currentTime=DateTime.now().toString();

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _token;
  Timer buttonIntervel;
  var currDateTimeNow;
  var lstSmsHub,lstServices,lstCategory;
  @override
  void initState() {
    _saving = false;
    lstNews = HomeController.getNews();
    getSharedPrefTimer();
    currDateTime();
    lstSmsHub =HomeController.getSMSHub();
    lstServices = HomeController.getServices();
    lstCategory = HomeController.getCategory();
    currDateTimeNow = Timer.periodic(Duration(seconds: 1), (timer) {currDateTime();});
    Timer.periodic(Duration(hours: 24), (timer) {removeSharedPrefData();});
    //removeSharedPrefData();
    super.initState();
   
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {}
    });

    @override
    void dispose(){
      buttonIntervel.cancel();
      currDateTimeNow.cancel();
      super.dispose();
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: "assets/logo.png",
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  bool _saving = false;
  bool _saving2 = false;
  Future<List<News>> lstNews;
  getSharedPrefTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      endTimer = DateTime.parse(prefs.getString('ExpireTime'));
    });
    print('Shared Pref Timer: $endTimer');
    return endTimer;
  }
  removeSharedPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('ExpireTime');
    setState(() {
      endTimer=null;
    });
    return endTimer;
  }

  currDateTime(){
    DateTime currTime = DateTime.now();
    String dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss").format(currTime);
    setState(() {
      currentTime = dateFormat;
    });
    print(currTime);
    //print(currDateTimeNow);
    return currentTime;
  }
  /*checkTimer(){
    if(endTimer == null){
      setState(() {
        visible = true;
      });
    }
    if(currentTime.toString() == endTimer.toString()){
      print('Current Date if: $currentTime');
      print('End Timer if: $endTimer');
      setState(() {
        visible = true;
        removeSharedPrefData();
      }
      );
    }
    if(endTimer == null){
      print(endTimer);
      setState(() {
        visible=true;
      });
    }

    else if (currentTime.toString() != endTimer.toString() ){
      print('End Timer: $endTimer');
      print('Cur Time:$currentTime');
      setState(() {
        visible = true;
      });
    }
    else{
      //removeSharedPrefData();
    }
  }*/


  @override
  Widget build(BuildContext context) {
    lstNews = HomeController.getNews();

    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: ModalProgressHUD(
        inAsyncCall: _saving2,
        progressIndicator: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(MyColors.darkBlue)),
        ),
        child: Scaffold(
            key: _scaffoldKey,
            drawer: ProfileDrawer(
              refreshHome: () {
                setState(() {});
              },
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.sort, color: Colors.white),
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
              elevation: 0.0,
              centerTitle: false,
              backgroundColor: MyColors.darkBlue,
              title: GetRewardsData(),
              actions: [
                IconButton(
                    icon: Icon(Icons.chat_outlined, color: Colors.white),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>TawkSupport()));
                    }),
                IconButton(
                    icon: Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {})
              ],
            ),
            //bottomNavigationBar: HomeNavigationBarWidget(),
            backgroundColor: Colors.white,
            floatingActionButton: TriggerTimer(),
            body: Stack(
              children: [
                Positioned(
                  child: Column(
                    children: [
                      CustomPaint(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.8,
                        ),
                        painter: HeaderCurvedContainer(),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView(
                      children: [
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            FutureBuilder<List<Sliders>>(            ///Top Slider
                                future: HomeController.getSliders(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.length > 0) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin: const EdgeInsets.all(8.0),
                                        child: HomeSlider(
                                          lstSlider: snapshot.data,
                                        ),
                                      );
                                    }
                                    return Container();
                                  }
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.white,
                                    child: Container(
                                      //margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.24,
                                    ),
                                  );
                                }),
                            ///SMS HUB
                            FutureBuilder<List<SmsHubClass>>(
                                        future: lstSmsHub,
                                        builder: (context,snapshot){
                                          if(snapshot.hasData){
                                            return
                                            Wrap(
                                            children: [
                                            Container(
                                            margin: EdgeInsets.all(10.0),
                                            padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
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
                                            ),
                                            child:Column(
                                            children: <Widget>[
                                            Text("SMS Hub", style: Theme.of(context).textTheme.headline6.apply(fontSizeFactor: 0.75, color: MyColors.darkBlue, fontWeightDelta:30, fontFamily: 'Poppins')),
                                            SizedBox(height: 5.0,),
                                            SmsHub(lstMessages: snapshot.data)
                                            ]),
                                            )]);
                                          }
                                          else
                                            return SizedBox();
                                        },
                                      ),
                            FutureBuilder<List<ServicesClass>>(
                                future: lstServices,
                                builder: (context,snapshot){
                                  if(snapshot.hasData){
                                    return Wrap(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                          //height:280,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
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
                                          ),
                                          child:Column(
                                            children: <Widget>[
                                              Text("Services", style: Theme.of(context).textTheme.headline6.apply(fontSizeFactor: 0.75, color: MyColors.darkBlue, fontWeightDelta:30, fontFamily: 'Poppins')),
                                              SizedBox(height: 5.0,),
                                              Service(lstMessages: snapshot.data),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  else
                                    return SizedBox();
                                }

                            ),

                            ///BANNER SLIDER
                            FutureBuilder<List<BannerSliders>>(            ///Banner Slider
                                future: HomeController.getBanner(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.length > 0) {
                                      return Center(
                                        child: Container(
                                          //width: 400.0,
                                          //height:200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //       color: Colors.black
                                            //           .withOpacity(0.3),
                                            //       offset: Offset(0.5, 0.5),
                                            //       blurRadius: 8,
                                            //       spreadRadius: 0.5)
                                            //],
                                          ),
                                          margin: const EdgeInsets.all(8.0),
                                          child: BannerSlider(
                                            lstBannerSlider: snapshot.data,
                                          ),
                                        ),
                                      );
                                    }
                                    return Container(
                                      height: 100,
                                      width: 150,
                                    );
                                  }
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.white,
                                    child: Container(
                                      //margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                    ),
                                  );
                                }),
                            ///CATEGORY
                            FutureBuilder<List<CategoryClass>>(
                              future: lstCategory,
                              builder: (context,snapshot){
                                if(snapshot.hasData){
                                  return
                                    Wrap(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(10.0),
                                            padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
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
                                            ),
                                            child:Column(
                                                children: <Widget>[
                                                  Text("Category", style: Theme.of(context).textTheme.headline6.apply(fontSizeFactor: 0.75, color: MyColors.darkBlue, fontWeightDelta:30, fontFamily: 'Poppins')),
                                                  SizedBox(height: 5.0,),
                                                  Category(lstMessages: snapshot.data),
                                                ]),
                                          )]);
                                }
                                else
                                  return SizedBox();
                              },
                            ),




                            /*Wrap(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
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
                                  ),
                                  child:Column(
                                    children: <Widget>[
                                      Text("Category", style: Theme.of(context).textTheme.headline6.apply(fontSizeFactor: 0.75, color: MyColors.darkBlue, fontWeightDelta:30, fontFamily: 'Poppins')),
                                      SizedBox(height: 5.0,),
                                     Category(),
                                    ],
                                  ),
                                ),
                              ],
                            ),*/
                            SizedBox(height: 5.0,),
                            ShowBannerAdd(),
                            SizedBox(height: 10.0,),
                            //ShowNativeAd(),
                            //ShowNativeAd(),
                            //GoogleAds(),
                            /*FutureBuilder<List<News>>(
                                future: lstNews,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding:
                                          EdgeInsets.fromLTRB(24, 8, 24,24),
                                      child: Column(
                                        children:<Widget> [
                                         Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              FutureBuilder<List<Sliders>>(
                                                  future: HomeController.getSliders(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      if (snapshot.data.length > 0) {
                                                        return Container(
                                                          width: 200.0,
                                                          height: 90.0,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.black
                                                                      .withOpacity(0.3),
                                                                  offset: Offset(0.5, 0.5),
                                                                  blurRadius: 8,
                                                                  spreadRadius: 0.5)
                                                            ],
                                                          ),
                                                          //margin: const EdgeInsets.all(20.0),
                                                          child: HomeSlider(
                                                            lstSlider: snapshot.data,
                                                          ),
                                                        );
                                                      }
                                                      return Container();
                                                    }
                                                    return Shimmer.fromColors(
                                                      baseColor: Colors.grey[300],
                                                      highlightColor: Colors.white,
                                                      child: Container(
                                                        margin: EdgeInsets.all(16),
                                                        decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                            BorderRadius.circular(10)),
                                                        width: MediaQuery.of(context).size.width,
                                                        height:
                                                        MediaQuery.of(context).size.height *
                                                            0.24,
                                                      ),
                                                    );
                                                  }),
                                              SizedBox(width: 10.0,),
                                              Container(
                                                height: 100.0,
                                                width: 100.0,
                                                child:NewTimer(),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container(
                                        height: (((MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        6) +
                                                    32) *
                                                3) +
                                            32 +
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: SpinKitThreeBounce(
                                          color: MyColors.darkBlue,
                                          size: 32,
                                        ));
                                  }
                                }),*/
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<bool> _askPermissions() async {
    bool status = false;
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      status = true;
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
    return status;
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

class Message {
  final String title;
  final String body;
  Message({this.body, this.title});
}

// CustomPainter class to for the header curved-container
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(0, 150),
        [
          MyColors.darkBlue,
          MyColors.darkBlue.withOpacity(0.8),
        ],
      );
    Path path = Path()
      ..relativeLineTo(0, size.height * 0.25)
      ..quadraticBezierTo(
          size.width / 2, size.height * 0.4, size.width, size.height * 0.25)
      ..relativeLineTo(0, -size.height * 0.25)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HeaderCurvedContainerwhite extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(0, 150),
        [
          MyColors.darkBlue,
          MyColors.darkBlue.withOpacity(0.8),
        ],
      );
    Path path = Path()
      ..relativeLineTo(0, size.height * 0.25)
      ..quadraticBezierTo(
          size.width / 2, size.height * 0.4, size.width, size.height * 0.25)
      ..relativeLineTo(0, -size.height * 0.25)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
