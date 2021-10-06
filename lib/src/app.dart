import 'package:flutter/cupertino.dart';
import 'package:mobile_store/src/screens/splash_screen.dart';

class AppMobileStore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppMobileStore();
  }
}

class _AppMobileStore extends State<AppMobileStore> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: "Mobile Store",
    );
  }
}
