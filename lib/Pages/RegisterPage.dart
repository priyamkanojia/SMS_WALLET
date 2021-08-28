import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Controllers/LoginController.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Pages/Home/HomeNavigationBar.dart';
import 'package:sms_wallet/Pages/Home/HomePage.dart';

class RegisterWidget extends StatefulWidget {
  final String phone;
  RegisterWidget({@required this.phone});
  @override
  State<StatefulWidget> createState() {
    return RegisterWidgetState();
  }
}

class RegisterWidgetState extends State<RegisterWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  bool referalReadOnly = false;

  bool _saving = false;
  bool viewEnable, view2Enable;

  @override
  void initState() {
    viewEnable = false;
    view2Enable = false;

    super.initState();
  }

  void submit() {
    setState(() {
      _saving = true;
      referalReadOnly = true;
    });
  }

  Widget _buildWidget() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                          height: MediaQuery.of(context).size.height * 0.28,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Welcome  " + widget.phone,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            fontSizeFactor: 0.7,
                                            // fontWeightDelta: 30,
                                            color: Colors.white)),
                                // SizedBox(height: 8),

                                Text("Create Profile",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            fontSizeFactor: 1.1,
                                            fontWeightDelta: 30,
                                            color: Colors.white))
                              ]),
                        )
                      ])),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                              controller: nameController,
                              //  readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: () {},
                                    child: Icon(Icons.person,
                                        color: MyColors.darkBlue, size: 16)),
                                fillColor: Colors.grey[200],
                                border: InputBorder.none,
                                hintText: 'Enter Full Name',
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
                            margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              // border:
                              //     Border.all(width: 1, color: Colors.grey)
                            ),
                            child: TextFormField(
                              controller: emailController,
                              //  readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: () {},
                                    child: Icon(Icons.email,
                                        color: MyColors.darkBlue, size: 16)),
                                fillColor: Colors.grey[200],
                                border: InputBorder.none,
                                hintText: 'Enter Email',
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
                                hintText: 'Create Password',
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
                              controller: referralController,
                              readOnly: referalReadOnly,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: () {},
                                    child: Icon(Icons.confirmation_num_rounded,
                                        color: MyColors.darkBlue, size: 16)),
                                fillColor: Colors.grey[200],
                                border: InputBorder.none,
                                hintText: 'Enter Referal Code',
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
                            height: 16,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 48,
                            decoration: BoxDecoration(
                              color: MyColors.darkBlue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                                onTap: () {
                                  if (nameController.text.isEmpty ||
                                      nameController.text.trim() == "") {
                                    Fluttertoast.showToast(
                                        msg: "Name Required!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.grey[900],
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (emailController.text.isEmpty ||
                                      emailController.text.trim() == "") {
                                    Fluttertoast.showToast(
                                        msg: "Email Required!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.grey[900],
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (password1Controller.text.isEmpty ||
                                      password1Controller.text.trim() == "") {
                                    Fluttertoast.showToast(
                                        msg: "Enter Password!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.grey[900],
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (password1Controller.text !=
                                      password2Controller.text) {
                                    Fluttertoast.showToast(
                                        msg: "Password Don't Match!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.grey[900],
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    String ref = referralController.text;

                                    Widget okButton = InkWell(
                                      child: Container(
                                        color: MyColors.darkBlue,
                                        padding: EdgeInsets.all(5),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Text(
                                          "Yes",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .apply(
                                                  color: Colors.white,
                                                  fontSizeFactor: 0.8,
                                                  fontWeightDelta: 30),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        submit();
                                        FirebaseMessaging.instance
                                            .getToken()
                                            .then((rememberToken) {
                                          LoginController.register(
                                                  widget.phone,
                                                  nameController.text
                                                      .toString()
                                                      .trim(),
                                                  emailController.text
                                                      .toString()
                                                      .trim(),
                                                  ref,
                                                  password1Controller.text,
                                                  rememberToken)
                                              .then((value) async {
                                            if (value != null &&
                                                value.statusCode == 200) {
                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              preferences.setString(
                                                  "id", UserDetails.id);
                                              preferences.setString("api_token",
                                                  UserDetails.apiToken);

                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeNavigationBarWidget(
                                                              id: UserDetails
                                                                  .id,
                                                              index: 0)));
                                            } else if (value != null) {
                                              setState(() {
                                                _saving = false;
                                                referalReadOnly = false;
                                              });
                                              Fluttertoast.showToast(
                                                  msg: jsonDecode(utf8.decode(
                                                          value.bodyBytes))[
                                                      'message'],
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 3,
                                                  backgroundColor:
                                                      Colors.grey[900],
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              setState(() {
                                                _saving = false;
                                                referalReadOnly = false;
                                              });
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Something Went Wrong, Please Try After Sometime",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 3,
                                                  backgroundColor:
                                                      Colors.grey[900],
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          });
                                        });
                                      },
                                    );
                                    Widget cancel = InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Text(
                                          "No",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .apply(
                                                  fontSizeFactor: 0.8,
                                                  fontWeightDelta: 30),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                    // set up the AlertDialog
                                    AlertDialog alert = AlertDialog(
                                      content: Text(Urls.referalSignupPopup),
                                      actions: [
                                        cancel,
                                        okButton,
                                      ],
                                    );

                                    // show the dialog

                                    if (referralController.text.isEmpty) {
                                      showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    } else {
                                      Navigator.of(context).pop();
                                      submit();
                                      FirebaseMessaging.instance
                                          .getToken()
                                          .then((rememberToken) {
                                        LoginController.register(
                                                widget.phone,
                                                nameController.text
                                                    .toString()
                                                    .trim(),
                                                emailController.text
                                                    .toString()
                                                    .trim(),
                                                ref,
                                                password1Controller.text,
                                                rememberToken)
                                            .then((value) async {
                                          if (value != null &&
                                              value.statusCode == 200) {
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                "id", UserDetails.id);
                                            preferences.setString("api_token",
                                                UserDetails.apiToken);

                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeNavigationBarWidget(
                                                            id: UserDetails.id,
                                                            index: 0)));
                                          } else if (value != null) {
                                            setState(() {
                                              _saving = false;
                                              referalReadOnly = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg: jsonDecode(utf8.decode(
                                                    value
                                                        .bodyBytes))['message'],
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 3,
                                                backgroundColor:
                                                    Colors.grey[900],
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else {
                                            setState(() {
                                              _saving = false;
                                              referalReadOnly = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Something Went Wrong, Please Try After Sometime",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 3,
                                                backgroundColor:
                                                    Colors.grey[900],
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        });
                                      });
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Submit" + " ",
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
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ));
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
      body: ModalProgressHUD(
        child: _buildWidget(),
        inAsyncCall: _saving,
        progressIndicator: progress(),
      ),
    );
  }
}
