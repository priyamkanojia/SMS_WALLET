import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class GetRewardsData extends StatefulWidget {
  @override
  _GetRewardsDataState createState() => _GetRewardsDataState();
}

class _GetRewardsDataState extends State<GetRewardsData> {

  Timer interval;
  String walletRewards;
  getrewards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var api_token = prefs.getString('api_token');
    var id = prefs.getString('id');
    //print(api_token);
    var response =  await http.get(Uri.parse('https://wallet.jainalufoils.com/api/mywallet/$id'),
        headers:{
          'api-token':api_token,
        });
    if(response.statusCode == 200){
      //print(response.body);
      //wallet_reward
      setState((){
        walletRewards = jsonDecode(response.body)['wallet_reward'];
        //print(walletRewards);
      });
    }
    else
      print(response.statusCode);
  }
  @override
  void initState(){
    getrewards();
    interval = Timer.periodic(Duration(seconds:30), (timer)=>getrewards());
    super.initState();
  }
  @override
  void dispose(){
    interval.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(walletRewards,style: Theme.of(context).textTheme.headline6.apply(fontSizeFactor: 0.9, color: Colors.white,fontWeightDelta: 30)));
  }
}