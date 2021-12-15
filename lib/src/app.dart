import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobile_store/main.dart';
import 'package:mobile_store/src/common/shared_preference_user.dart';
import 'package:mobile_store/src/providers/product_provider.dart';
import 'package:mobile_store/src/repository/product_repository.dart';

import 'package:mobile_store/src/screens/introductionApp/introduction_screen.dart';
import 'package:mobile_store/src/screens/login_screen.dart';
import 'package:mobile_store/src/screens/splash_screen.dart';

class AppMobileStore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppMobileStore();
  }
}

class _AppMobileStore extends State<AppMobileStore> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void startTime() async {
    var oneSec = Duration(milliseconds: 3000);
    await ProductRepository().getAllProduct().then((value) {
      if (value != null) {
        productProvider.setAllProduct = value;
      }
    });
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (time <= 0) {
            _timer!.cancel();
          } else {
            time--;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return time > 0
        ? SplashScreen(
            title: "Mobile Store",
          )
        : UserSharedPreference.getAccessToken() != null
            ? OnBoardingPage() // chuyển tới trang giới thiệu
            : LoginScreen();
  }
}
