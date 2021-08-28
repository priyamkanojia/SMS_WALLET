import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sms_wallet/Models/MyColors.dart';

class ErrorssWidget extends StatefulWidget {
  ErrorssWidget({@required this.parameter, @required this.from});
  String parameter, from;
  @override
  _ErrorssWidgetState createState() => _ErrorssWidgetState();
}

class _ErrorssWidgetState extends State<ErrorssWidget> {
  bool _saving = false;

  void submit() {
    setState(() {
      _saving = true;
    });
  }

  Widget progress() {
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MyColors.darkBlue)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      progressIndicator: progress(),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // decoration: new BoxDecoration(
              //   image: new DecorationImage(
              //     image: new AssetImage('assets/logoRed.png'),
              //     fit: BoxFit.fill,
              //   ),
              // ),
              // ),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 96),
                    child: Container(
                      height: 160,
                      child: Image.asset("assets/logo.png",)),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 13, right: 13, top: 0, bottom: 16),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20 ,40,20,40),
                    //  height: MediaQuery.of(context).size.height*0.5,
                    decoration: BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(8.0)),),
                    child: Column(
                      children: [
                        Icon(Icons.warning, color: Colors.lime[900], size: 60,),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.parameter,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        
                       
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
