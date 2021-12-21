import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/coupon_model.dart';
import 'package:mobile_store/src/repository/coupon_repository.dart';
import 'package:mobile_store/src/widgets/coupon_card_widget.dart';

class CouponScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CouponScreenState();
  }
}

class _CouponScreenState extends State<CouponScreen> {
  bool isLoading = true;
  int count = 0;
  List<CouponModel>? listCoupon = [];
  List<CouponModel>? listCouponAvailable = [];
  getDataCoupon() async {
    listCoupon = await CouponRepository().getDataCouponAPI();
    listCoupon!.forEach((element) {
      if (element.quantity > 0) {
        listCouponAvailable!.add(element);
      }
    });
    count = listCouponAvailable!.length;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataCoupon();
  }

  Widget customBottomBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Số mã giảm giá khả dụng: ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "$count",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Mua ngay",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Các mã giảm giá",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 3,
              alignment: Alignment.center,
              child: Image.asset(
                'asset/intro/shopping.png',
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Giới thiệu",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            // child: isMore
            //     ? Text(
            //         "${widget.brand.description}",
            //       ):
            child: Text(
                "Hàng nghìn mã giảm giá hấp dẫn đang chờ đợi quý khách tại HQD Store nhanh tay đặt hàng ngay nhé",
                style: TextStyle(fontSize: 17.0),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Các mã giảm giá",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 700,
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return CouponCard(
                          coupon: listCouponAvailable![index],
                        );
                      },
                      itemCount: listCouponAvailable!.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                    )),
        ],
      )),
      bottomSheet: customBottomBar(),
    );
  }
}
