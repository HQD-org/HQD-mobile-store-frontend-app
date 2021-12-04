import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile_store/src/screens/home.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MyHomePage()),
    );
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'asset/intro/payment.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('asset/intro/$assetName', width: width);
  }

  List<String> brandImages = ["apple.png", "samsung.png", "xiaomi.png"];

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('flutter.png', 100),
      //     ),
      //   ),
      // ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Mua ngay',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(onPrimary: Colors.blue),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "HQD Mobile store",
          body: "Đại lí phân phối điện thoại đi động tại miền Nam",
          image: Image.asset(
            "asset/banner/iconapp.png",
            width: 350,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Các sản phẩm",
          body:
              "Kinh doanh các dòng smart phone của các hãng điện thoại nổi tiếng.",
          image: _buildImage('blackfriday.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Một số thương hiệu liên kết",
          // body:
          //     "HQD liên kết với một số thương hiệu nổi tiếng như Oppo, Samsung, Apple...",
          bodyWidget: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "HQD liên kết với một số thương hiệu nổi tiếng như Oppo, Samsung, Apple...",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 5.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: 100,
                        child: Image.asset(
                          'asset/intro/${brandImages[0]}',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Image.asset(
                          'asset/intro/${brandImages[1]}',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Image.asset(
                          'asset/intro/${brandImages[2]}',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          image: _buildImage('brandimage.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Thanh toán",
          // body:
          //     "Hình thức thanh đa dạng.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
          bodyWidget: Container(
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hình thức thanh toán đa dạng",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "*Chấp nhận thanh toán COD",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "*Chấp nhận thanh toán online (visa, credit)",
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      child: Image.asset(
                        "asset/intro/cod.png",
                        height: 50,
                        width: 40,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Container(
                      width: 70,
                      child: Image.asset(
                        "asset/intro/visa.png",
                        height: 50,
                        width: 40,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Container(
                      width: 70,
                      child: Image.asset(
                        "asset/intro/credit.png",
                        height: 50,
                        width: 40,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          image: _buildFullscrenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Mua hàng ngay",
          body: "Nhanh tay đặt hàng để nhận nhiều ưu đãi",
          image: _buildImage('shopping.png'),
          footer: ElevatedButton(
            onPressed: () {
              //introKey.currentState?.animateScroll(0);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MyHomePage()),
              );
            },
            child: const Text(
              'Mua ngay',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        // PageViewModel(
        //   title: "Title of last page - reversed",
        //   bodyWidget: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const [
        //       Text("Click on ", style: bodyStyle),
        //       Icon(Icons.edit),
        //       Text(" to edit a post", style: bodyStyle),
        //     ],
        //   ),
        //   decoration: pageDecoration.copyWith(
        //     bodyFlex: 2,
        //     imageFlex: 4,
        //     bodyAlignment: Alignment.bottomCenter,
        //     imageAlignment: Alignment.topCenter,
        //   ),
        //   image: _buildImage('blackfriday.png'),
        //   reverse: true,
        // ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'Skip',
        style: TextStyle(fontSize: 16, color: Colors.blue),
      ),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.green, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
