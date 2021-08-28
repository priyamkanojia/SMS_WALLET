import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Controllers/HomeController.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/News.dart';
import 'package:sms_wallet/Models/Pages.dart';
import 'package:sms_wallet/Models/RewardHistory.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';
import 'package:sms_wallet/Models/faq_class.dart';
import 'package:sms_wallet/Pages/Chat/GroupChatWidget.dart';
import 'package:sms_wallet/Pages/Drawer/FeedbackWidget.dart';
import 'package:sms_wallet/Pages/Drawer/FollowUsWidget.dart';
import 'package:sms_wallet/Pages/Drawer/HtmlWidget.dart';
import 'package:sms_wallet/Pages/Drawer/KYCformWidget.dart';
import 'package:sms_wallet/Pages/Drawer/MyTeamListWidget.dart';
import 'package:sms_wallet/Pages/Home/MoneyTransferContactsWidget.dart';
import 'package:sms_wallet/Pages/Drawer/ProfileEditWidget.dart';
import 'package:sms_wallet/Pages/Drawer/ReferAndEarnWidget.dart';
import 'package:sms_wallet/Pages/Home/NewsListWidget.dart';
import 'package:sms_wallet/Pages/Wallet/WalletWidget.dart';
import 'package:sms_wallet/Pages/LoginPage.dart';
import 'package:sms_wallet/Pages/Wallet/RewardHistoryWidget.dart';
import 'package:sms_wallet/Pages/faq.dart';

class ProfileDrawer extends StatefulWidget {
  Function refreshHome;
  @override
  _ProfileDrawerState createState() => _ProfileDrawerState();

  ProfileDrawer({Key key, @required this.refreshHome}) : super(key: key);
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  void refresh() {
    setState(() {
      widget.refreshHome();
    });
  }
  var lstNews;
  var latFaq;
  @override
  void initState(){
    lstNews = HomeController.getNews();
    latFaq = HomeController.getFaq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 200,
              // padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: DrawerHeader(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileEditWidget(
                              updateProfile: refresh,
                            )));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: UserDetails.profileImage !=
                                                      null &&
                                                  UserDetails
                                                          .profileImage.length >
                                                      0
                                              ? NetworkImage(
                                                  Urls.image_urls +
                                                      UserDetails.profileImage,
                                                )
                                              : AssetImage(
                                                  "assets/userprofile.png")))),
                              /*Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  // width: 20,
                                  padding: EdgeInsets.fromLTRB(5, 2, 5, 2),

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: MyColors.darkred),
                                  child: Text(
                                    UserDetails.user_badge.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            fontWeightDelta: 30,
                                            fontSizeFactor: 0.5,
                                            color: Colors.white),
                                  ),
                                ),
                              )*/
                            ],
                          ),
                          new CircularPercentIndicator(
                            radius: 70.0,
                            animation: true,
                            animationDuration: 1800,
                            lineWidth: 7.0,
                            percent: double.parse(
                                    UserDetails.profileStatus.toString()) /
                                100,
                            center: new Text(
                              UserDetails.profileStatus.toString() + "%",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.white),
                            ),
                            circularStrokeCap: CircularStrokeCap.butt,
                            backgroundColor: Colors.white,
                            progressColor: Colors.lightBlue,
                          ),
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                width: MediaQuery.of(context).size.width,
                                child: Text(UserDetails.fullname,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: Colors.white,
                                            fontWeightDelta: 30,
                                            fontSizeFactor: 0.8))),
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                    UserDetails.mobile != ""
                                        ? UserDetails.mobile
                                        : UserDetails.email,
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: Colors.white,
                                            fontSizeFactor: 0.6))),
                          ]),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  // color: MyColors.darkBlue,
                  gradient: new LinearGradient(
                      colors: [
                        MyColors.darkBlue.withOpacity(0.8),
                        MyColors.darkBlue,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
            ),
            (UserDetails.isKycDone == "0" || UserDetails.isKycDone == "1")
                ? InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => KYCformWidget()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: Icon(Icons.circle,
                                        size: 18, color: MyColors.darkred),
                                  ),
                                  Text(
                                    "      " + "Complete KYC",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            fontWeightDelta: 30,
                                            fontSizeFactor: 0.6,
                                            color: Colors.grey[800]),
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox(height:5),
                            Icon(Icons.arrow_forward_ios_rounded,
                                size: 14, color: Colors.grey[800])
                          ]),
                    ),
                  )
                : Container(),
            ///NEWS Section
            FutureBuilder<List<News>>(
                future: lstNews,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => NewsListWidget(lstMessages:snapshot.data)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      child: Icon(Icons.feed_outlined,
                                          size: 18, color: Colors.grey[700]),
                                    ),
                                    Text(
                                      "      " + "News",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .apply(
                                          fontWeightDelta: 30,
                                          fontSizeFactor: 0.6,
                                          color: Colors.grey[800]),
                                    ),
                                  ],
                                ),
                              ),

                              // SizedBox(height:5),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  size: 14, color: Colors.grey[800])
                            ]),
                      ),
                    );
                  }else{
                    return SizedBox();
                  }
                }
            ),
            ///FAQ
            FutureBuilder<List<FaqClass>>(
                future: latFaq,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Faq(lstMessages: snapshot.data)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      child: Icon(Icons.help_outline_outlined,
                                          size: 18, color: Colors.grey[700]),
                                    ),
                                    Text(
                                      "      " + "FAQ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .apply(
                                          fontWeightDelta: 30,
                                          fontSizeFactor: 0.6,
                                          color: Colors.grey[800]),
                                    ),
                                  ],
                                ),
                              ),

                              // SizedBox(height:5),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  size: 14, color: Colors.grey[800])
                            ]),
                      ),
                    );
                  }else{
                    return SizedBox();
                  }
                }
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WalletWidget()));
              },


              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Icon(Icons.account_balance_wallet_rounded,
                                  size: 18, color: Colors.grey[700]),
                            ),
                            Text(
                              "      " + "Wallets",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 0.6,
                                      color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height:5),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 14, color: Colors.grey[800])
                    ]),
              ),
            ),

            InkWell(
              onTap: () {
                if (UserDetails.id != null) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ReferAndEarn()));
                } else {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginWidget()));
                }
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Icon(
                                Icons.share,
                                size: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              "      " + "Refer And Earn",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 0.6,
                                      color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height:5),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 14, color: Colors.grey[800])
                    ]),
              ),
            ),

            /*InkWell(
              onTap: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => ReferAndEarn()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Icon(Icons.format_list_bulleted_outlined,
                                  size: 18, color: Colors.grey[700]),
                            ),
                            Text(
                              "      " + "Tasks",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 0.6,
                                      color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height:5),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 14, color: Colors.grey[800])
                    ]),
              ),
            ),*/
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RewardHistoryWidget()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Icon(
                                Icons.history,
                                size: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              "      " + "Reward History",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 0.6,
                                      color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height:5),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 14, color: Colors.grey[800])
                    ]),
              ),
            ),
            Container(
              child: FutureBuilder<List<Pages>>(
                  future: HomeController.getPages(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return Container(child: listTile(snapshot.data));
                      } else {
                        return Center(child: Container());
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
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    MyColors.darkBlue)),
                          ),
                        ),
                      );
                    }
                  }),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GroupChatWidget()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Icon(Icons.chat,
                                  size: 18, color: Colors.grey[700]),
                            ),
                            Text(
                              "      " + "User Chat Group",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 0.6,
                                      color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height:5),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 14, color: Colors.grey[800])
                    ]),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FeedbackWidget()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Icon(Icons.feedback_sharp,
                                  size: 18, color: Colors.grey[700]),
                            ),
                            Text(
                              "      " + "Feedback",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 0.6,
                                      color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height:5),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 14, color: Colors.grey[800])
                    ]),
              ),
            ),
            /*InkWell(
              onTap: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => ReferAndEarn()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Icon(Icons.list_alt_outlined,
                                  size: 18, color: Colors.grey[700]),
                            ),
                            Text(
                              "      " + "Services",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 0.6,
                                      color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height:5),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 14, color: Colors.grey[800])
                    ]),
              ),
            ),*/
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyTeamListWidget()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Icon(Icons.supervised_user_circle_rounded,
                                  size: 18, color: Colors.grey[700]),
                            ),
                            Text(
                              "      " + "My Team",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 0.6,
                                      color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height:5),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 14, color: Colors.grey[800])
                    ]),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FollowUsWidget()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Icon(Icons.follow_the_signs_outlined,
                                  size: 18, color: Colors.grey[700]),
                            ),
                            Text(
                              "      " + "Follow Us",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 0.6,
                                      color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height:5),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 14, color: Colors.grey[800])
                    ]),
              ),
            ),
            UserDetails.id != null
                ? InkWell(
                    onTap: () async {
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginWidget()),
                          (Route<dynamic> route) => false);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.exit_to_app,
                                      size: 16,
                                      color: MyColors.darkred,
                                    ),
                                  ),
                                  Text(
                                    "      " + "Logout",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            fontWeightDelta: 30,
                                            fontSizeFactor: 0.6,
                                            color: Colors.grey[800]),
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox(height:5),

                            Icon(Icons.arrow_forward_ios_rounded,
                                size: 14, color: Colors.grey[800])
                          ]),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginWidget()));
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.exit_to_app,
                                      size: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text(
                                    "      " + "Login",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            fontWeightDelta: 30,
                                            fontSizeFactor: 0.6,
                                            color: Colors.grey[800]),
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox(height:5),

                            Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.grey[800])
                          ]),
                    ),
                  ),
            //////////////////////////// App Version ///////////////////////////////////
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 80),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "App Version",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      fontWeightDelta: 30,
                                      fontSizeFactor: 0.6,
                                      color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "1.0.7",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .apply(fontWeightDelta: 30, fontSizeFactor: 0.6),
                      ),
                      // SizedBox(height:5),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listTile(List<Pages> page) {
    List<Widget> lstW = [];

    page.forEach((element) {
      lstW.add(InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HtmlWidget(
                    pages: element,
                  )));
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.circle,
                      size: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    "      " + element.pageName,
                    style: Theme.of(context).textTheme.headline6.apply(
                        fontWeightDelta: 30,
                        fontSizeFactor: 0.6,
                        color: Colors.grey[800]),
                  ),
                ],
              ),
            ),

            // SizedBox(height:5),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Colors.grey[800])
          ]),
        ),
      ));
    });
    return Column(children: lstW);
  }
}
