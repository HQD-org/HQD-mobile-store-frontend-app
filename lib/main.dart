import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_store/src/app.dart';
import 'package:mobile_store/src/common/shared_preference_user.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSharedPreference.init();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Color _pimaryColors = HexColor('#3FA5EF');
  Color _accentColor = HexColor('#10B6DB');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HQD Mobile App',
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
