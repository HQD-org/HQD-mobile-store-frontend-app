import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile_store/src/models/product_model_s.dart';
import 'package:mobile_store/src/providers/product_provider.dart';
import 'package:mobile_store/src/repository/brand_repo.dart';
import 'package:mobile_store/src/screens/coupon/coupon_screen.dart';
import 'package:mobile_store/src/screens/products/products_creen.dart';
import 'package:mobile_store/src/widgets/brand_card.dart';
import 'package:mobile_store/src/widgets/product_card.dart';
import 'package:mobile_store/src/widgets/product_card_gridview.dart';
import 'package:provider/provider.dart';

final List<String> imgList = [
  'asset/banner/bannera.jpg',
  'asset/banner/bannerb.jpg',
  'asset/banner/bannerb.jpg',
  'asset/banner/bannerd.jpg',
  'asset/banner/bannere.jpg',
];

final List<String> couponImageList = [
  'asset/banner/coupona.jpg',
  'asset/banner/couponb.jpg',
  'asset/banner/couponc.jpg',
  'asset/banner/coupone.jpg',
];
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'Thỏa sức mua sắm tại HQD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();
final List<Widget> couponSliders = couponImageList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'Deal Hot HQD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  // Stream<List<BrandModel>?> getListBrand() async* {
  //   yield await BrandRepository().getAllBrandAPI();
  // }

  getdataBrand() async {
    return BrandRepository().getAllBrandAPI();
  }

  // getAllProduct() async {
  //   return ProductRepository().getAllProduct();
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    List<ProductModel>? listDataProduct = provider.getAllProduct;

    return SafeArea(
      // padding: EdgeInsets.all(10.0),
      minimum: EdgeInsets.all(5.0),
      child: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              scrollDirection: Axis.vertical,
              autoPlay: true,
            ),
            items: imageSliders,
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Các mã giảm giá",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green[400]),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CouponScreen()));
                      print('Xem tất cả các mả giảm giá');
                    },
                    child: Text('View All'))
              ],
            ),
            height: 50.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              scrollDirection: Axis.vertical,
              autoPlay: true,
            ),
            items: couponSliders,
          ),
          // có 2 cách xử lý trong trường hợp scroll trong widget Column
          // 1 - thêm 2 thuộc tính shrinkWrap: true và  physics: ScrollPhysics(), vào Widget ListView
          // 2 - bỏ Widget ListView() vào trong Widget SizedBox()
          SizedBox(
            height: 18.0,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sản phẩm nổi bật",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green[400]),
                    ),
                    onPressed: () {
                      print('Xem tất cả sản phẩm nổi bật');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductsScreen(
                                title: "Sản phẩm nổi bật",
                              )));
                    },
                    child: Text('View All'))
              ],
            ),
            height: 50.0,
          ),

          SizedBox(
              height: 230,
              child: listDataProduct == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: 8, //listDataProduct.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150.0,
                          width: 180.0,
                          margin: EdgeInsets.only(right: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber[50],
                              border: Border.all(
                                width: 0.35,
                              )),
                          child: ProductCard(
                            productCart: listDataProduct[index],
                            w: 180.0,
                            h: 150.0,
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    )),
          SizedBox(
            height: 15.0,
          ),
          SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trending",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[400])),
                      onPressed: () {
                        print('Xem tất cả sản phẩm Trending');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                                  title: "Sản phẩm Trending",
                                )));
                      },
                      child: Text('View All'))
                ],
              ),
              height: 50.0),
          // Grid view cho product
          SizedBox(
              child: listDataProduct == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 8.0,
                      ),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ProductCardGrid(
                          productCartGrid: listDataProduct[index],
                        );
                      },
                      itemCount: 8, //listDataProduct.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                    )),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Các thương hiệu nổi bật",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            height: 50,
          ),
          SizedBox(
            height: 160,
            child: FutureBuilder(
              future: getdataBrand(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey),
                          ),
                          margin: EdgeInsets.all(5.0),
                          height: 100,
                          width: 170,
                          child: BrandCardScreen(
                            brand: snapshot.data[index],
                          ),
                        );
                      });
                }
              },
            ),
          ),
          SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}

/*Container(
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
            autoPlay: true,
          ),
          items: imageSliders,
        ),
      ), 
      Container(
            margin: EdgeInsets.all(15.0),
            child: ListView(
              children: [
                ListTile(
                  title: Text("Đỉ me mày"),
                ),
                ListTile(
                  title: Text("Đỉ me mày"),
                ),
                ListTile(
                  title: Text("Đỉ me mày"),
                ),
              ],
            ),
          ),
      
      */