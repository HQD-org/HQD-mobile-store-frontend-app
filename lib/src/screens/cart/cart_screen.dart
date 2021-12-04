import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/product_model.dart';
import 'package:mobile_store/src/screens/cart/cart_empty_screen.dart';
import 'package:mobile_store/src/widgets/product_cart_widget.dart';

class CartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  List<String> cartItem = [];
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < listProductCart.length; i++) {
      totalPrice = totalPrice + double.parse(listProductCart[i].price);
    }
  }

  var listProductCart = [
    Product(
        coupon: '25%',
        imageURL:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIhw-aa3BQ1fDzNMEbo5aMUkPZF2qdmTcVwg&usqp=CAU',
        price: '9400000',
        productName: 'Iphone 8',
        Screen: 'IPS LCD6.5"HD+',
        OSSystem: 'Android',
        frontCamera: '5 MP',
        rearCamera: 'Chính 13MP & phụ 2MP',
        chip: 'Spreadtrum T610 8 nhân',
        RAM: '3GB',
        capacity: '32GB',
        sim: '2 Nano SIM hỗ trợ 4G',
        Pin: '5000 mAh 10W',
        brand: 'Apple',
        description: 'Cái này xịn',
        Colors: ["Vàng", "Xanh", "Đỏ"]),
    Product(
        coupon: '15%',
        imageURL:
            'https://hoanghamobile.com/tin-tuc/wp-content/uploads/2020/06/hinh-anh-iphone-12-pro-max-2.jpg',
        price: '24000000',
        productName: 'Iphone 12',
        Screen: 'IPS LCD6.5"HD+',
        OSSystem: 'Android',
        frontCamera: '5 MP',
        rearCamera: 'Chính 13MP & phụ 2MP',
        chip: 'Spreadtrum T610 8 nhân',
        RAM: '3GB',
        capacity: '32GB',
        sim: '2 Nano SIM hỗ trợ 4G',
        Pin: '5000 mAh 10W',
        brand: 'Apple',
        description: 'Cái này xịn',
        Colors: ["Vàng", "Xanh", "Đỏ"]),
  ];
  Widget cart() {
    return ListView.builder(
        itemCount: listProductCart.length,
        itemBuilder: (context, index) {
          if (listProductCart.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ItemCart(
              item: listProductCart[index],
            );
          }
        });
  }

  // custom bottomSheet khúc này cho biết tổng tiền của giỏ hàng
  Widget checkOutSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
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
                      "Checkout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () {
                    print("CheckOut");
                  },
                ),
              ),
            ),
            Spacer(),
            Text(
              "Tổng tiền: ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "$totalPrice-VNĐ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
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
        title: Text('Giỏ hàng'),
      ),
      body: listProductCart.length == 0 ? CartEmptyScreenState() : cart(),
      bottomSheet: checkOutSection(),
    );
  }
}
