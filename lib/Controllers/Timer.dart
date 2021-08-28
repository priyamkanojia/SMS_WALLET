import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sms_wallet/Models/MyColors.dart';
DateTime endTimeSharedPref =DateTime.now() ;
/*class Count_Timer {
  String timer_status = null ;
  startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var api_token = prefs.getString('api_token');
    var id = prefs.getString('id');
    var response = await http.post(
      Uri.parse('https://wallet.jainalufoils.com/api/start_timer'),
      headers: <String, String>{
        'api-token':api_token,
      },
      body:<String, String>{
        'user_id':id,
      },
    );
    if(response.statusCode==200){
      print(response.body);
      var timerStatus =  await http.get(Uri.parse('https://wallet.jainalufoils.com/api/timer_status/$id'),
          headers:{
            'api-token':api_token,
          });
      if(timerStatus.statusCode == 200){
        print(timerStatus.body);
        timer_status = jsonDecode(timerStatus.body)['status'];//status
        String expireDateTime=jsonDecode(timerStatus.body)['expire'];//expire
        print('ExpireDateTime: $expireDateTime');
        prefs.setString('ExpireTime',expireDateTime);
        //print(prefs.get('ExpireTime'));
      }
      else{
        print('Timer Status :${timerStatus.statusCode}');
      }
    }else{
      print('Response : ${response.statusCode}');
    }
  }

  triggerTimerApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int hr = DateTime.now().hour;
    int min = DateTime.now().minute;
    int sec = DateTime.now().second;
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;

    int exphr = endTimeSharedPref.hour;
    int expmin =endTimeSharedPref.minute;
    int expsec =endTimeSharedPref.second;
    int expday =endTimeSharedPref.day;
    int expmonth =endTimeSharedPref.month;
    int expyear = endTimeSharedPref.year;

    if(month < expmonth || day<expday || year < expyear){
      if(hr>exphr || (day>=expday && hr == exphr && min > expmin) ||
          (hr == exphr && min == expmin && sec >expsec)){
        print('curr : $day+$hr+$min+$sec , Exp: $expday+$exphr+$expmin+$expsec');
        print("trigger");
        startTimer();
        CountDownTimer();
      }
      // if(day>=expday && hr>=exphr && min>=expmin){
      //   prefs.remove('ExpireTime');
      // }
      else{
        print("not trigger");
        print('curr : $day+$hr+$min+$sec , Exp: $expday+$exphr+$expmin+$expsec');
      }
    }
  }
}*/

getSharedPrefTimer() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefEndTime = prefs.getString('ExpireTime');
    endTimeSharedPref = DateTime.parse(prefEndTime);
  print('Pref Timer: $endTimeSharedPref');
  return endTimeSharedPref;
}
removeSharedPrefData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('ExpireTime');
    //endTimer=null;
}

class TriggerTimer extends StatefulWidget {
  @override
  _TriggerTimerState createState() => _TriggerTimerState();
}
class _TriggerTimerState extends State<TriggerTimer> {

  @override
  void initState() {
    getSharedPrefTimer();
    triggerTimerApi();
    //Timer.periodic(Duration (seconds:2), (timer) {getSharedPrefTimer();});
    //startTimer();
    super.initState();
  }

  String timer_status;

  startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var api_token = prefs.getString('api_token');
    var id = prefs.getString('id');
    var response = await http.post(
      Uri.parse('https://wallet.jainalufoils.com/api/start_timer'),
      headers: <String, String>{
        'api-token': api_token,
      },
      body: <String, String>{
        'user_id': id,
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      var timerStatus = await http.get(Uri.parse('https://wallet.jainalufoils.com/api/timer_status/$id'),
          headers: {
            'api-token': api_token,
          });
      if (timerStatus.statusCode == 200) {
        print(timerStatus.body);
        setState(() {
          timer_status = jsonDecode(timerStatus.body)['status']; //status
          String expireDateTime = jsonDecode(timerStatus.body)['expire']; //expire
          print('ExpireDateTime: $expireDateTime');
          prefs.setString('ExpireTime', expireDateTime);
        });
      }
      else {
        print('Timer Status :${timerStatus.statusCode}');
      }
    } else {
      print('Response : ${response.statusCode}');
    }
  }

  // getSharedPrefExpTime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String getExpiretime = prefs.getString('ExpireTime');
  //   setState(() {
  //     expiretime = DateTime.parse(getExpiretime);
  //   });
  //   print('Exp Pref Time: $expiretime');
  //   return expiretime;
  // }

  triggerTimerApi() {
    print('Trigger Timer Started');
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    int hr = DateTime.now().hour;
    int min = DateTime.now().minute;
    int sec = DateTime.now().second;
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;

    print('endTimeSharedPref : $endTimeSharedPref');

    int exphr = endTimeSharedPref.hour;
    int expmin = endTimeSharedPref.minute;
    int expsec = endTimeSharedPref.second;
    int expday = endTimeSharedPref.day;
    int expmonth = endTimeSharedPref.month;
    int expyear = endTimeSharedPref.year;

    if (month < expmonth || day <= expday || year < expyear) {
      if (hr > exphr || (day >= expday && hr == exphr && min > expmin) ||
          (hr == exphr && min == expmin && sec > expsec)) {
        print(
            'curr : $day+$hr+$min+$sec , Exp: $expday+$exphr+$expmin+$expsec');
        print("trigger");
        startTimer();
        CountDownTimer();
      }
      // if(day>=expday && hr>=exphr && min>=expmin){
      //   print('Shared Pref EndTime Removed');
      //   removeSharedPrefData();
      // }
      else {
        print("not trigger");
        print(
            'curr : $day+$hr+$min+$sec , Exp: $expday+$exphr+$expmin+$expsec');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.0,
      width: 42.0,
      margin: EdgeInsets.only(bottom: 60.0),
      child: Visibility(
        //visible: visible,
        child: FloatingActionButton(
          hoverColor: Colors.black,
          elevation: 10,
          onPressed: (){
            print('Expire Time : $endTimeSharedPref');
            print('Button Pressed');
            triggerTimerApi();
            getSharedPrefTimer();
          },
          backgroundColor: MyColors.darkBlue,
          //clickOnTimer.timer_status == null? Colors.red:Colors.green,
          child: Icon(Icons.attach_money, color: Colors.white, size: 30.0,),
        ),
      ),
    );
  }
}

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> with TickerProviderStateMixin {
  AnimationController controller;
  DateTime currentDateTime = DateTime.now();
  Duration timeDiff;
  //String timeDiffFormat;
  String get timerString {
    Duration duration = timeDiff;
    return '${duration.inHours.toString()}h ${((duration.inMinutes)%60).toString()}m ${(duration.inSeconds%60).toString()}s';
  }
  @override
  void initState(){
    getSharedPrefTimer();
    timerDifference();
    super.initState();
    timerString;
    controller = AnimationController(
      vsync: this,
      duration: timeDiff,
    );
    counterOnTap();
    Timer.periodic(Duration(seconds:1), (timer) {timerDifference();});
    Timer.periodic(Duration(minutes:1), (timer) {timerString;});
  }
  void counterOnTap(){
    print('on tap');
    if (controller.isAnimating){
      //timerDifference();
      //controller.stop();
    }
    else {
      //controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    }
  }

  timerDifference(){
    if(endTimeSharedPref.difference(DateTime.now()) < Duration(hours: 0,minutes: 0,seconds: 0)){
      setState(() {
      timeDiff = Duration(hours: 0,minutes: 0,seconds: 0);
    });
    //print('IfTimeDiff');
    print('timeDiff: $timeDiff');
    //print('EndTimeSharedPrefTD: $endTimeSharedPref');
    return timeDiff;
    }
    else{
      setState(() {
        timeDiff = endTimeSharedPref.difference(DateTime.now());
      });
    print('ElseTimeDiff');
    print('TimeDiff: $timeDiff');
    print('EndTimeSharedPrefTD: $endTimeSharedPref');
    return timeDiff;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Text(
                timerString,
              );
            })
    );
  }
}
