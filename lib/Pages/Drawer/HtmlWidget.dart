import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Models/AppSettings.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/Pages.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ad_state.dart';

class HtmlWidget extends StatefulWidget {
  Pages pages;
  HtmlWidget({Key key, @required this.pages}) : super(key: key);

  @override
  _HtmlWidgetState createState() => _HtmlWidgetState();
}

class _HtmlWidgetState extends State<HtmlWidget> {
//var htmlData = r""" """;
var htmlData;
  @override
  void initState() {
   htmlData= widget.pages.description;
    super.initState();
  }
void _launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size:22),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: MyColors.darkBlue,
        elevation: 0.0,
        title: Text(
          widget.pages.pageName,
          style: Theme.of(context)
              .textTheme
              .headline6
              .apply(fontWeightDelta: 30, fontSizeFactor: 0.9, color:Colors.white),
        ),
        actions: [],
      ),
      bottomNavigationBar: ShowBannerAdd(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Html(
          data: htmlData,
          style: {
            "table": Style(
              backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
            ),
            "tr": Style(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            "th": Style(
              padding: EdgeInsets.all(6),
              backgroundColor: Colors.grey,
            ),
            "td": Style(
              padding: EdgeInsets.all(6),
              alignment: Alignment.topLeft,
            ),
            'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
          },
          customRender: {
            "table": (context, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    (context.tree as TableLayoutElement).toWidget(context),
              );
            },
            "bird": (RenderContext context, Widget child) {
              return TextSpan(text: "🐦");
            },
            
          },
         
          onLinkTap: (url, _, __, ___) {
            _launchURL(url);
            print("Opening $url...");
          },
          onImageTap: (src, _, __, ___) {
            print(src);
          },
          onImageError: (exception, stackTrace) {
            print(exception);
          },
        ),
        ),
      ),
    );
  }
}
