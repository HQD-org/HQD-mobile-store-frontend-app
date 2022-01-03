import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_store/src/models/order_model.dart';
import 'package:mobile_store/src/repository/order_repository.dart';
import 'package:mobile_store/src/widgets/detail_order_widget.dart';
import 'package:mobile_store/src/widgets/dialog_loading.dart';

class OrderCard extends StatefulWidget {
  final OrderModel order;
  OrderCard({required this.order});
  @override
  State<StatefulWidget> createState() {
    return _OrderCardState();
  }
}

class _OrderCardState extends State<OrderCard> {
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  String formattedDate(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMicrosecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy').format(dateFromTimeStamp);
  }

  String convertDate(String date) {
    String year = date.substring(0, 4);
    String month = date.substring(5, 7);
    String day = date.substring(8, 10);
    return day + "/" + month + "/" + year;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailOrderScreen(
                  detailOrder: widget.order,
                )));
        print("Hóa đơn");
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
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: NetworkImage(widget.item.image), fit: BoxFit.cover)),
              child: Image.asset(
                'asset/intro/bill.png',
                fit: BoxFit.cover,
              ),
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
                          "Hóa đơn: ${widget.order.id}",
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
                            if (widget.order.status == 'wait') {
                              var status = await OrderRepository()
                                  .cancelOrderAPI(widget.order.id);
                              if (status.statusCode == 200) {
                                if (widget.order.receiveInfo.status ==
                                    'online') {
                                  showDialogLoading(context);
                                  var refund = await OrderRepository()
                                      .refundPaymentAPI(widget.order.saleId,
                                          widget.order.totalPrice.toDouble());
                                  var jsonRefund = jsonDecode(refund.body);
                                  print(jsonRefund['message']);
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .popAndPushNamed('history');
                                } else {
                                  Navigator.of(context)
                                      .popAndPushNamed('history');
                                }
                              } else {
                                snackBar("Xóa hóa đơn thất bại");
                              }
                              print("xóa sản phẩm");
                            } else {
                              print("Không xóa được");
                            }
                          },
                          child: (widget.order.status == "wait")
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                )
                              : Container(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.king_bed,
                                    color: Colors.yellow,
                                    size: 25,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Ngày tạo: ${convertDate(widget.order.createdAt)}"),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text("Người nhận: ${widget.order.receiveInfo.receiver}"),
                      // Text("${widget.item.color}"),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text("Số điện thoại: ${widget.order.receiveInfo.phone}"),
                      // Text("${widget.item.price}-VNĐ"),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text('Tổng tiền: ${widget.order.totalPrice}-VNĐ')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                          "Hình thức thanh toán: ${widget.order.receiveInfo.status}"),
                      // Text("${widget.item.price}-VNĐ"),
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
