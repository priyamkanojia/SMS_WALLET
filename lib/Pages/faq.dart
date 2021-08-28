import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/faq_class.dart';
import 'package:sms_wallet/Pages/Drawer/html_view.dart';
import 'package:sms_wallet/ad_state.dart';

class Faq extends StatefulWidget {
  List<FaqClass> lstMessages;
  Faq({@required this.lstMessages});
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            "FAQ",
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      bottomNavigationBar: ShowBannerAdd(),
      body:Container(
          decoration: BoxDecoration(),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            padding: EdgeInsets.only(top: 16),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _product(widget.lstMessages),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ],
              ),
            ],
          ))
    );
  }
  Widget _product(List<FaqClass> item){
    List<Widget> lstW = [];
    for(var i =0; i<item.length;i++){
      lstW.add(
        Column(
          children: [
            ExpandablePanel(
              header: Text(item[i].subject,style: TextStyle(fontWeight: FontWeight.bold,color:MyColors.darkBlue),),
              expanded: NewHtmlView(content: item[i].description),
              hasIcon: true,
              tapHeaderToExpand: true,
            ),
            Divider(height: 10.0,),
            SizedBox(height: 4.0,),
          ],
        )
        );
    }
    return Column(children: lstW.reversed.toList(),);
  }
}


class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  String faqDesc=' ';
  faq() async {
    try{
      var response =await http.get(Uri.parse(Urls.base_url + "pages"),headers: {"Auth-key":Urls.auth_key});
      if(response.statusCode==200){
        setState(() {
          faqDesc=jsonDecode(response.body)[1]['description']; //1.description
        });
        print(response.body);
      }
      else{
        print(response.statusCode);
      }
    }catch(e){
      print(e);
    }
  }
  @override
  void initState(){
    faq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size:22), onPressed: () {Navigator.pop(context);},
                ),
                backgroundColor: MyColors.darkBlue,
                elevation: 0.0,
                title: Text(
                  'FAQ',style: Theme.of(context).textTheme.headline6.apply(fontWeightDelta: 30, fontSizeFactor: 0.9, color:Colors.white),
                ),
                ),
                body: SingleChildScrollView(
                  child: NewHtmlView(content: faqDesc),
                ),
    );
  }
}
