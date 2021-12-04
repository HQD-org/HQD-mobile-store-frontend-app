import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile_store/src/models/product_model_s.dart';
import 'package:mobile_store/src/screens/product_detail_sceen.dart';

class ProductCardGrid extends StatefulWidget {
  final ProductModel productCartGrid;

  ProductCardGrid({required this.productCartGrid});
  @override
  State<StatefulWidget> createState() {
    return _ProductCardGridScreen();
  }
}

class _ProductCardGridScreen extends State<ProductCardGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: () {
            print('chào ${widget.productCartGrid.name}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                          product: widget.productCartGrid,
                        )));
          },
          child: Container(
            padding: EdgeInsets.only(left: 10.0, top: 2.0),
            decoration: BoxDecoration(color: Colors.red[100]),
            height: 250,
            width: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.network(
                      widget.productCartGrid.model.color[0].images[0],
                      height: 140.0,
                      width: 180.0,
                      fit: BoxFit.cover,
                      alignment: Alignment
                          .center, // cái này làm cho ảnh resize hết khung chứa
                    ),
                    Align(
                        // biểu tượng favorite trên Product_card
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(100)),
                          child: IconButton(
                            onPressed: () {
                              print(
                                  'Thích sản phẩm ${widget.productCartGrid.name}');
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 28,
                            ),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(right: 5.0),
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Text(
                            "4.5",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.productCartGrid.name}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "${widget.productCartGrid.color[0].price}-VNĐ",
                        style: TextStyle(fontSize: 16, color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
