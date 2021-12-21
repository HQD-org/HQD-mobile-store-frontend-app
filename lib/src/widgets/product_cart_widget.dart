import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/data_product_model.dart';
import 'package:mobile_store/src/models/product_cart_model.dart';
import 'package:mobile_store/src/providers/user_provider.dart';
import 'package:mobile_store/src/repository/cart_repository.dart';
import 'package:mobile_store/src/screens/cart/cart_screen.dart';
import 'package:provider/provider.dart';

class ItemCart extends StatefulWidget {
  final ProductCartModel item;
  final DataProductModel itemModel;
  final int indexCart;
  ItemCart(
      {required this.item, required this.itemModel, required this.indexCart});
  @override
  State<StatefulWidget> createState() {
    return _ItemCartState();
  }
}

class _ItemCartState extends State<ItemCart> {
  int currentQuantity = 0;
  double currentPrice = 0;
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<Null> refresh() async {
    Future.delayed(Duration(milliseconds: 1));
    setState(() {});
    return null;
  }

  @override
  void initState() {
    super.initState();
    currentQuantity = widget.item.quantity;
    var model = Provider.of<UserProvider>(context, listen: false);
    currentPrice = model.getPrice;
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserProvider>(context, listen: false);
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
                    image: NetworkImage('${widget.item.image}'),
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
                        "${widget.itemModel.name}",
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
                        onTap: () async {
                          var status = await CartRepository().removeCartItemAPI(
                              idProduct: widget.item.idProduct,
                              color: widget.item.color);
                          currentPrice = model.getPrice -
                              (widget.item.price * widget.item.quantity);
                          model.setPrice = currentPrice;
                          if (status.statusCode == 200) {
                            snackBar("Xóa sản phẩm thành công");
                            if (model.getPrice == 0) {
                              model.setHasCart = false;
                            }
                            Navigator.of(context).popAndPushNamed('cart');
                          } else {
                            snackBar("Xóa sản phẩm thất bại");
                          }
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
                    Text(
                        "${widget.itemModel.ram}-${widget.itemModel.capacity}"),
                  ],
                ),
                Row(
                  children: [
                    Text("Màu: "),
                    Text("${widget.item.color}"),
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
                        onTap: () async {
                          if (currentQuantity == 1) {
                            var remove = await CartRepository()
                                .removeCartItemAPI(
                                    idProduct: widget.item.idProduct,
                                    color: widget.item.color);
                            currentPrice = model.getPrice - widget.item.price;
                            model.setPrice = currentPrice;
                            if (remove.statusCode == 200) {
                              snackBar("Xóa sản phẩm thành công");
                              if (model.getPrice == 0) {
                                model.setHasCart = false;
                              }
                              Navigator.of(context).popAndPushNamed('cart');
                            } else {
                              snackBar("Xóa sản phẩm thất bại");
                            }
                          } else {
                            currentQuantity--;
                            var status = await CartRepository().updateCartAPI(
                                idProduct: widget.item.idProduct,
                                color: widget.item.color,
                                quantity: currentQuantity);
                            currentPrice = model.getPrice - widget.item.price;
                            model.setPrice = currentPrice;

                            if (status.statusCode == 200) {
                              snackBar("Cập nhật giỏ hàng thành công");
                            } else {
                              snackBar("Cập nhật giỏ hàng thất bại");
                            }
                          }
                          refresh();
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
                          '$currentQuantity',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () async {
                          currentQuantity++;
                          var status = await CartRepository().updateCartAPI(
                              idProduct: widget.item.idProduct,
                              color: widget.item.color,
                              quantity: currentQuantity);
                          if (status.statusCode == 200) {
                            currentPrice = model.getPrice + widget.item.price;
                            model.setPrice = currentPrice;

                            snackBar("Cập nhật giỏ hàng thành công");
                          } else {
                            snackBar("Sản phẩm trong kho không đủ");
                          }
                          refresh();
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
