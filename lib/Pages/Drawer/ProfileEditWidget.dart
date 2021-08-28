import 'dart:convert';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Controllers/LoginController.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'dart:ui' as ui;

import 'package:sms_wallet/Pages/Drawer/ProfileStatusWidget.dart';
import 'package:sms_wallet/Pages/LoginPage.dart';

class ProfileEditWidget extends StatefulWidget {
  Function updateProfile;
  ProfileEditWidget({Key key, @required this.updateProfile}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ProfileEditWidgetState();
  }
}

class ProfileEditWidgetState extends State<ProfileEditWidget> {
  TextEditingController phoneContr = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController genderContr = new TextEditingController();
  //String genderContr;
  TextEditingController emailContr = new TextEditingController();
  TextEditingController addressContr = new TextEditingController();
  TextEditingController cityContr = new TextEditingController();
  TextEditingController stateContr = new TextEditingController();
  TextEditingController countryContr = new TextEditingController();
  TextEditingController interestContr = new TextEditingController() ;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _saving = false;

  String country_code;

  String dob = '1960-01-01';
  // bool isFormEditable;
  void submit() {
    setState(() {
      _saving = true;
    });
  }

  @override
  void initState() {
    if (UserDetails.dob != null) {
      dob = UserDetails.dob;
    }
    if (UserDetails.username != null) {
      usernameController.text = UserDetails.username;
    }
    if (UserDetails.gender != null) {
      genderContr.text = UserDetails.gender;
    }
    if (UserDetails.fullname != null) {
      nameController.text = UserDetails.fullname;
    }
    if (UserDetails.email != null) {
      emailContr.text = UserDetails.email;
    }
    if (UserDetails.country != null) {
      countryContr.text = UserDetails.country;
    }
    if (UserDetails.state != null) {
      stateContr.text = UserDetails.state;
    }
    if (UserDetails.city != null) {
      cityContr.text = UserDetails.city;
    }
    if (UserDetails.address != null) {
      addressContr.text = UserDetails.address;
    }
    if (UserDetails.interest != null) {
      interestContr.text = UserDetails.interest;
    }
    _image = null;
    // isFormEditable = false;
    if (UserDetails.mobile != null) {
      country_code =
          UserDetails.mobile.substring(0, UserDetails.mobile.indexOf(" ") + 1);
      phoneContr.text = UserDetails.mobile.replaceAll(country_code, "");
    } else {
      country_code = "+91 ";
    }

    _image = null;

    super.initState();
  }

  Widget progress() {
    return Center(
      child: SpinKitThreeBounce(
        color: MyColors.orange,
        size: 32,
      ),
    );
  }

  File _image;
  final picker = ImagePicker();
  Future getImage(String path) async {
    final pickedFile = await picker.getImage(
        source: path == "c" ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _cropImage(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Null> _cropImage(File img) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: img.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                // CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                // CropAspectRatioPreset.ratio4x3,
                // CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                // CropAspectRatioPreset.ratio3x2,
                // CropAspectRatioPreset.ratio4x3,
                // CropAspectRatioPreset.ratio5x3,
                // CropAspectRatioPreset.ratio5x4,
                // CropAspectRatioPreset.ratio7x5,
                // CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: MyColors.darkBlue,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
        submit();
      });
      LoginController.updateImage(_image).then((value) {
        if (value == "success") {
          LoginController.userInfo(UserDetails.id, UserDetails.apiToken)
              .then((value) {
            setState(() {
              _saving = false;
              widget.updateProfile();
            });
            Fluttertoast.showToast(
                msg: "Profie Photo Changed Successfully.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: MyColors.darkBlue.withOpacity(0.8),
                textColor: Colors.white,
                fontSize: 12.0);
            Navigator.of(context).pop();
          });
        } else {
          setState(() {
            _saving = false;
            _image.delete();
          });
          Fluttertoast.showToast(
              msg: "Server Error, Try After Sometime.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: MyColors.darkred.withOpacity(0.8),
              textColor: Colors.white,
              fontSize: 12.0);
        }
      });
    }
  }

  Future<bool> choiceCamGal() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            // title: Text('Add Note'),
            content: Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: MyColors.lightBlue),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          getImage("g");
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 50,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              // color:MyColors.darkred
                            ),
                            child: Center(
                                child: Text(
                              "Gallery",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue),
                            ))),
                      ),
                      Divider(color: MyColors.lightBlue),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();

                          getImage("c");
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,

                            // height: 50,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              // color:MyColors.darkred
                            ),
                            child: Center(
                                child: Text(
                              "Camera",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue),
                            ))),
                      ),
                    ],
                  ),
                )),
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.member.contact.substring(0, widget.member.contact.indexOf(" ")));
    return ModalProgressHUD(
      inAsyncCall: _saving,
      progressIndicator: progress(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              // image: DecorationImage(
              //     image: AssetImage("assets/backgroundall.png"),
              //     fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Positioned(
                  child: Column(
                    children: [
                      CustomPaint(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.8,
                        ),
                        painter: HeaderCurvedContainerss(),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height:
                                  MediaQuery.of(context).size.height * 0.1 + 16,
                              child: Row(
                                children: [
                                  /*InkWell(
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 16, 0, 0),
                                        child: Icon(Icons.arrow_back,
                                            color: Colors.white)),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),*/
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 88,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              16, 16, 16, 0),
                                          child: Text("Profile",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .apply(
                                                    color: Colors.white,
                                                    fontWeightDelta: 30,
                                                    fontSizeFactor: 1.0,
                                                  )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.9 - 16,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.9,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(24, 0, 24, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  choiceCamGal();
                                                },
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: 114,
                                                      width: 114,
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .grey[200],
                                                              blurRadius: 3,
                                                              spreadRadius: 0.5)
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(200),
                                                      ),
                                                      child: Container(
                                                        height: 110,
                                                        width: 110,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                width: 2,
                                                                color: Colors
                                                                    .grey[200]),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    200),
                                                            image: DecorationImage(
                                                                image: _image == null
                                                                    ? (UserDetails.profileImage !=
                                                                            null
                                                                        ? NetworkImage(Urls.image_urls +
                                                                            UserDetails
                                                                                .profileImage)
                                                                        : AssetImage(
                                                                            "assets/userprofile.png"))
                                                                    : FileImage(
                                                                        File(_image.path)),
                                                                fit: BoxFit.cover)),
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .black)),
                                                            child: Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.black,
                                                              size: 16,
                                                            )))
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProfileStatusWidget()));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            MyColors.lightBlue,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text("Profile Status",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6
                                                                  .apply(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeightDelta:
                                                                        30,
                                                                    fontSizeFactor:
                                                                        0.6,
                                                                  )),
                                                                  SizedBox(height: 8,),
                                                      new CircularPercentIndicator(
                                                        radius: 70.0,
                                                        animation: true,
                                                        animationDuration: 3000,
                                                        lineWidth: 7.0,
                                                        percent: double.parse(UserDetails.profileStatus.toString())/100,
                                                        center: new Text(
                                                          UserDetails.profileStatus.toString()+"%",
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14.0),
                                                        ),
                                                        circularStrokeCap:
                                                            CircularStrokeCap
                                                                .butt,
                                                        backgroundColor:
                                                            Colors.grey[400],
                                                        progressColor:
                                                            Colors.green,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 24, 0, 16),
                                        margin: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Form(
                                          key: _formkey,
                                          child: Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      child: Text("Full Name",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                                color:
                                                                    Colors.black,
                                                                fontWeightDelta:
                                                                    30,
                                                                fontSizeFactor:
                                                                    0.7,
                                                              ))),
                                                  Container(
                                                    height: 40,
                                                    margin: EdgeInsets.fromLTRB(
                                                        28, 0, 28, 10),
                                                    padding: EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                    child: TextFormField(
                                                      style:
                                                          TextStyle(fontSize: 14),
                                                      controller: nameController,
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        border: InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            fontSize: 14),
                                                        hintText: 'Full Name',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      child: Text("Email",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                                color:
                                                                    Colors.black,
                                                                fontWeightDelta:
                                                                    30,
                                                                fontSizeFactor:
                                                                    0.7,
                                                              ))),
                                                  Wrap(
                                                    children: [
                                                      Container(
                                                        //height: 40,
                                                        margin: EdgeInsets.fromLTRB(
                                                            28, 0, 28, 10),
                                                        padding: EdgeInsets.fromLTRB(
                                                            16, 0, 16, 0),
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey[200],
                                                            border: Border.all(
                                                                width: 1.5,
                                                                color: Colors.grey),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    5)),
                                                        child: TextFormField(
                                                          style: TextStyle(fontSize: 14),
                                                          controller: emailContr,
                                                          validator: (String input){
                                                            if(input.isEmpty){
                                                              return "Enter Email.";
                                                            }
                                                            if(!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(input)){
                                                              return 'Please enter a valid email';
                                                              return null;
                                                            }
                                                            return null;
                                                            },
                                                          decoration: InputDecoration(
                                                            isDense: true,
                                                            border: InputBorder.none,
                                                            hintStyle: TextStyle(
                                                                fontSize: 14),
                                                            hintText: 'Email',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      child: Text("Username",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                                color:
                                                                    Colors.black,
                                                                fontWeightDelta:
                                                                    30,
                                                                fontSizeFactor:
                                                                    0.7,
                                                              ))),
                                                  Container(
                                                    height: 40,
                                                    margin: EdgeInsets.fromLTRB(
                                                        28, 0, 28, 10),
                                                    padding: EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                    child: TextFormField(
                                                      style:
                                                          TextStyle(fontSize: 14),
                                                      controller:
                                                          usernameController,
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        border: InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            fontSize: 14),
                                                        hintText: 'Username',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      width: MediaQuery.of(context).size.width,
                                                      child: Text("Gender",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                            color:
                                                            Colors.black,
                                                            fontWeightDelta:
                                                            30,
                                                            fontSizeFactor:
                                                            0.7,
                                                          ))),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40,
                                                    margin: EdgeInsets.fromLTRB(
                                                        28, 0, 28, 10),
                                                    padding: EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                    child: TextFormField(
                                                      style:
                                                      TextStyle(fontSize: 14),
                                                      controller:
                                                      genderContr,
                                                      // validator: (String input)
                                                      // {
                                                      //   if(input.length){
                                                      //     return "";}
                                                      //   else
                                                      //     return null;
                                                      // },
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        border: InputBorder.none,

                                                        hintStyle: TextStyle(
                                                            fontSize: 14),
                                                        hintText: 'Gender',
                                                      ),
                                                    ),

                                                      /*Form(
                                                        child: DropdownButton<String>(
                                                            value: genderContr,
                                                            isExpanded: true,
                                                            items: [
                                                              DropdownMenuItem<String>(
                                                                child: Text('Male'),
                                                                value: 'Male',
                                                              ),
                                                              DropdownMenuItem<String>(
                                                                child: Text('Female'),
                                                                value: 'Female',
                                                              ),
                                                              DropdownMenuItem<String>(
                                                                child: Text('Other'),
                                                                value: 'Other',
                                                              ),
                                                            ],
                                                          hint: Text(genderContr == null ?'Select Gender': genderContr),
                                                          underline:Container(color: Colors.white),
                                                          //validator: (value)=>value==null?'Select Gender':UserDetails.gender,
                                                          icon: Icon(Icons.arrow_downward,size: 20.0,),
                                                          onChanged:(String value){
                                                              setState(() {
                                                                genderContr = value ;
                                                                 //UserDetails.gender=genderContr;
                                                              });
                                                          },
                                                        ),
                                                      ),*/

                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      child: Text("Mobile",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                                color:
                                                                    Colors.black,
                                                                fontWeightDelta:
                                                                    30,
                                                                fontSizeFactor:
                                                                    0.7,
                                                              ))),
                                                  Container(
                                                    height: 40,
                                                    // width: MediaQuery.of(context).size.width,
                                                    margin: EdgeInsets.fromLTRB(
                                                        28, 0, 28, 10),
                                                    padding: EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 0),
                                                            width: 64,
                                                            height: 40,
                                                            child: InkWell(
                                                              onTap: () {
                                                                showCountryPicker(
                                                                  context:
                                                                      context,
                                                                  exclude: <
                                                                      String>[
                                                                    'KN',
                                                                    'MF'
                                                                  ],
                                                                  showPhoneCode:
                                                                      true,
                                                                  onSelect: (Country
                                                                      country) {
                                                                    setState(() {
                                                                      country_code = "+" +
                                                                          country
                                                                              .phoneCode +
                                                                          " ";
                                                                    });
                                                                  },
                                                                );
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                    country_code,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline6
                                                                        .apply(
                                                                            fontSizeFactor:
                                                                                0.7,
                                                                            color: Colors.grey[
                                                                                600],
                                                                            fontWeightDelta:
                                                                                30),
                                                                  ),
                                                                  Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      color: Colors
                                                                          .grey)
                                                                ],
                                                              ),
                                                            )),
                                                        Expanded(
                                                          child: Wrap(
                                                            children: [
                                                              Container(
                                                                //height: 40,
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        16, 0, 16, 0),
                                                                child: TextFormField(
                                                                  // readOnly: true,
                                                                  style: TextStyle(
                                                                      fontSize: 14),
                                                                  controller:
                                                                      phoneContr,
                                                                  validator: (String input)
                                                                  {
                                                                    if(input.length <10){
                                                                      return "Invalid Mobile No.";}
                                                                    else
                                                                      return null;
                                                                  },
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense: true,

                                                                    hintStyle:
                                                                        TextStyle(
                                                                            fontSize:
                                                                                14),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    // prefix: I,
                                                                    hintText: 'Phone',
                                                                  ),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  inputFormatters: <
                                                                      TextInputFormatter>[
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      child: Text("Date Of Birth",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                                color:
                                                                    Colors.black,
                                                                fontWeightDelta:
                                                                    30,
                                                                fontSizeFactor:
                                                                    0.7,
                                                              ))),
                                                  Container(
                                                    height: 40,
                                                    margin: EdgeInsets.fromLTRB(
                                                        28, 0, 28, 10),
                                                    padding: EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                    child: DateTimePicker(
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              'Date Of Birth',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14),
                                                          border:
                                                              InputBorder.none),
                                                      initialValue:dob,
                                                      firstDate: DateTime(1960),
                                                      lastDate: DateTime(2009),
                                                      dateLabelText:
                                                          'Date Of Birth',
                                                      onChanged: (val) {
                                                        setState(() {
                                                          dob = val;
                                                        });
                                                      },
                                                      validator: (val) {
                                                        print(val);
                                                        return null;
                                                      },
                                                      // onSaved: (val) => print(val),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      child: Text("Country",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                            color:
                                                            Colors.black,
                                                            fontWeightDelta:
                                                            30,
                                                            fontSizeFactor:
                                                            0.7,
                                                          ))),
                                                  Container(
                                                    height: 40,
                                                    margin: EdgeInsets.fromLTRB(
                                                        28, 0, 28, 10),
                                                    padding: EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                    child: TextFormField(
                                                      style:
                                                      TextStyle(fontSize: 14),
                                                      controller: countryContr,
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        border: InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            fontSize: 14),
                                                        hintText: 'Country',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      child: Text("State",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                                color:
                                                                    Colors.black,
                                                                fontWeightDelta:
                                                                    30,
                                                                fontSizeFactor:
                                                                    0.7,
                                                              ))),
                                                  Container(
                                                    height: 40,
                                                    margin: EdgeInsets.fromLTRB(
                                                        28, 0, 28, 10),
                                                    padding: EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                    child: TextFormField(
                                                      style:
                                                          TextStyle(fontSize: 14),
                                                      controller: stateContr,
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        border: InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            fontSize: 14),
                                                        hintText: 'State',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      child: Text("City",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                                color:
                                                                    Colors.black,
                                                                fontWeightDelta:
                                                                    30,
                                                                fontSizeFactor:
                                                                    0.7,
                                                              ))),
                                                  Container(
                                                    height: 40,
                                                    margin: EdgeInsets.fromLTRB(
                                                        28, 0, 28, 10),
                                                    padding: EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                    child: TextFormField(
                                                      style:
                                                          TextStyle(fontSize: 14),
                                                      controller: cityContr,
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        border: InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            fontSize: 14),
                                                        hintText: 'City',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      child: Text("Address",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                                color:
                                                                    Colors.black,
                                                                fontWeightDelta:
                                                                    30,
                                                                fontSizeFactor:
                                                                    0.7,
                                                              ))),
                                                  Container(
                                                    height: 40,
                                                    margin: EdgeInsets.fromLTRB(
                                                        28, 0, 28, 10),
                                                    padding: EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                    child: TextFormField(
                                                      style:
                                                          TextStyle(fontSize: 14),
                                                      controller: addressContr,
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        border: InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            fontSize: 14),
                                                        hintText: 'Address',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          28, 0, 0, 5),
                                                      child: Text("Interest",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                            color:
                                                            Colors.black,
                                                            fontWeightDelta:
                                                            30,
                                                            fontSizeFactor:
                                                            0.7,
                                                          ))),
                                                  Container(
                                                    height: 40,
                                                    margin: EdgeInsets.fromLTRB(
                                                        28, 0, 28, 10),
                                                    padding: EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                    child: TextFormField(
                                                      style:
                                                      TextStyle(fontSize: 14),
                                                      controller: interestContr,
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        border: InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            fontSize: 14),
                                                        hintText: 'Interest',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    32, 20, 32, 12),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          if (nameController
                                                                  .text.isEmpty ||
                                                              nameController.text
                                                                      .trim() ==
                                                                  "") {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Fullname Required.",
                                                                backgroundColor:
                                                                    MyColors
                                                                        .darkred
                                                                        .withOpacity(
                                                                            0.7),
                                                                textColor:
                                                                    Colors.white);
                                                          } else if (emailContr
                                                                  .text.isEmpty ||
                                                              emailContr.text
                                                                      .trim() ==
                                                                  "") {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Email Required.",
                                                                backgroundColor:
                                                                    MyColors
                                                                        .darkred
                                                                        .withOpacity(
                                                                            0.7),
                                                                textColor:
                                                                    Colors.white);
                                                          } else if (phoneContr
                                                                  .text.isEmpty ||
                                                              phoneContr.text
                                                                      .trim() ==
                                                                  "") {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Mobile Required.",
                                                                backgroundColor:
                                                                    MyColors
                                                                        .darkred
                                                                        .withOpacity(
                                                                            0.7),
                                                                textColor:
                                                                    Colors.white);
                                                          } else if (dob == "") {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "DOB Required.",
                                                                backgroundColor:
                                                                    MyColors
                                                                        .darkred
                                                                        .withOpacity(
                                                                            0.7),
                                                                textColor:
                                                                    Colors.white);
                                                          } else if (phoneContr
                                                                  .text.isEmpty ||
                                                              phoneContr.text
                                                                      .trim() ==
                                                                  "") {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Mobile Required.",
                                                                backgroundColor:
                                                                    MyColors
                                                                        .darkred
                                                                        .withOpacity(
                                                                            0.7),
                                                                textColor:
                                                                    Colors.white);
                                                            validate();
                                                          } else {
                                                            validate();
                                                            submit();
                                                            LoginController.profileUpdate(
                                                                    (country_code +
                                                                        phoneContr
                                                                            .text
                                                                            .trim()),
                                                                    nameController
                                                                        .text
                                                                        .trim(),
                                                                    emailContr.text
                                                                        .trim(),
                                                                    usernameController
                                                                        .text
                                                                        .trim(),
                                                                    genderContr.text.trim(),
                                                                    dob,
                                                              stateContr
                                                                  .text
                                                                  .trim(),
                                                              cityContr.text
                                                                  .trim(),
                                                              countryContr.text.trim(),
                                                              //genderContr.trim(),
                                                              addressContr
                                                                        .text
                                                                        .trim(),
                                                              interestContr.text.trim(),
                                                              //genderContr,
                                                            )
                                                                .then((value) {
                                                              setState(() {
                                                                _saving = false;
                                                              });
                                                              if (value
                                                                      .statusCode ==
                                                                  200) {
                                                                setState(() {
                                                                  _saving = false;
                                                                  widget
                                                                      .updateProfile();
                                                                });
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Profile Info Updated Succesfully.",
                                                                    backgroundColor: MyColors
                                                                        .darkBlue
                                                                        .withOpacity(
                                                                            0.7),
                                                                    textColor:
                                                                        Colors
                                                                            .white);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              } else {
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Server Error, Try After Sometime.",
                                                                    backgroundColor: MyColors
                                                                        .darkBlue
                                                                        .withOpacity(
                                                                            0.7),
                                                                    textColor:
                                                                        Colors
                                                                            .white);
                                                              }
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                            width: MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.3,
                                                            padding:
                                                                EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                                color: MyColors
                                                                    .darkBlue,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        50)),
                                                            child: Text("Update",
                                                                textAlign: TextAlign
                                                                    .center,
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .headline6
                                                                    .apply(
                                                                        fontSizeFactor:
                                                                            0.8,
                                                                        color: Colors
                                                                            .white)))),
                                                    /*InkWell(
                                                      onTap:() {
                                                        print('delete pressed');
                                                        showDialog(
                                                          context: context,
                                                            builder:(BuildContext context)=> AlertDialog(
                                                            title: Text('Are you sure?'),
                                                            content: Text('Do you really want to deactivate your account?'),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                onPressed: (){
                                                                  // Navigator.of(context).pushReplacement(
                                                                  //     MaterialPageRoute(builder: (context) =>NativeAd()));
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: Text('No'),
                                                              ),
                                                              FlatButton(
                                                                onPressed: () async {
                                                                  // Navigator.of(context).pushReplacement(
                                                                  //     MaterialPageRoute(builder: (context) =>NativeAd()));

                                                                  //Navigator.of(context).pop(true);

                                                                  setState(() async {
                                                                    LoginController.deleteAc();
                                                                    SharedPreferences preferences =
                                                                        await SharedPreferences.getInstance();
                                                                    preferences.remove("id");
                                                                    preferences.remove("api_token");
                                                                    UserDetails.id = null;
                                                                    UserDetails.fullname = null;
                                                                    UserDetails.username = null;
                                                                    UserDetails.email = null;
                                                                    UserDetails.mobile = null;
                                                                    UserDetails.dob = null;
                                                                    UserDetails.emailVerifiedAt = null;
                                                                    UserDetails.password = null;
                                                                    UserDetails.socialId = null;
                                                                    UserDetails.loginType = null;
                                                                    UserDetails.city = null;
                                                                    UserDetails.state = null;
                                                                    UserDetails.address = null;
                                                                    UserDetails.isActive = null;
                                                                    UserDetails.isKycDone = null;
                                                                    UserDetails.apiToken = null;
                                                                    UserDetails.referalcode = null;
                                                                    UserDetails.referedCode = null;
                                                                    UserDetails.profileImage = null;
                                                                    UserDetails.rememberToken = null;
                                                                    UserDetails.createdAt = null;
                                                                    UserDetails.updatedAt = null;
                                                                    UserDetails.task = null;
                                                                    Navigator.pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => LoginWidget()));
                                                                  });
                                                                },
                                                                child: Text('Yes'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                        },
                                                      child: Container(
                                                        width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.3,
                                                        padding:
                                                        EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                50)),
                                                        child: Text("Deactivate",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .headline6
                                                                .apply(
                                                                fontSizeFactor:
                                                                0.8,
                                                                color: Colors
                                                                    .white)))
                                                                )*/
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 20.0,),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ])
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
  validate(){
    if(_formkey.currentState.validate()){
      print('Successfull');
      _formkey.currentState.save();
    }
    else
      print('Unssessfull');
  }
}

// CustomPainter class to for the header curved-container
class HeaderCurvedContainerss extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(0, 150),
        [
          MyColors.darkBlue.withOpacity(0.8),
          MyColors.darkBlue,
        ],
      );
    Path path = Path()
      ..relativeLineTo(0, size.height * 0.40)
      ..quadraticBezierTo(
          size.width / 2, size.height * 0.30, size.width, size.height * 0.20)
      ..relativeLineTo(0, -size.height * 0.20)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}
