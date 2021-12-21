import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/order_model.dart';
import 'package:mobile_store/src/models/product_order_model.dart';

class DetailOrderScreen extends StatelessWidget {
  final OrderModel detailOrder;
  DetailOrderScreen({required this.detailOrder});
  @override
  Widget build(BuildContext context) {
    double price = 0;
    double discount = 0;
    List<ProductOrderModel> listP = detailOrder.products;
    listP.forEach((element) {
      price += (element.price.toDouble() * element.quantity);
    });
    discount = price + 30000 - detailOrder.totalPrice;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết hóa đơn"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tên người nhận",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    detailOrder.receiveInfo.receiver,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Số điện thoại người nhận",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    detailOrder.receiveInfo.phone,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Text(
                    "Địa chỉ nhận hàng: ",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                child: Text(
                  "${detailOrder.receiveInfo.address}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Text(
                    "Đơn hàng",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 280,
                child: listP.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
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
                                          image:
                                              NetworkImage(listP[index].image),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              listP[index].name,
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
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              // splashColor: ,
                                              onTap: () {
                                                print("xóa sản phẩm");
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                child: Icon(
                                                  Icons.sim_card_download,
                                                  color: Colors.black,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Màu: ",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "${listP[index].color}",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Giá tiền: ",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "${listP[index].price}-VNĐ",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7.0,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              'Số lượng: ${listP[index].quantity}',
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: listP.length,
                      ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                height: 1,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.black)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tạm tính",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "$price-VNĐ",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phí vận chuyển",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "30.000-VNĐ",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "khuyến Mãi",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "-$discount-VNĐ",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tổng tính",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "${detailOrder.totalPrice}-VNĐ",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
