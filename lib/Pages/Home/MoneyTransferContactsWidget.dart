import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_wallet/Controllers/AppSettingsController.dart';
import 'package:sms_wallet/Controllers/WalletController.dart';
import 'package:sms_wallet/Models/MyColors.dart';
import 'package:sms_wallet/Models/Urls.dart';
import 'package:sms_wallet/Pages/Home/MoneyTransferContactDetailWidget.dart';

class MoneyTransferContactsWidget extends StatefulWidget {
  @override
  _MoneyTransferContactsWidgetState createState() =>
      _MoneyTransferContactsWidgetState();
}

class _MoneyTransferContactsWidgetState
    extends State<MoneyTransferContactsWidget> {
  @override
  void initState() {
    super.initState();
    _askPermissions(null);
    lstCont = getContacts();
  }

  Future<List<MyContacts>> lstCont;

  List<MyContacts> lstContacts = [];
  List<MyContacts> lstTemp = [];

  Future<List<MyContacts>> getContacts() async {
    Iterable<Contact> contacts;

    contacts = await ContactsService.getContacts(
      withThumbnails: false,
      photoHighResolution: false,
    );

    setState(() {
      lstContacts.clear();
      lstTemp.clear();
      lstContacts.addAll(contacts.map((e) => MyContacts(
          name: e.displayName,
          phone: e.phones.isNotEmpty ? e.phones.first.value : null,
          image: e.avatar != null && e.avatar.isNotEmpty
              ? Container(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    backgroundImage: MemoryImage(e.avatar),
                  ),
                )
              : Container(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    child: Text(e.initials()),
                    backgroundColor: MyColors.orange,
                  ),
                ))));

      for (var i = 0; i < lstContacts.length; i++) {
        if (lstContacts[i].phone != null &&
            lstContacts[i].name != lstContacts[i].phone) {
          lstTemp
              .removeWhere((element) => element.phone == lstContacts[i].phone);
          lstTemp.add(lstContacts[i]);
        }
      }
      lstContacts.clear();
      lstContacts.addAll(lstTemp);
    });
    return lstTemp;
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {}
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }
bool loading = false;
  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  TextEditingController searchCon = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            'Money Transfer',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: MyColors.darkBlue,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.fromLTRB(10, 2, 5, 2),
                margin: EdgeInsets.only(top: 16),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: MyColors.lightBlue)),
                child: TextField(
                  controller: searchCon,
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {
                      lstTemp.clear();
                      lstTemp.addAll(lstContacts);
                      for (var i = 0; i < lstContacts.length; i++) {
                        if (lstContacts[i]
                                .name
                                .toString()
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            (lstContacts[i].phone != null &&
                                lstContacts[i].phone.contains(value)))
                          lstTemp.removeWhere((element) =>
                              element.phone == lstContacts[i].phone);
                        lstTemp.add(lstContacts[i]);
                      }
                      lstTemp.retainWhere((element) =>
                          element.name
                              .toString()
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          (element.phone != null &&
                              element.phone.contains(value)));

                      if (lstTemp.length == 0) {
                        setState(() {
                          loading = true;
                        });
                        WalletController.getContactsFromSrv(searchCon.text.trim()).then((value) {
                          for (var i = 0; i < value.length; i++) {

                            lstTemp.add(value[i]);
                          }
                          setState(() {
                          loading = false;
                        });
                        });
                      }

                      if(lstTemp.length==0){
                        lstTemp.add(MyContacts(
                          name: "New Number",
                          phone: searchCon.text,
                          image: Container(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    child: Text("N"),
                    backgroundColor: MyColors.orange,
                  ),
                )
                        ));
                      }

                    });
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: Theme.of(context).textTheme.caption.merge(
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[700],
                        size: 24,
                      ),
                      filled: true),
                  onTap: () {},
                ),
              ),
             !loading ? FutureBuilder<List<MyContacts>>(
                  future: lstCont,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                            itemCount: lstTemp?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: FutureBuilder<List<MyContacts>>(
                                      future: WalletController
                                          .getPerticularPhoneStatus(
                                              AppSettingsController
                                                      .phoneWithoutCode(
                                                          lstTemp[index].phone)
                                                  .trim(),
                                              lstTemp.length),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.length > 0) {
                                            lstTemp[index].name =
                                                snapshot.data[0].name;
                                            lstTemp[index].phone =
                                                snapshot.data[0].phone;
                                            lstTemp[index].image =
                                                snapshot.data[0].image;

                                            return ListTile(
                                              onTap: (){
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MoneyTransferContactsDetailWidget(myContacts: lstTemp[index]) ));
                                              },
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 12),
                                                leading: lstTemp[index].image,
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      lstTemp[index].name ?? '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .apply(
                                                              color: MyColors
                                                                  .darkBlue,
                                                              fontWeightDelta:
                                                                  30,
                                                              fontSizeFactor:
                                                                  0.7),
                                                    ),
                                                    Text(
                                                      lstTemp[index].phone ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .apply(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeightDelta:
                                                                  30,
                                                              fontSizeFactor:
                                                                  0.7),
                                                    ),
                                                  ],
                                                ));
                                          } else {
                                            return ListTile(
                                              onTap: (){
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MoneyTransferContactsDetailWidget(myContacts: lstTemp[index]) ));

                                              },
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 12),
                                                leading: lstTemp[index].image,
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      lstTemp[index].name ?? '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .apply(
                                                              color: MyColors
                                                                  .darkBlue,
                                                              fontWeightDelta:
                                                                  30,
                                                              fontSizeFactor:
                                                                  0.7),
                                                    ),
                                                    Text(
                                                      lstTemp[index].phone ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .apply(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeightDelta:
                                                                  30,
                                                              fontSizeFactor:
                                                                  0.7),
                                                    ),
                                                  ],
                                                ));
                                          }
                                        } else {
                                          return Container();
                                        }
                                      }));
                            },
                          ),
                        );
                      } else {
                        return Container(
                            height: (((MediaQuery.of(context).size.width / 6) +
                                        32) *
                                    3) +
                                32 +
                                MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: Text("No Contact Found")));
                      }
                    } else {
                      return Container(
                          height:
                              (((MediaQuery.of(context).size.width / 6) + 32) *
                                      3) +
                                  32 +
                                  MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width,
                          child: SpinKitThreeBounce(
                            color: MyColors.darkBlue,
                            size: 32,
                          ));
                    }
                  }):Container(
                          height:
                              (((MediaQuery.of(context).size.width / 6) + 32) *
                                      3) +
                                  32 +
                                  MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width,
                          child: SpinKitThreeBounce(
                            color: MyColors.darkBlue,
                            size: 32,
                          ))
            ],
          ),
        ));
  }
}

class MyContacts {
  String name;
  String phone;
  Widget image;
  MyContacts({this.name, this.phone, this.image});
  MyContacts.fromJson(Map<String, dynamic> json) {
    name = json['fullname'];
    phone = json['mobile'];
    image = Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
            image: json['profile_image'] != null
                ? NetworkImage(Urls.image_urls + json['profile_image'])
                : AssetImage("assets/userprofile.png"),
            fit: BoxFit.cover),
      ),
    );
  }
}
