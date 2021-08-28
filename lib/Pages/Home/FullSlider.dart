import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/Sliders.dart';
import 'package:sms_wallet/Models/Urls.dart';

class HomeSlider extends StatefulWidget {
  final List <Sliders> lstSlider;
  HomeSlider({Key key, @required this.lstSlider}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomeSliderState();
  }
}

class _HomeSliderState extends State<HomeSlider> {
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
    Sliders sliderObj;
    imageList.clear();
    
        List<Sliders> ban = [];
        for (var i = 0; i < widget.lstSlider.length; i++) {
          ban.add(widget.lstSlider[i]);
            sliderObj=widget.lstSlider[i];
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
