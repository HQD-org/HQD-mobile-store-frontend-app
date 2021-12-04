import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/brand_model.dart';
import 'package:mobile_store/src/screens/brands/brand_detail_screen.dart';

class BrandCardScreen extends StatelessWidget {
  final BrandModel brand;
  BrandCardScreen({required this.brand});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                brand.image,
                height: 100, // lấy chiều cao đc truyền vào
                width: 170, // lấy chiều rộng đc truyền vào
                fit: BoxFit.cover, // cái này làm cho ảnh resize hết khung chứa
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${brand.name}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 7.0,
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        print('Chào ${brand.name}');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BrandDetailScreen(
                  brand: brand,
                )));
      },
    );
  }
}
