import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Models/UserDetails.dart';

Future<Album> fetchAlbum() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('id');
  var api_token = prefs.getString('api_token');
  final response =
  await http.get(Uri.parse('https://wallet.jainalufoils.com/api/kyc_data/$id'),headers: {"api-token":api_token});
  // http.get('https://jsonplaceholder.typicode.com/albums/1');
  // var response =

// Appropriate action depending upon the
// server response
  if (response.statusCode == 200) {
    print(response.body);
    return Album.fromJson(json.decode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('Failed to load album');
  }
}

class Album {
  final String user_id;
  final String document_number;
  final String front;
  final String back;
  final String message;
  final String id_type;

Album({this.user_id,this.document_number,this.front,this.back,this.message,this.id_type});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      user_id: json['user_id'],
      document_number: json['document_number'],
      front: json['front'],
      back: json['back'],
      message: json['message'],
      id_type: json['id_type'],
      );
  }
}

class GetKycDetails extends StatefulWidget {
  //GetKycDetails({Key key}) : super(key: key);

  @override
  _GetKycDetailsState createState() => _GetKycDetailsState();
}

class _GetKycDetailsState extends State<GetKycDetails> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetching Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('KYC'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.document_number);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
