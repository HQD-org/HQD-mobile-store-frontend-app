import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/product_model.dart';

class ItemCart extends StatefulWidget {
  final Product item;
  ItemCart({required this.item});
  @override
  State<StatefulWidget> createState() {
    return _ItemCartState();
  }
}

class _ItemCartState extends State<ItemCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    image: NetworkImage('${widget.item.imageURL}'),
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
                        "${widget.item.productName}",
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
                            Icons.cancel,
                            color: Colors.red,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Ram-Dung lượng: "),
                    Text("6GB-256GB"),
                  ],
                ),
                Row(
                  children: [
                    Text("Màu: "),
                    Text("Đen"),
                  ],
                ),
                Row(
                  children: [
                    Text("Giá tiền: "),
                    Text("${widget.item.price}-VNĐ")
                  ],
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
                                "${widget.item.coupon}",
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
                Row(
                  children: [
                    Text(
                      'Số lượng',
                      style: TextStyle(),
                    ),
                    Spacer(),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        // splashColor: ,
                        onTap: () {
                          print("Giảm");
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.remove,
                              color: Colors.red,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 12,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.purple,
                            Colors.pink,
                          ], stops: [
                            0.0,
                            0.7
                          ]),
                        ),
                        child: Text(
                          '1',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {
                          print("Tăng");
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
