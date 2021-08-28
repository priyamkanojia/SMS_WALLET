import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:sms_wallet/Pages/Intro/IntroHomeWidget.dart';

class NativeAd extends StatefulWidget {
  @override
  _NativeAdState createState() => _NativeAdState();
}
class _NativeAdState extends State<NativeAd>{
  @override
  //bool get wantKeepAlive => true;

  final _controller = NativeAdmobController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NativeAdmob(
        adUnitID: 'ca-app-pub-7242573760856221/6928716021',
        loading: Center(child: CircularProgressIndicator()),
        error: Text('Failed to load'),
        numberAds: 1,
        controller: _controller,
        type: NativeAdmobType.full,
        options: NativeAdmobOptions(),
      ),
    );
  }
}