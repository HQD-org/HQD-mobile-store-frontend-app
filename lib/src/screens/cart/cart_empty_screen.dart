import 'package:flutter/material.dart';
import 'package:mobile_store/src/screens/home.dart';

class CartEmptyScreenState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.all(15.0),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('asset/banner/emptycart.png'),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Giỏ hàng trống',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: (Colors.black),
                fontSize: 36,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Tích cực mua hàng tại HQD để nhận được nhiều ưu đãi',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              onPressed: () {
                print("Chuyển sang trang Home");
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.red),
                  ),
                  onPrimary: Colors.red),
              child: Text(
                'Mua hàng ngay'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
