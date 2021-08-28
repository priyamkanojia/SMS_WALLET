import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:sms_wallet/Controllers/ChatController.dart';
import 'package:sms_wallet/Models/Chat.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';

class GroupChatWidget extends StatefulWidget {
  // Restaurents restaurent;
  GroupChatWidget({
    Key key,
    // @required this.restaurent,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return GroupChatWidgetState();
  }
}

class GroupChatWidgetState extends State<GroupChatWidget> {
  TextEditingController messageController = new TextEditingController();

  bool _saving = false;
  Future<List<Chat>> chats;
  bool allFetched;
  int page = 0;
  List<Chat> items = [];
  List<String> selectedChat = [];

  bool isLoading = false;
  Future<List<Chat>> _loadData() async {
    List<Chat> lstChat = [];
    var response =
        await http.get(Uri.parse(Urls.base_url + "chat_group"), headers: {
      'api-token': UserDetails.apiToken,
      'start': page.toString(),
      'limit': '3',
    });
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      lstChat = jsonResponse.map((e) => Chat.fromJson(e)).toList();
    }

    print("load more");
    setState(() {
      allFetched = lstChat.length == 0 ? true : false;
      for (var i = 0; i < lstChat.length; i++) {
        // if (!items.contains(lstChat[i])) {
        items.add(lstChat[i]);
        // }
      }
      isLoading = false;
      // page++;
    });
    return items;
  }

  String defaultType;
  ScrollController controller;
  void submit() {
    setState(() {
      _saving = true;
    });
  }

  @override
  void initState() {
    super.initState();
    chats = _loadData();
  }

  Widget progress() {
    return Center(
      child: SpinKitThreeBounce(
        color: MyColors.darkBlue,
        size: 32,
      ),
    );
  }

  Future<List<Chat>> _loadNextData(String dateTimeStamp) async {
    List<Chat> lstChat = [];
    var response = await http.get(
        Uri.parse(Urls.base_url + "chat/bycustomer/" + dateTimeStamp),
        headers: {"api-token": UserDetails.apiToken});
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      lstChat = jsonResponse.map((e) => Chat.fromJson(e)).toList();
    }
    List<Chat> lstChatTemp = [];
    lstChatTemp.addAll(items);
    print("load more");
    setState(() {
      items.clear();

      for (var i = 0; i < lstChat.length; i++) {
        items.add(lstChat[i]);
      }
      items.addAll(lstChatTemp);
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.darkBlue.withOpacity(0.2),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: MyColors.darkBlue.withOpacity(0.8),
          title: Container(
              // color: MyColors.darkBlue.withOpacity(0.8),
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.1 + 10,
              child: Row(
                children: [
                  Container(
                    // padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                    // width: MediaQuery.of(context).size.width - 52,
                    child: Text("Group Chat",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline6.apply(
                              color: Colors.white,
                              fontWeightDelta: 30,
                              fontSizeFactor: 1.0,
                            )),
                  ),
                ],
              )),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            // image: DecorationImage(
            //     image: AssetImage("assets/backgroundall.png"),
            //     fit: BoxFit.cover),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: MyColors.darkBlue.withOpacity(0.2),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.9 - 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          isLoading
                              ? Container(
                                  height: 60,
                                  // width: 60,
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: SpinKitThreeBounce(
                                      color: MyColors.darkBlue,
                                      size: 32,
                                    ),
                                  ),
                                )
                              : Container(),
                          Expanded(
                            child: FutureBuilder<List<Chat>>(
                                future: chats,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (items.length > 0) {
                                      _loadNextData(items[0].created);
                                      return Column(
                                        children: [
                                          Expanded(
                                            child: NotificationListener<
                                                ScrollNotification>(
                                              onNotification:
                                                  (ScrollNotification
                                                      scrollInfo) {
                                                if (!isLoading &&
                                                    scrollInfo.metrics.pixels ==
                                                        scrollInfo.metrics
                                                            .maxScrollExtent &&
                                                    !allFetched) {
                                                  setState(() {
                                                    page++;
                                                  });
                                                  _loadData();
                                                  // start loading data
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                }
                                              },
                                              child: ListView.builder(
                                                reverse: true,
                                                padding: EdgeInsets.only(
                                                    bottom: 0, top: 20),
                                                itemCount: items.length,
                                                itemBuilder: (context, index) {
                                                  if (index == items.length - 1)
                                                    return chatsTile(
                                                        items[index]);
                                                  else
                                                    return chatsTile(
                                                        items[index],
                                                        previous:
                                                            items[index + 1]);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return Container();
                                  }
                                  return Center(
                                    child: SpinKitThreeBounce(
                                      color: MyColors.darkBlue,
                                      size: 32,
                                    ),
                                  );
                                }),
                          ),
                          Container(
                            // height: 70,
                            padding: EdgeInsets.all(10),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width - 64,
                                  margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1.5, color: Colors.grey[400]),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.newline,
                                    maxLines: 3,
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Write Here...',
                                    ),
                                  ),
                                ),
                                !_saving
                                    ? Container(
                                        child: InkWell(
                                            onTap: () {
                                              if (messageController
                                                      .text.isEmpty ||
                                                  messageController.text
                                                          .trim() ==
                                                      "") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please Write Something!",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 3,
                                                    backgroundColor:
                                                        Colors.grey[900],
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else {
                                                String message =
                                                    messageController.text
                                                        .trim();
                                                setState(() {
                                                  messageController.clear();
                                                });
                                                submit();
                                                String timestamp =
                                                    DateTime.now()
                                                        .millisecondsSinceEpoch
                                                        .toString();
                                                ChatController.chatPost(
                                                  UserDetails.id,
                                                  message,
                                                ).then((value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      List<Chat> lstChat = [];
                                                      lstChat.add(value);
                                                      lstChat.addAll(items);
                                                      items.clear();
                                                      items.addAll(lstChat);
                                                      _saving = false;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _saving = false;
                                                    });
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Server Error. Try After Sometime!",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 3,
                                                        backgroundColor:
                                                            Colors.grey[900],
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                  }
                                                });
                                              }
                                            },
                                            child: Icon(
                                              Icons.send,
                                              color: MyColors.darkBlue,
                                              size: 28,
                                            )))
                                    : Container(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    MyColors.darkBlue)),
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget chatsTile(Chat item, {Chat previous}) {
    String time = item.created;
    // DateTime.fromMillisecondsSinceEpoch(int.parse(item.dateTimeStamp))
    //     .toString()
    //     .substring(0, 19);

    return Column(
      children: [
        previous == null ||
                item.created.toString().substring(0, 10) !=
                    item.created.toString().substring(0, 10)
            ? Container(
                // width: MediaQuery.of(context).size.width,
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 1,
                              spreadRadius: 1)
                        ],
                        color: MyColors.darkBlue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(item.created.toString().substring(0, 10) !=
                            DateTime.now().toString().substring(0, 10)
                        ? item.created.toString().substring(0, 10)
                        : "Today")),
              )
            : Container(),
        Container(
            // color: Colors.black,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Container(
              // width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                  mainAxisAlignment: item.userId == UserDetails.id
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: item.userId == UserDetails.id
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                minWidth: 0,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.8),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                      item.userId == UserDetails.id ? 0 : 30.0),
                                  bottomRight: Radius.circular(
                                      item.userId == UserDetails.id
                                          ? 20
                                          : 30.0),
                                  topLeft: Radius.circular(
                                      item.userId == UserDetails.id ? 30.0 : 0),
                                  bottomLeft: Radius.circular(
                                      item.userId == UserDetails.id
                                          ? 30.0
                                          : 20)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[500],
                                    blurRadius: 1,
                                    spreadRadius: 1)
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: item.userId == UserDetails.id
                                    ? MyColors.darkBlue.withOpacity(0.8)
                                    : Colors.white,
                                // border: Border.all(
                                //     width: 1,
                                //     color: item.userId == UserDetails.id
                                //         ? MyColors.darkBlue
                                //         : MyColors.lightBlue),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        item.userId == UserDetails.id
                                            ? 0
                                            : 30.0),
                                    bottomRight: Radius.circular(
                                        item.userId == UserDetails.id
                                            ? 20
                                            : 30.0),
                                    topLeft: Radius.circular(
                                        item.userId == UserDetails.id
                                            ? 30.0
                                            : 0),
                                    bottomLeft: Radius.circular(
                                        item.userId == UserDetails.id
                                            ? 30.0
                                            : 20)),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    item.userId == UserDetails.id
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: item.userId == UserDetails.id
                                        ? EdgeInsets.fromLTRB(20, 6, 8, 0)
                                        : EdgeInsets.fromLTRB(8, 6, 20, 0),

                                    // width: MediaQuery.of(context).size.width * 0.12,
                                    child: Container(
                                      child: Text(
                                          item.userId == UserDetails.id
                                              ? "You"
                                              : item.fullname,
                                          // maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .apply(
                                                fontSizeFactor: 0.6,
                                                fontWeightDelta: 30,
                                                color: item.userId ==
                                                        UserDetails.id
                                                    ? Colors.yellow[400]
                                                    : Colors.purple,
                                              )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
                                    child: Text((item.msg),
                                        // maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .apply(
                                              fontSizeFactor: 0.9,
                                              color:
                                                  item.userId == UserDetails.id
                                                      ? Colors.white
                                                      : Colors.black,
                                            )),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                    width: 90,
                                    child: Row(
                                        mainAxisAlignment:
                                            item.userId == UserDetails.id
                                                ? MainAxisAlignment.end
                                                : MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: item.userId == UserDetails.id
                                                ? Colors.grey[300]
                                                : Colors.grey,
                                            size: 10,
                                          ),
                                          Text(
                                              (" " +
                                                  DateFormat.jm().format(
                                                      DateTime.parse(time)) +
                                                  " "),
                                              // maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .apply(
                                                    fontSizeFactor: 0.5,
                                                    color: item.userId ==
                                                            UserDetails.id
                                                        ? Colors.grey[300]
                                                        : Colors.grey,
                                                  )),
                                          item.userId == UserDetails.id
                                              ? Icon(
                                                  Icons.done,
                                                  color: Colors.grey[300],
                                                  size: 10,
                                                )
                                              : Container()
                                        ]),
                                  )
                                ],
                              ),
                            ),
                            // ),
                          ),
                        ],
                      ),
                    )
                  ]),
            )),
      ],
    );
  }
}
