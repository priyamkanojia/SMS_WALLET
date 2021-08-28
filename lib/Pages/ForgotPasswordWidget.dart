import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sms_wallet/Controllers/LoginController.dart';
import 'package:sms_wallet/Models/MyColors.dart';

class ForgotPasswordWidget extends StatefulWidget {
  // Function refreshHome;
  ForgotPasswordWidget({
    Key key,
    // @required this.refreshHome,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordWidgetState();
  }
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  bool viewEnable,view2Enable;
  // bool loading = false;
  @override
  void initState() {
    viewEnable = false;
        view2Enable = false;

    otpSent = false;

    super.initState();
  }

  bool _saving = false;
  void submit() {
    setState(() {
      _saving = true;
    });
  }

  bool otpSent;
  final TextEditingController _smsController = TextEditingController();

    final TextEditingController password1Controller = TextEditingController();

  final TextEditingController password2Controller = TextEditingController();

  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      progressIndicator: Container(),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
                      child: Container(
                                height: MediaQuery.of(context).size.height,

                        child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: MyColors.darkBlue,
                        ),
                        child: Column(children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 16),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 !otpSent? InkWell(
                                      onTap:(){
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(Icons.arrow_back_rounded, color:Colors.white)
                                  ):Container(),
                                  !otpSent?SizedBox(height: 16):Container(),
                                  Text("Welcome",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .apply(
                                              fontSizeFactor: 0.7,
                                              // fontWeightDelta: 30,
                                              color: Colors.white)),
                                  SizedBox(height: 8),
                                  !otpSent
                                      ? Text("Forgot Password",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .apply(
                                                  fontSizeFactor: 1.1,
                                                  fontWeightDelta: 30,
                                                  color: Colors.white))
                                      : Text("OTP Verification",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .apply(
                                                  fontSizeFactor: 1.1,
                                                  fontWeightDelta: 30,
                                                  color: Colors.white)),

                                                  !otpSent?SizedBox(height: 8):Container()
                                ]),
                          )
                        ])),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.3,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: !otpSent
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(24, 10, 24, 0),
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // border:
                                    //     Border.all(width: 1, color: Colors.grey)
                                  ),
                                  child: TextFormField(
                                    controller: emailController,
                                    //  readOnly: true,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      border: InputBorder.none,
                                      hintText: 'Enter Your Email',
                                      hintStyle: TextStyle(fontSize: 12),
                                      helperStyle: TextStyle(fontSize: 12),
                                      labelStyle: TextStyle(fontSize: 12),
                                      counterStyle: TextStyle(fontSize: 12),
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                                  child: Divider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.all(16),
                                  child: InkWell(
                                      onTap: () {
                                        if (emailController.text.isEmpty ||
                                            emailController.text.trim() == "") {
                                          Fluttertoast.showToast(
                                              msg: "Please Enter Email !",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor:
                                                  MyColors.darkred.withOpacity(0.9),
                                              textColor: Colors.white,
                                              fontSize: 14.0);
                                        }
                                        
                                         else {
                                          setState(() {
                                            _saving = true;
                                          });
                                          LoginController.forgetPassword(
                                                  emailController.text.trim())
                                              .then((value) async {
                                            if (value != null) {
                                              if (value.statusCode == 200) {
                                                setState(() {
                                                  _saving = false;
                                                  otpSent=true;
                                                  // Navigator.of(context).pop();
                                                  Fluttertoast.showToast(
                                                      msg: jsonDecode(
                                                          value.body)['message'],
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor: MyColors
                                                          .darkBlue
                                                          .withOpacity(0.9),
                                                      textColor: Colors.white,
                                                      fontSize: 14.0);
                                                });
                                              } else {
                                                setState(() {
                                                  _saving = false;
                                                  Fluttertoast.showToast(
                                                      msg: jsonDecode(
                                                          value.body)['message'],
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor: MyColors
                                                          .darkred
                                                          .withOpacity(0.9),
                                                      textColor: Colors.white,
                                                      fontSize: 14.0);
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                _saving = false;
                                              });
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Server Error. Try After Sometime !",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 3,
                                                  backgroundColor: MyColors.darkred
                                                      .withOpacity(0.9),
                                                  textColor: Colors.white,
                                                  fontSize: 14.0);
                                            }
                                          });
                                        }
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: MyColors.darkBlue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Send OTP  ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .apply(
                                                          color: Colors.white,
                                                          fontWeightDelta: 30,
                                                          fontSizeFactor: 0.7)),
                                              _saving
                                                  ? Container(
                                                      height: 16,
                                                      width: 16,
                                                      child: CircularProgressIndicator(
                                                          strokeWidth: 2.0,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white)),
                                                    )
                                                  : Container(
                                                      padding: EdgeInsets.all(1),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  50)),
                                                      child: Icon(
                                                        Icons.arrow_forward,
                                                        color: MyColors.darkBlue,
                                                        size: 14,
                                                      ))
                                            ],
                                          ))),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SizedBox(height: 20),
                                // SpinKitThreeBounce(
                                //   color: MyColors.lightBlue,
                                //   size: 32,
                                // ),
                                SizedBox(height: 20),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                      "Enter The OTP Sent To\n" +
                                          emailController.text,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .apply(
                                              fontSizeFactor: 0.7,
                                              fontWeightDelta: 30,
                                              color: Colors.grey[800])),
                                ),
                                SizedBox(height: 32),
                                Container(
                                  height: 45,
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  margin: EdgeInsets.fromLTRB(80, 0, 80, 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(width: 1, color: Colors.grey)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          maxLength: 6,
                                          controller: _smsController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            counter: Offstage(),
                                            border: InputBorder.none,
                                            hintText: 'Enter OTP',
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
                                Container(
                              margin: EdgeInsets.fromLTRB(24, 10, 24, 0),
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // border:
                                //     Border.all(width: 1, color: Colors.grey)
                              ),
                              child: TextFormField(
                                controller: password1Controller,
                                //  readOnly: true,
                                obscureText: !viewEnable,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          viewEnable = !viewEnable;
                                        });
                                      },
                                      child: Icon(
                                          viewEnable
                                              ? Icons.lock_open
                                              : Icons.lock_outline,
                                          color: MyColors.darkBlue,
                                          size: 16)),
                                  fillColor: Colors.grey[200],
                                  border: InputBorder.none,
                                  hintText: 'New Password',
                                  hintStyle: TextStyle(fontSize: 12),
                                  helperStyle: TextStyle(fontSize: 12),
                                  labelStyle: TextStyle(fontSize: 12),
                                  counterStyle: TextStyle(fontSize: 12),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                              child: Divider(
                                color: Colors.grey[400],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(24, 10, 24, 0),
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // border:
                                //     Border.all(width: 1, color: Colors.grey)
                              ),
                              child: TextFormField(
                                controller: password2Controller,
                                //  readOnly: true,
                                obscureText: !view2Enable,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          view2Enable = !view2Enable;
                                        });
                                      },
                                      child: Icon(
                                          view2Enable
                                              ? Icons.lock_open
                                              : Icons.lock_outline,
                                          color: MyColors.darkBlue,
                                          size: 16)),
                                  fillColor: Colors.grey[200],
                                  border: InputBorder.none,
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(fontSize: 12),
                                  helperStyle: TextStyle(fontSize: 12),
                                  labelStyle: TextStyle(fontSize: 12),
                                  counterStyle: TextStyle(fontSize: 12),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                              child: Divider(
                                color: Colors.grey[400],
                              ),
                            ),
                                SizedBox(height: 24),
                                Container(
                                  width: MediaQuery.of(context).size.width - 80,
                                  decoration: BoxDecoration(
                                    color: MyColors.darkBlue,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: InkWell(
                                      onTap: () {
                                        if (_smsController.text.isNotEmpty) {
                                          if (password1Controller.text.isEmpty ||
                                            password1Controller.text.trim() == "" || password2Controller.text.isEmpty ||
                                            password2Controller.text.trim() == "") {
                                          Fluttertoast.showToast(
                                              msg: "New Password Required!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor:
                                                  MyColors.darkred.withOpacity(0.9),
                                              textColor: Colors.white,
                                              fontSize: 14.0);
                                        }else if (password1Controller.text != password2Controller.text){
                                          Fluttertoast.showToast(
                                              msg: "Password Don't Match!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor:
                                                  MyColors.darkred.withOpacity(0.9),
                                              textColor: Colors.white,
                                              fontSize: 14.0);
                                        }
                                        else{
                                          submit();
                                            LoginController.checkOTP(_smsController.text, password1Controller.text)
                                              .then((value) async {
                                            if (value != null) {
                                              if (value.statusCode == 200) {
                                                setState(() {
                                                  _saving = false;
                                                  otpSent=true;
                                                  Navigator.of(context).pop();
                                                  Fluttertoast.showToast(
                                                      msg: jsonDecode(
                                                          value.body)['message'],
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor: MyColors
                                                          .darkBlue
                                                          .withOpacity(0.9),
                                                      textColor: Colors.white,
                                                      fontSize: 14.0);
                                                });
                                              } else {
                                                setState(() {
                                                  _saving = false;
                                                  Fluttertoast.showToast(
                                                      msg: jsonDecode(
                                                          value.body)['message'],
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor: MyColors
                                                          .darkred
                                                          .withOpacity(0.9),
                                                      textColor: Colors.white,
                                                      fontSize: 14.0);
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                _saving = false;
                                              });
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Server Error. Try After Sometime !",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 3,
                                                  backgroundColor: MyColors.darkred
                                                      .withOpacity(0.9),
                                                  textColor: Colors.white,
                                                  fontSize: 14.0);
                                            }
                                          });
                                        }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Enter OTP",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor: Colors.grey[900],
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("Verify" + " ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .apply(
                                                      fontSizeFactor: 0.9,
                                                      fontWeightDelta: 30,
                                                      color: Colors.white)),
                                          _saving
                                              ? Container(
                                                  height: 18,
                                                  width: 18,
                                                  child: CircularProgressIndicator(
                                                      strokeWidth: 2.0,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(Colors.white)),
                                                )
                                              : Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
