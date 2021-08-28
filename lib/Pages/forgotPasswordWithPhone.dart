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
import 'package:sms_wallet/Pages/LoginPage.dart';
import 'package:sms_wallet/Pages/RegisterPage.dart';
import 'package:sms_wallet/Pages/ResetPasswordPhone.dart';

class ForgotPasswordWithPhone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordWithPhoneState();
  }
}

class ForgotPasswordWithPhoneState extends State<ForgotPasswordWithPhone> {
  bool _saving = false;
  void submit() {
    setState(() {
      _saving = true;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String country_code;
  final TextEditingController _phoneNumberController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  final TextEditingController _smsController = TextEditingController();
  String _verificationId, phoneNo;
  final SmsAutoFill _autoFill = SmsAutoFill();
  bool viewEnable;
  @override
  void initState() {
    country_code = "+91 ";
    phoneNo = "";
    viewEnable = false;
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

  void verifyPhoneNumber() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      setState(() {
        _saving = false;
      });
      final User user =
          (await _auth.signInWithCredential(phoneAuthCredential)).user;
      if (user != null) {
        setState(() {
          _saving = false;
        });
        showSnackbar("Successfully Verified.");
        _auth.signOut();

        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.setString("id", UserDetails.id);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResetPasswordWithPhone(),
        ));
      } else {
        showSnackbar("Something Went Wrong, Try After Sometime.");
      }
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      setState(() {
        _saving = false;
      });
      showSnackbar(authException.message);
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      setState(() {
        _saving = false;
      });
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      setState(() {
        _saving = false;
      });
      // showSnackbar("verification code: " + verificationId);
      _verificationId = verificationId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNo,
          timeout: const Duration(seconds: 10),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar("Failed to Verify Phone Number.");
    }
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        setState(() {
          _saving = false;
        });
        showSnackbar("Successfully Verified.");
        _auth.signOut();

        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.setString("id", UserDetails.id);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResetPasswordWithPhone(),
        ));
      } else {
        showSnackbar("Something Went Wrong, Try After Sometime.");
      }
    } catch (ex) {
      setState(() {
        _saving = false;
      });
      switch (ex.code) {
        case "invalid-verification-code":
          showSnackbar("Invalid OTP !");
          break;
        case "session-expired":
          showSnackbar("The Code Has Been Expired !");

          break;
        default:
          showSnackbar("Faild:" + ex.toString());
      }
    }
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
                          _verificationId == null
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(Icons.arrow_back_rounded,
                                      color: Colors.white))
                              : Container(),
                          _verificationId == null
                              ? SizedBox(height: 16)
                              : Container(),
                          Text("Welcome",
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).textTheme.headline6.apply(
                                      fontSizeFactor: 0.7,
                                      // fontWeightDelta: 30,
                                      color: Colors.white)),
                          SizedBox(height: 8),
                          _verificationId == null
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
                  _verificationId == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              padding: EdgeInsets.only(top: 10, left: 10),
                              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // border:
                                //     Border.all(width: 1, color: Colors.grey)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      // margin: EdgeInsets.only(bottom: 10),
                                      width: 60,
                                      height: 45,
                                      child: InkWell(
                                        onTap: () {
                                          showCountryPicker(
                                            context: context,
                                            exclude: <String>['KN', 'MF'],
                                            showPhoneCode: true,
                                            onSelect: (Country country) {
                                              setState(() {
                                                country_code = "+" +
                                                    country.phoneCode +
                                                    " ";
                                              });
                                            },
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              country_code,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .apply(
                                                      fontSizeFactor: 0.7,
                                                      color: Colors.grey[600],
                                                      fontWeightDelta: 30),
                                            ),
                                            Icon(Icons.arrow_drop_down,
                                                color: Colors.grey)
                                          ],
                                        ),
                                      )),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    height: 40,
                                    margin: EdgeInsets.only(top: 2),
                                    child: TextFormField(
                                      maxLength: 12,
                                      controller: _phoneNumberController,
                                      decoration: InputDecoration(
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              // setState(() {
                                              //   viewEnable = !viewEnable;
                                              // });
                                            },
                                            child: Icon(Icons.phone_android,
                                                color: MyColors.darkBlue,
                                                size: 16)),
                                        isDense: true,
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        hintText: 'Enter Phone',
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
                                    submit();

                                    if (_phoneNumberController.text.isEmpty ||
                                        _phoneNumberController.text.trim() ==
                                            "") {
                                      setState(() {
                                        _saving = false;
                                      });
                                      Fluttertoast.showToast(
                                          msg: "Phone Required !",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.grey[900],
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      LoginController.mobileCheck(country_code +
                                              _phoneNumberController.text)
                                          .then((value) {
                                        if (value != null &&
                                            value.statusCode == 200) {
                                          UserDetails.fromJson(jsonDecode(utf8.decode(value.bodyBytes))['data']);

                                          // phoneNo = country_code +
                                          //     _phoneNumberController.text;
                                          // verifyPhoneNumber();
                                           Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResetPasswordWithPhone(),
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
                            SizedBox(height: 32),
                          ],
                        )
                      : Column(
                          children: [
                            // SizedBox(height: 20),
                            SpinKitThreeBounce(
                              color: MyColors.lightBlue,
                              size: 32,
                            ),
                            SizedBox(height: 40),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                  "Enter 6 Digit OTP Sent To\n" +
                                      country_code +
                                      _phoneNumberController.text,
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
                                    if (_smsController.text.isNotEmpty &&
                                        _smsController.text.length == 6) {
                                      setState(() {
                                        _saving = true;
                                      });
                                      signInWithPhoneNumber();
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
