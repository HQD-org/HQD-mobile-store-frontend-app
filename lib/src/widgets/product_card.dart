import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:mobile_store/src/models/product_model_s.dart';
import 'package:mobile_store/src/screens/product_detail_sceen.dart';

class ProductCard extends StatefulWidget {
  final ProductModel productCart;
  final double w;
  final double h;
  ProductCard({required this.productCart, required this.w, required this.h});
  @override
  State<StatefulWidget> createState() {
    return _ProductCardScreen();
  }
}

class _ProductCardScreen extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          SizedBox(
            height: 5.0,
          ),
          Stack(
            children: [
              Image.network(
                widget.productCart.model.color[0].images[0],
                height: widget.h, // lấy chiều cao đc truyền vào
                width: widget.w, // lấy chiều rộng đc truyền vào
                fit: BoxFit.cover, // cái này làm cho ảnh resize hết khung chứa
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
                        print('Thích sản phẩm ${widget.productCart.name}');
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
                  "${widget.productCart.name}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 7.0,
                ),
                Text(
                  "${widget.productCart.color[0].price}-VNĐ",
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.sell,
                      size: 18.0,
                      color: Colors.purple,
                    ),
                    Text(
                      "0%",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      product: widget.productCart,
                    )));
      },
    );
  }
}
