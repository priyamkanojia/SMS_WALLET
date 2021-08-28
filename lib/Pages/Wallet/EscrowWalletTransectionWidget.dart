import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_wallet/Controllers/WalletController.dart';
import 'package:sms_wallet/Models/EscrowWalletTransections.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/ShoppingWalletTransection.dart';

class EcrowWalletTransectionHistoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EcrowWalletTransectionHistoryWidgetState();
  }
}

Future<List<EscrowWalletTransection>> lstEscrowWalletTransection;

class EcrowWalletTransectionHistoryWidgetState extends State<EcrowWalletTransectionHistoryWidget> {
  TextEditingController searchCon = new TextEditingController();

  @override
  void initState() {
    lstEscrowWalletTransection= WalletController.getEscrowWalletTransectionHistory();

    super.initState();
  }

  void setSt() {
    setState(() {
      lstEscrowWalletTransection = WalletController.getEscrowWalletTransectionHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: Colors.white, size: 22),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: MyColors.darkBlue,
          elevation: 0,
          title: Text(
            "Escrow Wallet History",
            style: Theme.of(context).textTheme.headline6.apply(
                fontWeightDelta: 30, fontSizeFactor: 0.9, color: Colors.white),
          )),
      body: FutureBuilder<List<EscrowWalletTransection>>(
          future: lstEscrowWalletTransection,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 12, bottom: 60),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < snapshot.data.length)
                            return Container(
                                child: Column(
                              children: [
                                ((snapshot.data[index].dateTime != null) &&
                                        (index == 0 ||
                                            snapshot.data[index].dateTime
                                                    .substring(0, 10) !=
                                                snapshot
                                                    .data[index - 1].dateTime
                                                    .substring(0, 10)))
                                    ? Container(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 12, 16, 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Date : ",
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .apply(
                                                      fontSizeFactor: 0.8,
                                                      color: Colors.grey[600],
                                                    )
                                                    .merge(TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            Text(
                                                (snapshot.data[index].dateTime
                                                    .substring(0, 10)),
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .apply(
                                                        fontSizeFactor: 0.8,
                                                        color: Colors.black)),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                historyTile(snapshot.data[index]),
                              ],
                            ));
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text("No History Found."));
              }
            } else {
              return Center(
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(MyColors.darkBlue)),
                  ),
                ),
              );
            }
          }),
    );
  }

  InkWell historyTile(EscrowWalletTransection item) {
    return InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(0.5, 0.5),
                          blurRadius: 5,
                          spreadRadius: 0.3)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Time :  ",
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .apply(
                                        fontSizeFactor: 0.7,
                                        color: Colors.grey[600],
                                      )
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Text((item.dateTime.substring(11, 19)),
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .apply(
                                          fontWeightDelta: 30,
                                          fontSizeFactor: 0.7,
                                          color: Colors.black)),
                            ],
                          ),
                          Text(item.status,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .apply(
                                          fontWeightDelta: 30,
                                          fontSizeFactor: 0.8,
                                          color: Colors.grey)),
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    // Divider(height: 1.0, color: Colors.grey[500]),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.senderId,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .apply(
                                                  fontSizeFactor: 0.8,
                                                  fontWeightDelta: 30,
                                                  color: MyColors.darkBlue)),

                                                  Container(
                                                    width: MediaQuery.of(context).size.width-60,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("Amount: "+item.amount,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .apply(
                                                        fontSizeFactor: 0.8,
                                                        fontWeightDelta: 30,
                                                        color: MyColors.darkBlue)),
                                                        Text(item.transactionId,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .apply(
                                              fontSizeFactor: 0.8,
                                              fontWeightDelta: 30,
                                              color: Colors.grey[700])),
                                                      ],
                                                    ),
                                                  ),

                                                  
                                    ],
                                  ),
                                  
                                ],
                              ),
                                                                                Text("Note : "+item.note,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .apply(
                                                  fontSizeFactor: 0.8,
                                                  fontWeightDelta: 30,
                                                  color: MyColors.darkBlue)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ));
  }
}
