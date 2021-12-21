import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/coupon_model.dart';

class CouponCard extends StatefulWidget {
  final CouponModel coupon;
  CouponCard({required this.coupon});
  @override
  State<StatefulWidget> createState() {
    return _CouponCardScreen();
  }
}

class _CouponCardScreen extends State<CouponCard> {
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
        showDialog(
            context: context,
            builder: (context) => CustomDialog(
                  description: 'Mô tả: ${widget.coupon.description}',
                  title: 'Mã: ${widget.coupon.name}',
                  expiredDate: convertDate(widget.coupon.expiredDate),
                  maxDiscount: widget.coupon.maxDiscount.toDouble(),
                  minPriceToApply: widget.coupon.minPriceToApply.toDouble(),
                  startedDate: convertDate(widget.coupon.startedDate),
                  discountValue: widget.coupon.discountValue,
                  quantity: widget.coupon.quantity,
                ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
        height: 170,
        decoration: BoxDecoration(
            border: Border.all(width: 1.6, color: Colors.blue),
            color: Colors.white),
        child: Row(
          children: [
            Container(
              width: 135,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${widget.coupon.image}"),
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
                      Text(
                        "Mã giảm giá: ${widget.coupon.name}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                              Icons.sell,
                              color: Colors.purple[500],
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Phần trăm khuyến mãi: ${widget.coupon.discountValue}%",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Ngày bắt đầu: ${convertDate(widget.coupon.startedDate)}",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Ngày kết thúc: ${convertDate(widget.coupon.expiredDate)}",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Số lượng mã còn lại: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${widget.coupon.quantity}",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      )
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

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final String startedDate;
  final String expiredDate;
  double? minPriceToApply;
  double? maxDiscount;
  int? discountValue;
  int? quantity;

  CustomDialog(
      {required this.title,
      required this.description,
      required this.startedDate,
      required this.expiredDate,
      required this.maxDiscount,
      required this.minPriceToApply,
      required this.discountValue,
      required this.quantity});
  dialogConten(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 100, left: 16, bottom: 16, right: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(description, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 5.0,
              ),
              Text("Bắt đầu: " + startedDate, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 5.0,
              ),
              Text("Kết thúc: " + expiredDate, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 5.0,
              ),
              Text("Phần trăm giảm giá: $discountValue%",
                  style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 5.0,
              ),
              Text(
                  "Giảm giá tối đa $maxDiscount-VNĐ cho đơn hàng có giá trị từ $minPriceToApply-VNĐ trở lên ",
                  style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 5.0,
              ),
              Text("Số lượng còn lại: " + quantity.toString(),
                  style: TextStyle(fontSize: 16, color: Colors.red)),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green[400]),
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: Icon(
              Icons.sell_sharp,
              size: 80,
              color: Colors.orange[500],
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: dialogConten(context),
    );
  }
}
