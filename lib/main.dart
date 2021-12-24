import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_store/src/app.dart';
import 'package:mobile_store/src/common/shared_preference_user.dart';
import 'package:mobile_store/src/providers/product_provider.dart';
import 'package:mobile_store/src/providers/user_provider.dart';
import 'package:mobile_store/src/screens/Order/history_order_screen.dart';
import 'package:mobile_store/src/screens/cart/cart_screen.dart';
import 'package:mobile_store/src/screens/home.dart';
import 'package:provider/provider.dart';

int time = 2;
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => userProvider,
        ),
        ChangeNotifierProvider<ProductProvider>(
            create: (context) => productProvider),
      ],
      child: MaterialApp(
        title: 'HQD Mobile App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          accentColor: _accentColor,
          primaryColor: _pimaryColors,
          dividerColor: Colors.black,
          appBarTheme:
              AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
          //scaffoldBackgroundColor: Colors.grey,
        ),
        home: AppMobileStore(),
        //initialRoute: '/',
        routes: {
          'home': (context) => MyHomePage(),
          'cart': (context) => CartScreen(),
          'history': (context) => HistoryOrderScreen(),
        },
      ),
    );
  }
}
