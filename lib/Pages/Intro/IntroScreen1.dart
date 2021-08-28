import 'package:flutter/material.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/Urls.dart';

Container introScren1(context) {
  return Container(
             width:MediaQuery.of(context).size.width,
            //  height:MediaQuery.of(context).size.height,
             child:Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children:[
                                  SizedBox(height:MediaQuery.of(context).size.height*0.05),
Container(
                   width:MediaQuery.of(context).size.width,
                   child: Text(Urls.intr_1_title, 
                   textAlign: TextAlign.center,
                   style: Theme.of(context).textTheme.headline6.apply(fontSizeFactor: 1.3,color:Colors.black, fontWeightDelta: 30, fontFamily: 'Poppins'),),
                 ),
                 SizedBox(height:MediaQuery.of(context).size.height*0.02),
                 Container(
                   width: MediaQuery.of(context).size.height*0.3,
                   height: MediaQuery.of(context).size.height*0.3,
                  //  padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      // color:Colors.black.withOpacity(0.4)
                    ),
                     child:Image.asset("assets/logo.png")
                 ),
                                  SizedBox(height:MediaQuery.of(context).size.height*0.03),

                 
                 Container(
                   width:MediaQuery.of(context).size.width,
                   child: Text(Urls.intr_1_description, textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline6.apply(fontSizeFactor: 0.7,color:Colors.black.withOpacity(0.6), fontWeightDelta: 30, fontFamily: 'Poppins'),),
                 ),

               ]
             )
           );
}
