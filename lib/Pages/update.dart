import 'dart:async';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
/*
const APP_STORE_URL =
    'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
const PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=YOUR-APP-ID';

versionCheck(context) async {
  //Get Current installed version of app
  final PackageInfo info = await PackageInfo.fromPlatform();
  double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

  //Get Latest version info from firebase config
  final RemoteConfig remoteConfig = await RemoteConfig.instance;

  try {
    // Using default duration to force fetching from remote server.
    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();
    remoteConfig.getString('force_update_current_version');
    double newVersion = double.parse(remoteConfig
        .getString('force_update_current_version')
        .trim()
        .replaceAll(".", ""));
    if (newVersion > currentVersion) {
      _showVersionDialog(context);
    }
  } on FetchThrottledException catch (exception) {
    // Fetch throttled.
    print(exception);
  } catch (exception) {
    print('Unable to fetch remote config. Cached or default values will be '
        'used');
  }
}
//Show Dialog to force user to update
_showVersionDialog(context) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      String title = "New Update Available";
      String message =
          "There is a newer version of app available please update it now.";
      String btnLabel = "Update Now";
      String btnLabelCancel = "Later";
      return Platform.isIOS
          ? new CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(btnLabel),
            onPressed: () => _launchURL(null),
          ),
          FlatButton(
            child: Text(btnLabelCancel),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      )
          : new AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(btnLabel),
            onPressed: () => _launchURL('https://play.google.com/store/apps/details?id=com.walletsms.selfmadesociety'),
          ),
          FlatButton(
            child: Text(btnLabelCancel),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
*/

/*class UpdateApp extends StatefulWidget {
  @override
  _UpdateAppState createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp> {
  AppUpdateInfo _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = true;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }
  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('In App Update Example App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text('Update info: $_updateInfo'),
              ),
              ElevatedButton(
                child: Text('Check for Update'),
                onPressed: () => checkForUpdate(),
              ),
              ElevatedButton(
                child: Text('Perform immediate update'),
                onPressed: _updateInfo?.updateAvailability ==
                    UpdateAvailability.updateAvailable
                    ? () {
                  InAppUpdate.performImmediateUpdate()
                      .catchError((e) => showSnack(e.toString()));
                }
                    : null,
              ),
              ElevatedButton(
                child: Text('Start flexible update'),
                onPressed: _updateInfo?.updateAvailability ==
                    UpdateAvailability.updateAvailable
                    ? () {
                  InAppUpdate.startFlexibleUpdate().then((_) {
                    setState(() {
                      _flexibleUpdateAvailable = true;
                    });
                  }).catchError((e) {
                    showSnack(e.toString());
                  });
                }
                    : null,
              ),
              ElevatedButton(
                child: Text('Complete flexible update'),
                onPressed: !_flexibleUpdateAvailable
                    ? (){
                  _launchURL('https://play.google.com/store/apps/details?id=com.walletsms.selfmadesociety');
                }
                    : () {
                  InAppUpdate.completeFlexibleUpdate().then((_) {
                    showSnack("Success!");
                  }).catchError((e) {
                    showSnack(e.toString());
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}*/