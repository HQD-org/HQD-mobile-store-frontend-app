import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_store/src/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color _pimaryColors = HexColor('#3FA5EF');
  Color _accentColor = HexColor('#10B6DB');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          accentColor: _accentColor,
          primaryColor: _pimaryColors,
          //scaffoldBackgroundColor: Colors.grey,
        ),
        home: AppMobileStore());
  }
}
