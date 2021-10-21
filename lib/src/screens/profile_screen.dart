import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_store/src/common/shared_preference_user.dart';
import 'package:mobile_store/src/widgets/header_widget.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  String repoUser;
  ProfileScreen({required this.repoUser});
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _drawerIconSize = 24;
  var token = UserSharedPreference.getAccessToken();
  getDataUser(int value) {
    // 1: Name
    // 2: phone
    // 3: email
    // 4: address
    var data = jsonDecode(widget.repoUser);
    var name = data['data']['user']['name'];
    var email = data['data']['user']['email'];
    var phone = data['data']['user']['phone'];
    var address = data['data']['user']['address']['detail'];
    var province = data['data']['user']['address']['province'];
    //print('${data['data']['user']['address']['detail']}');
    switch (value) {
      case 1:
        return name;
      case 2:
        return phone;
      case 3:
        return email;
      case 4:
        return address + ",  " + province;
      default:
        return "Not known";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Profile",
          style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor
              ])),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 14, right: 14),
            child: Stack(
              children: [
                IconButton(
                    onPressed: () {
                      print("Xem notification");
                    },
                    icon: Icon(Icons.notifications)),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints:
                        BoxConstraints(minWidth: 14.0, minHeight: 14.0),
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Theme.of(context).accentColor.withOpacity(0.2),
                  Colors.white
                ]),
          ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Theme.of(context).primaryColor.withOpacity(0.2),
                        Theme.of(context).accentColor.withOpacity(0.7)
                      ]),
                ),
                child: Container(
                  child: Text(
                    "${getDataUser(3)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  size: _drawerIconSize,
                  color: Colors.purple.withOpacity(0.8),
                ),
                title: Text(
                  "Home Page",
                  style: TextStyle(
                      fontSize: 17, color: Colors.purple.withOpacity(0.8)),
                ),
                onTap: () {
                  print("Chuyển đến Home Page");
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100.0,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 10.0, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 20,
                            offset: const Offset(5, 5))
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    getDataUser(1),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "khách hàng",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              ...ListTile.divideTiles(
                                color: Colors.grey,
                                tiles: [
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    leading: Icon(Icons.my_location),
                                    title: Text("Location"),
                                    subtitle: Text("${getDataUser(4)}"),
                                    onTap: () {},
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.email),
                                    title: Text("Email"),
                                    subtitle: Text("${getDataUser(3)}"),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.phone),
                                    title: Text("Phone"),
                                    subtitle: Text("${getDataUser(2)}"),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // khúc này bắt getAuth API
  Future<http.Response> getAuthAPI() async {
    var url = 'hqd-mobile-store-api.herokuapp.com';
    var token = UserSharedPreference.getAccessToken();
    // Authorization
    var response = await http.get(Uri.https(url, "/auth/get-auth"), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    return response;
  }
}


// var status = await getAuthAPI();
//print('getAuth: ${status.statusCode}');
//if (status.statusCode == 200) {
//var data = jsonDecode(status.body);
//print('${status.body}');
//} else if (status.statusCode == 403) {
//print("lỗi getAuth");
//} else {
//print("Lỗi getAuthen");
//}