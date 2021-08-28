import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TawkSupport extends StatefulWidget {
  @override
  _TawkSupportState createState() => _TawkSupportState();
}

class _TawkSupportState extends State<TawkSupport> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: 'https://tawk.to/chat/611621d9d6e7610a49afff88/1fcv78fc5',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
