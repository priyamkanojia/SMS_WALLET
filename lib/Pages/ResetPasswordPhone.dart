import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:country_picker/country_picker.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sms_wallet/Controllers/LoginController.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Pages/ForgotPasswordWidget.dart';
import 'package:sms_wallet/Pages/Home/HomeNavigationBar.dart';
import 'package:sms_wallet/Pages/Home/HomePage.dart';
import 'package:sms_wallet/Pages/RegisterPage.dart';
import 'package:sms_wallet/Pages/RegisterPhoneWidget.dart';
import 'package:sms_wallet/Pages/forgotPasswordWithPhone.dart';

class ResetPasswordWithPhone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResetPasswordWithPhoneState();
  }
}

class ResetPasswordWithPhoneState extends State<ResetPasswordWithPhone> {
  bool _saving = false;
  void submit() {
    setState(() {
      _saving = true;
    });
  }

  final TextEditingController password2Controller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool viewEnable, viewEnable2;
  @override
  void initState() {
    viewEnable = false;
    viewEnable2=false;
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void showSnackbar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey[900],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _buildWidget() {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
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
                          Text("Welcome",
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).textTheme.headline6.apply(
                                      fontSizeFactor: 0.7,
                                      // fontWeightDelta: 30,
                                      color: Colors.white)),
                          SizedBox(height: 8),
                           Text("Reset Password",
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
            top: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
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
                                controller: passwordController,
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
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // border:
                                //     Border.all(width: 1, color: Colors.grey)
                              ),
                              child: TextFormField(
                                controller: password2Controller,
                                //  readOnly: true,
                                obscureText: !viewEnable2,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          viewEnable2 = !viewEnable2;
                                        });
                                      },
                                      child: Icon(
                                          viewEnable2
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
                                                        SizedBox(height: 32),

                            Container(
                              width: MediaQuery.of(context).size.width - 48,
                              decoration: BoxDecoration(
                                color: MyColors.darkBlue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                  onTap: () {
                                   
                                   if (passwordController.text.isEmpty ||
                                      passwordController.text.trim() == "") {
                                    Fluttertoast.showToast(
                                        msg: "Enter Password!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.grey[900],
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (passwordController.text !=
                                      password2Controller.text) {
                                    Fluttertoast.showToast(
                                        msg: "Password Don't Match!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.grey[900],
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                  else{
                                    submit();
                                    LoginController.resetPassPhone(
                                              passwordController.text)
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

                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeNavigationBarWidget(
                                                      id: UserDetails.id,
                                                      index: 0),
                                            ));
                                          
                                        } else if (value != null) {
                                          setState(() {
                                            _saving = false;
                                          });
                                          Fluttertoast.showToast(
                                              msg: jsonDecode(utf8.decode(
                                                  value.bodyBytes))['message'],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Reset" + " ",
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
                        )
                      
                ],
              ),
            ),
          )
        ]),
      ),
    ));
  }

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            // CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.countryCode})"),
          ],
        ),
      );

  Widget progress() {
    return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
        body: ModalProgressHUD(
      child: _buildWidget(),
      inAsyncCall: _saving,
      progressIndicator: progress(),
    ));
  }
}
