import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sms_wallet/Controllers/WalletController.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Pages/Home/MoneyTransferContactsWidget.dart';

class SendMoneyWidget extends StatefulWidget {
  void Function() filtering;
  String user_id;
  MyContacts myContacts;
  SendMoneyWidget(
      {@required this.filtering,
      @required this.user_id,
      @required this.myContacts});
  @override
  State<StatefulWidget> createState() {
    return SendMoneyWidgetState();
  }
}

class SendMoneyWidgetState extends State<SendMoneyWidget> {
  bool _saving = false;
  void submit() {
    setState(() {
      _saving = true;
    });
  }
bool moneySent;
  TextEditingController amountController = new TextEditingController();
  @override
  void initState() {
    moneySent = false;
    amountController.clear();
    super.initState();
  }

  Widget progress() {
    return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        progressIndicator: progress(),
        child: Container(
          // height: 80,

          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: !moneySent?Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  // width: MediaQuery.of(context)
                  //         .size
                  //         .width,
                  margin: EdgeInsets.fromLTRB(0, 24, 0, 12),
                  padding: EdgeInsets.fromLTRB(24, 5, 24, 5),
                  decoration: BoxDecoration(
                      color: MyColors.lightBlue.withOpacity(0.5),
                      // border: Border.all(width:2, color:MyColors.darkBlue.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Send Money To",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6.apply(
                          fontSizeFactor: 1.0,
                          fontWeightDelta: 30,
                          color: MyColors.darkBlue))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.myContacts.image,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  child: Text(widget.myContacts.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6.apply(
                          fontSizeFactor: 0.8,
                          fontWeightDelta: 30,
                          color: Colors.black))),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  child: Text(widget.myContacts.phone,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6.apply(
                          fontSizeFactor: 0.6,
                          fontWeightDelta: 30,
                          color: Colors.grey[700]))),
              SizedBox(height: 16),
             !_saving? Column(
               
                children: [
                  Container(
                    height: 45,
                    padding: EdgeInsets.only(top: 10, left: 10),
                    margin: EdgeInsets.fromLTRB(80, 0, 80, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            // maxLength: 6,
                            controller: amountController,
                            decoration: InputDecoration(
                              isDense: true,
                              counter: Offstage(),
                              border: InputBorder.none,
                              hintText: 'Enter Amount',
                              hintStyle: TextStyle(fontSize: 12),
                              helperStyle: TextStyle(fontSize: 12),
                              labelStyle: TextStyle(fontSize: 12),
                              counterStyle: TextStyle(fontSize: 12),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent[700],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(8),
                      child: InkWell(
                          onTap: () {
                            submit();

                            if (amountController.text.isEmpty ||
                                amountController.text.trim() == "") {
                              setState(() {
                                _saving = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "Enter Amount !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.grey[900],
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              WalletController.moneyTransferContact(
                                      widget.user_id,
                                      widget.myContacts.phone,
                                      amountController.text.trim())
                                  .then((value) {
                                if (value != null && value.statusCode == 200) {
                                  setState(() {
                                    _saving = false;
                                    moneySent = true;
                                    widget.filtering();
                                  });
                                  Fluttertoast.showToast(
                                      msg: jsonDecode(utf8
                                          .decode(value.bodyBytes))['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.grey[900],
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else if (value != null) {
                                  setState(() {
                                    _saving = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: jsonDecode(utf8
                                          .decode(value.bodyBytes))['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.grey[900],
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  setState(() {
                                    _saving = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg:
                                          "Something Went Wrong, Please Try After Sometime",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.grey[900],
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Send" + "  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .apply(
                                          fontSizeFactor: 0.9,
                                          fontWeightDelta: 30,
                                          color: Colors.white)),
                               Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                            ],
                          ))),
                ],
              ):
              Column(
                children: [
                  Container(
                          
                          width: MediaQuery.of(context).size.width,
                          child: SpinKitThreeBounce(
                            color: MyColors.darkBlue,
                            size: 32,
                          )),
                          SizedBox(height: 16)
                          ,Text("Processing....",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .apply(
                                          fontSizeFactor: 0.7,
                                          color: Colors.black)),


                ],
              )
              ,
            ],
          ): Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  // width: MediaQuery.of(context)
                  //         .size
                  //         .width,
                  margin: EdgeInsets.fromLTRB(0, 24, 0, 12),
                  padding: EdgeInsets.fromLTRB(24, 5, 24, 5),
                  decoration: BoxDecoration(
                      // color: MyColors.lightBlue.withOpacity(0.5),
                      // border: Border.all(width:2, color:MyColors.darkBlue.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Money Sent To",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6.apply(
                          fontSizeFactor: 1.2,
                          fontWeightDelta: 30,
                          color: MyColors.darkBlue))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.myContacts.image,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  child: Text(widget.myContacts.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6.apply(
                          fontSizeFactor: 0.8,
                          fontWeightDelta: 30,
                          color: Colors.black))),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  child: Text(widget.myContacts.phone,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6.apply(
                          fontSizeFactor: 0.6,
                          fontWeightDelta: 30,
                          color: Colors.grey[700]))),
              SizedBox(height: 16),
             
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                      color: Colors.greenAccent[700],
                      // border: Border.all(width:2, color:MyColors.darkBlue.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(100)),
                          child: Icon(Icons.done, color: Colors.white,size: 60,)),
                          SizedBox(height: 24)
                          ,Text("Amount : "+amountController.text+"\nSent Successfully.",
                          textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .apply(
                                          fontSizeFactor: 0.8,
                                          fontWeightDelta: 30,
                                          color: Colors.black)),


                ],
              )
              ,
            ],
          ),
        ),
      ),
    );
  }
}
