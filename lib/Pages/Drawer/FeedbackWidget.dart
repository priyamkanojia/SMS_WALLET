import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/UserDetails.dart';

import '../../ad_state.dart';

class FeedbackWidget extends StatefulWidget {

  FeedbackWidget();
  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    subjectController.text=UserDetails.fullname;
    super.initState();
  }

  Widget progress() {
    return Center(
      child: SpinKitThreeBounce(color: MyColors.orange,size: 32,),
    );
  }

  bool _saving = false;
  void submit() {
    setState(() {
      _saving = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: _saving,
        progressIndicator: progress(),
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Feedback",
                style: Theme.of(context).textTheme.headline6.apply(color:Colors.white),
              ),
              backgroundColor: MyColors.darkBlue,
              iconTheme: Theme.of(context).iconTheme.merge(IconThemeData(color: Colors.white)),
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: ShowBannerAdd(),
            body: SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Container(
                  // height: 60,
                  padding: EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color:MyColors.lightBlue
                  ),
                  child: Text(UserDetails.fullname,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 24),
                Container(
                  child: TextField(
                    controller: descriptionController,
                    maxLines: 6,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MyColors.darkBlue, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Message',
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    onPressed: () {
                      if (descriptionController.text.trim() != "" &&
                          descriptionController.text.trim() != null) {
                        submit();
                        AppSettingsController.feedback(descriptionController.text)
                            .then((value) {
                          if (value == "success") {
                            Fluttertoast.showToast(
                                msg: "Feedback Submited SuccessFully.",
                                backgroundColor: MyColors.darkBlue.withOpacity(0.8),
                                textColor: Colors.white);

                            setState(() {
                              descriptionController.clear();
                              _saving = false;
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Server Error, Try After Sometime.",
                            backgroundColor: MyColors.darkred.withOpacity(0.7),
                            textColor: Colors.white);
                            setState(() {
                              _saving = false;
                            });
                          }
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Message Required!",
                            backgroundColor: MyColors.darkred.withOpacity(0.7),
                            textColor: Colors.white);
                      }
                    },
                    child: Text(
                      "Submit",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.white),
                    ),
                    color: MyColors.darkBlue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor)),
                  ),
                ),
                SizedBox(height: 12),
                
                                        SizedBox(height:120),
              ]),
            ))));
  }

 
}
