import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/News.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Pages/Drawer/HtmlWidget.dart';
import 'package:sms_wallet/Pages/Drawer/html_view.dart';

class NewsDetailWidget extends StatefulWidget {
  News mMessages;
  NewsDetailWidget({@required this.mMessages});
  @override
  State<StatefulWidget> createState() {
    return NewsDetailWidgetState();
  }
}

Future<List<News>> lstNotifications;

class NewsDetailWidgetState extends State<NewsDetailWidget> {
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 12, bottom: 60),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                if (index < 1)
                  return Container(child: _product(widget.mMessages));
              },
            ),
          ),
        ],
      ),
    );
  }

  InkWell _product(News item) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date : ",
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .apply(
                                    fontSizeFactor: 0.8,
                                    color: Colors.grey,
                                  )
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Text(
                              (formatDate(DateTime.parse(item.createdAt),
                                  [dd, ' ', M, ' ', yyyy])),
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .apply(
                                    fontSizeFactor: 0.8,
                                    color: Colors.grey,
                                  )
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Time : ",
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .apply(
                                    fontSizeFactor: 0.8,
                                    color: Colors.grey,
                                  )
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Text(
                              DateFormat.jm()
                                  .format(DateTime.parse(item.createdAt)),
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .apply(
                                    fontSizeFactor: 0.8,
                                    color: Colors.grey,
                                  )
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ]),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: MyColors.darkBlue.withOpacity(0.6),
                      image: DecorationImage(
                          image: item.image != null
                              ? NetworkImage(Urls.image_urls + item.image)
                              : AssetImage("assets/logo.png"),
                              fit: BoxFit.cover
                              )),
                ),
                SizedBox(
                  height: 16,
                ),
                // Divider(height: 1.0, color: Colors.grey[500]),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((item.title),
                              // maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue)),
                          SizedBox(
                            height: 10,
                          ),
                          NewHtmlView(content: item.description),
                          // Text(item.description,
                          //     // maxLines: 1,
                          //     textAlign: TextAlign.justify,style: Theme.of(context).textTheme.subtitle1.apply(fontSizeFactor: 0.8,color: Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )));
  }
}
