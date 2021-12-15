import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/cart_model.dart';
import 'package:mobile_store/src/models/data_product_model.dart';
import 'package:mobile_store/src/models/product_cart_model.dart';

import 'package:mobile_store/src/providers/user_provider.dart';
import 'package:mobile_store/src/repository/cart_repository.dart';
import 'package:mobile_store/src/screens/Order/order_screen.dart';
import 'package:mobile_store/src/screens/cart/cart_empty_screen.dart';
import 'package:mobile_store/src/widgets/product_cart_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  List<ProductCartModel> cartItem = [];
  double totalPrice = 0;
  CartModel? cartModel;
  int isempty = 0;
  bool _isLoading = true;
  Future<Null> refresh() async {
    Future.delayed(Duration(milliseconds: 1));
    setState(() {});
    return null;
  }

  getDataCart() async {
    var model = Provider.of<UserProvider>(context, listen: false);
    cartModel = await CartRepository().getdataCartAPI();
    var dataPrice = cartModel!.products;
    dataPrice.forEach((e) {
      totalPrice = totalPrice + (e.price.toDouble() * e.quantity);
    });
    model.setPrice = totalPrice;

    print("------------ $totalPrice");

    setState(() {
      _isLoading = false;
    });
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getDataCart();
  }

  Widget cart() {
    return _isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : ListView.builder(
            itemCount: cartModel!.products.length,
            itemBuilder: (context, index) {
              List<DataProductModel> listDataModel = cartModel!.dataProduct;
              DataProductModel dataModel;
              for (int i = 0; i < listDataModel.length; i++) {
                if (cartModel!.products[index].idProduct ==
                    listDataModel[i].id) {
                  dataModel = listDataModel[i];
                  return ItemCart(
                    item: cartModel!.products[index],
                    itemModel: dataModel,
                    indexCart: index,
                  );
                } else {
                  dataModel = listDataModel[i];
                  return ItemCart(
                    item: cartModel!.products[index],
                    itemModel: dataModel,
                    indexCart: index,
                  );
                }
              }
              return ListTile(
                title: Text("em thua"),
              );
            });
  }

  // custom bottomSheet khúc này cho biết tổng tiền của giỏ hàng
  Widget checkOutSection() {
    var model = Provider.of<UserProvider>(context);
    double p = model.getPrice;
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
                    if (totalPrice == 0) {
                      snackBar("Không thể thanh toán");
                      return;
                    }
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => OrderScreen()));
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
              "$p-VNĐ",
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
      body: totalPrice != 0 ? cart() : CartEmptyScreenState(),
      bottomSheet: checkOutSection(),
    );
  }
}
