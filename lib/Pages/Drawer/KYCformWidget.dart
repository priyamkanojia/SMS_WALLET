import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Pages/Home/HomeNavigationBar.dart';
import 'package:sms_wallet/Pages/faq.dart';

class KYCformWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return KYCformWidgetState();
  }
}

TextEditingController idNumberController = new TextEditingController();
TextEditingController idTypeController = new TextEditingController();

String defaultIdType;
final FocusNode myFocusNode = FocusNode();

class KYCformWidgetState extends State<KYCformWidget> {
  void initState() {
    idNumberController.clear();
    idTypeController.clear();
    defaultIdType = "Adhar";
    file=null;
    super.initState();
  }

  bool load = true;
    bool load2 = true;

  File file, file2;
  String status;
  final picker = ImagePicker();
  final picker2 = ImagePicker();

  Future<File> _choose() async {
    file = null;
    // file = await ImagePicker.pickImage(source: ImageSource.camera);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    file = File(pickedFile.path);
    return file;
  }
Future<File> _choose2() async {
    file2 = null;
    // file = await ImagePicker.pickImage(source: ImageSource.camera);
    final pickedFile2 = await picker2.getImage(source: ImageSource.gallery);
    file2 = File(pickedFile2.path);
    return file2;
  }
  Widget _getActionButtons() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
                          // padding: EdgeInsets.all( 10.0),

              child: new InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              color:MyColors.darkBlue,
              child: new Text("Submit", textAlign: TextAlign.center, style: TextStyle(color:Colors.white, fontSize: 18),)),
            onTap: () {
              if(idNumberController.text.isEmpty){
                Fluttertoast.showToast(
                        msg: "Id Number Required!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.grey[900],
                        textColor: Colors.white,
                        fontSize: 16.0);
              } else if(file==null){
                Fluttertoast.showToast(
                        msg: "Document Front Required!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.grey[900],
                        textColor: Colors.white,
                        fontSize: 16.0);
              }
              else if(file2==null){
                Fluttertoast.showToast(
                        msg: "Document Back Required!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.grey[900],
                        textColor: Colors.white,
                        fontSize: 16.0);
              }
              else{
              submit();
              AppSettingsController.kycSubmit(idNumberController.text.trim(), idTypeController.text.trim(), file, file2,status).then((value) {
                if (value.statusCode == 200) {
                  setState(() {
                    setState(() {
                      _saving = false;
                      UserDetails.isKycDone = "Requested";
                    });

                    Fluttertoast.showToast(
                        msg: "Information Submitted Successfully !",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.grey[900],
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeNavigationBarWidget(
                              id: UserDetails.id, index: 0)),
                    (Route<dynamic> route) => false);
                  
                } else {
                  setState(() {
                    _saving = false;
                  });
                  Fluttertoast.showToast(
                      msg: jsonDecode(value.body)['message'],
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.grey[900],
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              });
              setState(() {
                FocusScope.of(context).requestFocus(new FocusNode());
              });
              }
            },
            // shape: new RoundedRectangleBorder(
            //     borderRadius: new BorderRadius.circular(10.0)),
          )),
          flex: 2,
        ),
      ],
    );
  }

  bool _saving = false;

  void submit() {
    setState(() {
      _saving = true;
    });
  }

  Widget progress() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(MyColors.darkBlue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      progressIndicator: progress(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[300],
            elevation: 0,
            centerTitle: true,
            title: Text(
              "KYC",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .apply(fontWeightDelta: 30, fontSizeFactor: 1.1),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed:(){Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>FaqPage()));} ,
                  icon: Icon(Icons.help_outline_outlined,size: 25.0,)),
            ],
          ),
          bottomNavigationBar: _getActionButtons(),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.grey[300],
          body: ListView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1),
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(24, 0, 24, 0),
                                        child: new Text(
                                          "Id Number",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .apply(
                                                  fontWeightDelta: 30,
                                                  color: Colors.black,
                                                  fontSizeFactor: 0.7),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(24, 0, 24, 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1)),
                                        ),
                                        child: new TextField(
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .apply(fontSizeFactor: 0.7),
                                          controller: idNumberController,
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "Enter Id Number",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),

Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(24, 0, 24, 0),
                                        child: new Text(
                                          "Id Type",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .apply(
                                                  fontWeightDelta: 30,
                                                  color: Colors.black,
                                                  fontSizeFactor: 0.7),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(24, 0, 24, 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1)),
                                        ),
                                        child: new TextField(
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .apply(fontSizeFactor: 0.7),
                                          controller: idTypeController,
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "Enter Id Type",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Container(
                          //   width: MediaQuery.of(context).size.width,
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children: [
                          //       Container(
                          //         width: MediaQuery.of(context).size.width,
                          //         height:
                          //             MediaQuery.of(context).size.height * 0.1 +
                          //                 5,
                          //         child: Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             Container(
                          //               margin:
                          //                   EdgeInsets.fromLTRB(24, 0, 24, 0),
                          //               child: new Text(
                          //                 "Id Type",
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .headline6
                          //                     .apply(
                          //                         fontWeightDelta: 30,
                          //                         color: Colors.black,
                          //                         fontSizeFactor: 0.7),
                          //               ),
                          //             ),
                          //             SizedBox(height: 5),
                          //             new Container(
                          //               margin:
                          //                   EdgeInsets.fromLTRB(24, 0, 24, 0),
                          //               width:
                          //                   MediaQuery.of(context).size.width,
                          //               // padding: EdgeInsets.fromLTRB(
                          //               //     10, 0, 10, 0),
                          //               decoration: BoxDecoration(
                          //                 border: Border(
                          //                     bottom: BorderSide(
                          //                         color: Colors.grey,
                          //                         width: 1)),
                          //               ),
                          //               height: 40,
                          //               child: DropdownButtonHideUnderline(
                          //                 child: new DropdownButton<String>(
                          //                   value: defaultIdType,
                          //                   items: [
                          //                     'Adhar',
                          //                     'Pancard',
                          //                     "Voter Id",
                          //                     "Driving Liscence"
                          //                   ].map((String value) {
                          //                     return new DropdownMenuItem<
                          //                         String>(
                          //                       value: value,
                          //                       child: new Text(value),
                          //                     );
                          //                   }).toList(),
                          //                   onChanged: (value) {
                          //                     setState(() {
                          //                       defaultIdType = value;
                          //                     });
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border:Border.all(width:2, color:Colors.grey)
                                ),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                          load = false;
                                        });
                                      _choose().then((value) {
                                        file = value;
                                        setState(() {
                                          load = true;
                                        });
                                        // submit();
                                      });
                                    },
                                    child: file == null
                                        ? Column(
                                          children: [
                                            Icon(Icons.chrome_reader_mode, color: Colors.grey, size: MediaQuery.of(context).size.width*0.30,),
                                         Text(
                                          "Select Front\nImage",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .apply(
                                                  fontWeightDelta: 30,
                                                  color: Colors.grey[600],
                                                  fontSizeFactor: 0.7),
                                        ),
                                        SizedBox(height:10)
                                          ],
                                        )
                                        : (load == true
                                            ? Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                child: Image.file(file))
                                            : progress())),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border:Border.all(width:2, color:Colors.grey)
                                ),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                          load2 = false;
                                        });
                                      _choose2().then((value) {
                                        file2 = value;
                                        setState(() {
                                          load2 = true;
                                        });
                                        // submit();
                                      });
                                    },
                                    child: file2 == null
                                        ? Column(
                                          children: [
                                            Icon(Icons.chrome_reader_mode, color: Colors.grey, size: MediaQuery.of(context).size.width*0.30,),
                                         Text(
                                          "Select Back\nImage",
                                                                                    textAlign: TextAlign.center,

                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .apply(
                                                  fontWeightDelta: 30,
                                                  color: Colors.grey[600],
                                                  fontSizeFactor: 0.7),
                                        ),
                                        SizedBox(height:10)
                                          ],
                                        )
                                        : (load2 == true
                                            ? Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                child: Image.file(file2))
                                            : progress())),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [],
                ),
              )
            ],
          )),
    );
  }
}
