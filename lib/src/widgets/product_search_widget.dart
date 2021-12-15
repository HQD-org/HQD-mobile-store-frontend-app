import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/product_model_s.dart';
import 'package:mobile_store/src/screens/product_detail_sceen.dart';

class ProductSearchScreen extends StatefulWidget {
  final ProductModel product;
  ProductSearchScreen({required this.product});
  @override
  State<StatefulWidget> createState() {
    return _ProductSearchScreenState();
  }
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      product: widget.product,
                    )));
      },
      child: Container(
        height: 170,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0)),
          border: Border.all(color: Colors.red, width: 1.6),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 135,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          NetworkImage(widget.product.model.color[0].images[0]),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 5.0,
            ),
            Flexible(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "${widget.product.name}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32.0),
                          // splashColor: ,
                          onTap: () {
                            print("xóa sản phẩm");
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.sim_card_download,
                              color: Colors.yellow[500],
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Ram-Dung lượng: "),
                      Text("${widget.product.ram}-${widget.product.capacity}"),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text("Màu: "),
                      Text("${widget.product.color[0].name}"),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text("Giá tiền: "),
                      Text("${widget.product.color[0].price}-VNĐ")
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Đánh giá",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5.0),
                        padding: EdgeInsets.all(4.0),
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 12,
                            ),
                            Text(
                              "4.5",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            "Giảm giá",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            padding: EdgeInsets.all(4.0),
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 2, color: Colors.red),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.sell,
                                  color: Colors.purple,
                                  size: 12,
                                ),
                                Text(
                                  "0%",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
