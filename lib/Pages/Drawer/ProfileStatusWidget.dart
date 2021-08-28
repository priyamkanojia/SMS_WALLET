import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Controllers/ShimmerController.dart';
import 'package:sms_wallet/Models/AppSettings.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfileStatusWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileStatusWidgetState();
  }
}


class ProfileStatusWidgetState extends State<ProfileStatusWidget> {
  TextEditingController searchCon = new TextEditingController();

  @override
  void initState() {


    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    UserDetails.lstProfileStatus.clear();
   UserDetails.lstProfileStatus.add(
      InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("Full Name"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.fullname!=null&&UserDetails.fullname!="" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.fullname!=null&&UserDetails.fullname!="" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.fullname!=null&&UserDetails.fullname!="" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.perStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );



 UserDetails.lstProfileStatus.add(
       InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("Username"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.username!=null&&UserDetails.username!="" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.username!=null&&UserDetails.username!="" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.username!=null&&UserDetails.username!="" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.perStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );




 UserDetails.lstProfileStatus.add(
       InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("Email"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.email!=null&&UserDetails.email!="" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.email!=null&&UserDetails.email!="" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.email!=null&&UserDetails.email!="" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.perStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );


UserDetails.lstProfileStatus.add(
       InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("Mobile"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.mobile!=null&&UserDetails.mobile!="" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.mobile!=null&&UserDetails.mobile!="" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.mobile!=null&&UserDetails.mobile!="" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.perStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );

UserDetails.lstProfileStatus.add(
       InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("DOB"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.dob!=null&&UserDetails.dob!="" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.dob!=null&&UserDetails.dob!="" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.dob!=null&&UserDetails.dob!="" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.perStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );


UserDetails.lstProfileStatus.add(
       InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("Interest"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.interest!=null&&UserDetails.interest!="" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.interest!=null&&UserDetails.interest!="" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.interest!=null&&UserDetails.interest!="" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.perStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );

  UserDetails.lstProfileStatus.add(
      InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("State"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.state!=null&&UserDetails.state!="" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.state!=null&&UserDetails.state!="" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.state!=null&&UserDetails.state!="" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.perStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );






  UserDetails.lstProfileStatus.add(
      InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("City"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.city!=null&&UserDetails.city!="" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.city!=null&&UserDetails.city!="" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.city!=null&&UserDetails.city!="" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.perStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );


UserDetails.lstProfileStatus.add(
       InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("Address"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.address!=null&&UserDetails.address!="" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.address!=null&&UserDetails.address!="" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.address!=null&&UserDetails.address!="" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.perStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );

UserDetails.lstProfileStatus.add(
      InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("Profile Image"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.profileImage!=null&&UserDetails.profileImage!="" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.profileImage!=null&&UserDetails.profileImage!="" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.profileImage!=null&&UserDetails.profileImage!="" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.perStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );



UserDetails.lstProfileStatus.add(
       InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(("KYC"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 1.0,
                                      color: MyColors.darkBlue,
                                      fontWeightDelta: 30
                                    )),
                       Text((UserDetails.isKycDone!="0" ?"Complete":"Incomplete"),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.subtitle1.apply(
                                      fontSizeFactor: 0.7,
                                      color: UserDetails.isKycDone!="0" ?Colors.green:MyColors.darkred,
                                      fontWeightDelta: 30
                                    )),
                      ],
                    ),
                  ),

                 Container(
                   height: 40,
                   width:40,
                   decoration: BoxDecoration(
                     color:UserDetails.isKycDone!="0" ?Colors.green:Colors.grey,
                     borderRadius: BorderRadius.circular(500)
                   ),
                   child: Center(
                     child: Text(UserDetails.kyCStatePercent.toString()+"%",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.subtitle1.apply(
                                        fontSizeFactor: 0.9,
                                        color: Colors.white,
                                        fontWeightDelta: 30
                                      )),
                   ),
                 )
                ],
              )),
      )
    );

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
         leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: MyColors.darkBlue,
          elevation: 0,
          title: Text(
            "Profile Status",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body:  Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 12, bottom: 60),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < UserDetails.lstProfileStatus.length)
                            return Container(
                                child: UserDetails.lstProfileStatus[index]);
                        },
                      ),
                    ),
                  ],
                )
    );
  }

 
}
