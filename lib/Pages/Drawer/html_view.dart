import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/style.dart';

class NewHtmlView extends StatelessWidget {
  NewHtmlView({@required this.content});
  String content = '';
  //final  htmlData = r""" content """;
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(left:0),
      padding: EdgeInsets.only(left:0),
      child: Html(data: content,
        //shrinkWrap: true,
        style: {
          'html' : Style(
              backgroundColor: Colors.white12,
          ),
          'table': Style(
              backgroundColor: Colors.grey.shade200
          ),
          'td': Style(
            backgroundColor: Colors.grey.shade400,
            //padding: EdgeInsets.all(6),
          ),
          'th': Style(
              //padding: EdgeInsets.all(6),
              color: Colors.black
          ),
          'tr': Style(
              backgroundColor: Colors.grey.shade300,
              border: Border(bottom: BorderSide(color: Colors.greenAccent))
          ),
          'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
        },
        onLinkTap: (url, _, __, ___){
          _launchURL(url);
          print('Open the url $url......');
        },
        onImageTap: (src, _, __, ___){
          print('Image $src');
        },
        onImageError: (exception, stacktrace){
          print(exception);
        },
      ),
    );
  }
}

class HtmlViewShort extends StatelessWidget {
  HtmlViewShort({@required this.content});
  String content = '';
  //final  htmlData = r""" content """;
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(left:0),
      padding: EdgeInsets.only(left:0),
      child: Html(data: content,
        //shrinkWrap: true,
        style: {
          'html' : Style(
            backgroundColor: Colors.white12,maxLines: 1,fontSize:FontSize(12.0),textAlign:TextAlign.left,
          ),
          'table': Style(
              backgroundColor: Colors.grey.shade200
          ),
          'td': Style(
            backgroundColor: Colors.grey.shade400,
            //padding: EdgeInsets.all(6),
          ),
          'th': Style(
            //padding: EdgeInsets.all(6),
              color: Colors.black
          ),
          'tr': Style(
              backgroundColor: Colors.grey.shade300,
              border: Border(bottom: BorderSide(color: Colors.greenAccent))
          ),
          'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
        },
        onLinkTap: (url, _, __, ___){
          _launchURL(url);
          print('Open the url $url......');
        },
        onImageTap: (src, _, __, ___){
          print('Image $src');
        },
        onImageError: (exception, stacktrace){
          print(exception);
        },
      ),
    );
  }
}
