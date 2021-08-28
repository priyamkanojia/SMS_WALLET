import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Models/BannerSlider.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/Sliders.dart';
import 'package:sms_wallet/Models/Urls.dart';

class BannerSlider extends StatefulWidget {
  final List <BannerSliders> lstBannerSlider;
  BannerSlider({Key key, @required this.lstBannerSlider}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BannerSliderState();
  }
}

class _BannerSliderState extends State<BannerSlider> {
  List<String> imageList=[];
  @override
  void initState() {
    super.initState();
  }
  bool _saving = false;

  void submit() {
    setState(() {
      _saving = true;
    });
  }

  Widget progress() {
    return Center(
      child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(MyColors.darkred)),
    );
  }

  @override
  Widget build(BuildContext context) {
    BannerSliders sliderObj;
    imageList.clear();

    List<BannerSliders> ban = [];
    for (var i = 0; i < widget.lstBannerSlider.length; i++) {
      ban.add(widget.lstBannerSlider[i]);
      sliderObj=widget.lstBannerSlider[i];
    }
    for (var i = 0; i < ban.length; i++) {
      imageList.add(Urls.image_urls + ban[i].image);

    }
    return GFCarousel(
      pagination: true,
      pauseAutoPlayOnTouch: const Duration(milliseconds: 10000),
      autoPlay: true,
      autoPlayInterval: const Duration(milliseconds: 5000),
      viewportFraction: 1.0,
      enlargeMainPage: true,
      aspectRatio:2,
      //height: 100.0,
      items: imageList.map(
            (url) {
          return ModalProgressHUD(
            inAsyncCall: _saving,
            progressIndicator: progress(),
            child: Container(
              //height: 60,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: InkWell(
                onTap: () async {

                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(url,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width),
                ),
              ),
            ),
          );
        },
      ).toList(),
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
}
