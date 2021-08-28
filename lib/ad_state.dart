import 'dart:io';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class AdState{
  Future<InitializationStatus> initialzation ;
  AdState(this.initialzation);

  //String get bannerAddUnitId => Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716';


  BannerAdListener get adListner => _adListener;
  BannerAdListener _adListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
}

class ShowBannerAdd extends StatefulWidget {
  @override
  _ShowBannerAddState createState() => _ShowBannerAddState();
}

class _ShowBannerAddState extends State<ShowBannerAdd> {
  BannerAd banner;
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialzation.then((status){
      setState(() {
        //for (int i =0 ; i<1000; i++){
          banner = BannerAd(size: AdSize.banner, adUnitId:'ca-app-pub-7242573760856221/2710462935',/*adState.bannerAddUnitId*/ listener:adState._adListener, request:AdRequest())..load();
        //};
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (banner == null){
      return SizedBox(height: 60,);
    }else{
      return Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        child: AdWidget(ad: banner),
      );
    }
  }
}