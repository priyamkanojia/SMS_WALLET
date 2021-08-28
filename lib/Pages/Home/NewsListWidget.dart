import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/News.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Pages/Drawer/html_view.dart';
import 'package:sms_wallet/Pages/Home/NoticeWidget.dart';

import '../../ad_state.dart';

class NewsListWidget extends StatefulWidget {
  List<News> lstMessages;
  NewsListWidget({@required this.lstMessages});
  @override
  State<StatefulWidget> createState() {
    return NewsListWidgetState();
  }
}

class NewsListWidgetState extends State<NewsListWidget> {
  TextEditingController searchCon = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: MyColors.darkBlue,
            elevation: 0,
            title: Text(
              "News",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
        body: Container(
            decoration: BoxDecoration(),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListView(
              padding: EdgeInsets.only(top: 16),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _product(widget.lstMessages),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    ShowBannerAdd(),
                  ],
                ),
              ],
            )));
  }

  Widget _product(List<News> item) {
    List<Widget> lstW = [];
    int lim = 1;
// if(item.length<=3)
    lim = item.length;
// else
// lim=3;
    for (var i = 0; i < lim; i++) {
      lstW.add(InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewsDetailWidget(mMessages: item[i])));
          },
          child: Container(
              // margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width / 7,
                        width: MediaQuery.of(context).size.width / 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: item[i].image != null
                                  ? NetworkImage(
                                      Urls.image_urls + item[i].image)
                                  : AssetImage("assets/logo.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Wrap(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text((item[i].title),
                                // maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .apply(
                                      fontSizeFactor: 0.75,
                                      color: Colors.black,
                                    )
                                    .merge(TextStyle(
                                        fontWeight: FontWeight.bold))),
                            // SizedBox(
                            //   height:2,
                            // ),
                            // SizedBox(
                            //     height:27.0,
                            //     width: MediaQuery.of(context).size.width,
                            //     child: Center(child: NewHtmlView(content:item[i].description))),
                            HtmlViewShort(content: item[i].description),
                            // Text((item[i].description),
                            //     // maxLines: 2,
                            //     overflow: TextOverflow.ellipsis,
                            //     textAlign: TextAlign.justify,
                            //     style: Theme.of(context).textTheme.subtitle1.apply(fontSizeFactor: 0.65, color: Colors.grey,).merge(TextStyle(fontWeight: FontWeight.bold,)))
                            //SizedBox(height:),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 16,
                      // ),
                      Container(
                        width: 24,
                        height: 24,
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      NewsDetailWidget(mMessages: item[i])));
                            },
                            child: Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.grey)),
                      )
                    ],
                  ),
                ],
              ))));
      if (i + 1 != lim) {
        lstW.add(Divider(
          color: Colors.grey.withOpacity(0.5),
          thickness: 1.0,
        ));
      }
    }
    return Column(children: lstW);
  }
}
