import 'dart:convert';
import 'dart:ffi';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/src/common/theme_helper.dart';
import 'package:mobile_store/src/controllers/location_controller.dart';
import 'package:mobile_store/src/models/branch_model.dart';
import 'package:mobile_store/src/models/cart_model.dart';
import 'package:mobile_store/src/models/coupon_model.dart';
import 'package:mobile_store/src/models/data_product_model.dart';
import 'package:mobile_store/src/models/district.dart';
import 'package:mobile_store/src/models/product_cart_model.dart';
import 'package:mobile_store/src/models/product_order_model.dart';
import 'package:mobile_store/src/models/province.dart';
import 'package:mobile_store/src/models/receiver_model.dart';
import 'package:mobile_store/src/models/user_model.dart';
import 'package:mobile_store/src/models/village.dart';
import 'package:mobile_store/src/providers/user_provider.dart';
import 'package:mobile_store/src/repository/cart_repository.dart';
import 'package:mobile_store/src/repository/coupon_repository.dart';
import 'package:mobile_store/src/repository/order_repository.dart';
import 'package:mobile_store/src/screens/Order/payment_paypal_screen.dart';
import 'package:mobile_store/src/screens/home.dart';
import 'package:mobile_store/src/widgets/dialog_loading.dart';
import 'package:mobile_store/src/widgets/product_order_widget.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController addressDetail = new TextEditingController();
  TextEditingController note = new TextEditingController();
  TextEditingController coupon = new TextEditingController();
  String province = "null";
  String district = "null";
  String village = "null";
  String timeRecieve = "Cả ngày";
  String receiveAt = "Tại nhà";
  String typePayment = "COD";
  String idProvince = "";
  String idDistrict = "";

  bool isSelectedProvince = false;
  bool isSelectedDistrict = false;
  List<String> listTimeRecieve = ["Cả ngày", "Giờ hành chính"];
  List<String> listReceiveAt = ["Tại nhà", "Tại cửa hàng"];
  List<String> listTypePayment = ["COD", "Online"];
  List<ProductCartModel>? listProducts;
  List<DataProductModel>? dataProducts;
  CartModel? cartModel;
  bool isLoading = true;
  double totalPrice = 0;
  bool isClick = false;
  int stepIndex = 0;
  double price = 0;
  double discount = 0;
  String idCoupon = "null";
  String idBranch = "61a23e0527b5b90016616975";
  late UserModel user;
  List<BranchModel> listBranch = [];
  late BranchModel selectedBranch;
  var model = userProvider;
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  getDataCart() async {
    cartModel = await CartRepository().getdataCartAPI();
    listProducts = cartModel!.products;
    dataProducts = cartModel!.dataProduct;
    var dataPrice = cartModel!.products;
    dataPrice.forEach((e) {
      totalPrice = totalPrice + (e.price.toDouble() * e.quantity);
    });
    price = totalPrice + 30000;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataCart();
    user = userProvider.getUser!;
    listBranch = userProvider.getAllBranch!;
    listBranch.forEach((element) {
      if (element.id == "61a23e0527b5b90016616975") {
        selectedBranch = element;
      }
    });
    name.text = user.name;
    phone.text = user.phone;
    addressDetail.text = user.address.detail;
  }

  List<Step> stepList() => [
        Step(
          state: stepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: stepIndex >= 0,
          title: const Text("Thông tin"),
          content: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(25, 30, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Họ tên', 'Họ tên người nhận hàng'),
                            controller: name,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Vui lòng nhập họ tên';
                              }
                              if (!RegExp('^[a-zA-Z]').hasMatch(val)) {
                                return 'Họ tên không đúng định dạng';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Địa chỉ', 'Địa chỉ nhận hàng'),
                            controller: addressDetail,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: DropdownSearch<Province>(
                            dropdownBuilderSupportsNullItem: true,
                            showSelectedItems: true,
                            compareFn: (i, s) => i?.isEqual(s!) ?? false,
                            dropdownSearchDecoration: ThemeHelper()
                                .textInputDecorationDrop(
                                    "Chọn tỉnh thành", " "),
                            // ignore: non_constant_identifier_names
                            onFind: (String) => LocationController()
                                .getProvince(), //(String? filter) => getData(filter),
                            onChanged: (data) {
                              //print(data!.code);
                              setState(() {
                                idProvince = data!.code;
                                province = data.nameWithType;
                                isSelectedProvince = true;
                              });
                            },
                            showSearchBox: true,
                            validator: (data) {
                              if (data == null) {
                                return "Chọn tỉnh thành";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: DropdownSearch<District>(
                            dropdownBuilderSupportsNullItem: true,
                            enabled: isSelectedProvince == true ? true : false,
                            showSelectedItems: true,
                            compareFn: (i, s) => i?.isEqual(s!) ?? false,
                            dropdownSearchDecoration: ThemeHelper()
                                .textInputDecorationDrop(
                                    "Chọn huyện/thành phố", " "),
                            // ignore: non_constant_identifier_names
                            onFind: (String) {
                              return LocationController()
                                  .getDistrict(idProvince);
                            }, //(String? filter) => getData(filter),
                            onChanged: (data) {
                              // print(data!.code);
                              setState(() {
                                idDistrict = data!.code;
                                district = data.nameWithType;
                                isSelectedDistrict = true;
                              });
                            },
                            showSearchBox: true,
                            validator: (data) {
                              if (data == null) {
                                return "Chọn huyện/thành phố";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: DropdownSearch<Village>(
                            dropdownBuilderSupportsNullItem: true,
                            showSelectedItems: true,
                            enabled: isSelectedDistrict == true ? true : false,
                            compareFn: (i, s) => i?.isEqual(s!) ?? false,
                            dropdownSearchDecoration: ThemeHelper()
                                .textInputDecorationDrop("Chọn xã/phường", " "),
                            // ignore: non_constant_identifier_names
                            onFind: (String) => LocationController().getVillage(
                                idDistrict), //(String? filter) => getData(filter),
                            onChanged: (data) {
                              //print(data!.code);
                              setState(() {
                                idDistrict = data!.code;
                                village = data.nameWithType;
                              });
                            },
                            showSearchBox: true,
                            validator: (data) {
                              if (data == null) {
                                return "Chọn xã/phường";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Số điện thoại", "Số điện thoại"),
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if ((val!.isEmpty) &&
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Số điện thoại không đúng định dạng";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: Row(
                            children: [Text("Chọn thời gian nhận hàng")],
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Container(
                          height: 45,
                          width: 500,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: DropdownButton(
                            hint: Text('Chọn thời gian nhận hàng'),
                            value: timeRecieve,
                            onChanged: (value) {
                              //"all day", "office day"
                              //"Cả ngày", "Giờ hành chính"
                              setState(() {
                                timeRecieve = value.toString();
                              });
                            },
                            items: listTimeRecieve.map((e) {
                              return DropdownMenuItem(
                                child: new Text(e),
                                value: e,
                              );
                            }).toList(),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Ghi chú", labelText: "Ghi chú"),
                            // decoration: ThemeHelper()
                            //     .textInputDecoration("Ghi chú", "Ghi chú"),
                            controller: note,
                            keyboardType: TextInputType.text,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Step(
          state: stepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: stepIndex >= 1,
          title: const Text("Xác nhận"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tên người nhận",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(name.text)
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(phone.text)
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      "Địa chỉ nhận hàng: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Text(
                    "${addressDetail.text}, $village, $district, $province",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      "Đơn hàng",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  height: 280,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            // listProducts=  widget.itemCart.products;
                            // dataProducts = widget.itemCart.dataProduct;
                            // List<DataProductModel> listDataModel = cartModel!.dataProduct;
                            DataProductModel dataModel;
                            for (int i = 0; i < dataProducts!.length; i++) {
                              if (listProducts![index].idProduct ==
                                  dataProducts![i].id) {
                                dataModel = dataProducts![i];
                                return ProductOrder(
                                  item: listProducts![index],
                                  itemModel: dataModel,
                                );
                              } else {
                                dataModel = dataProducts![i];
                                return ProductOrder(
                                  item: listProducts![index],
                                  itemModel: dataModel,
                                );
                              }
                            }
                            return ListTile(
                              title: Text("em thua"),
                            );
                          },
                          itemCount: listProducts!.length,
                        ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 160,
                      child: TextField(
                        controller: coupon,
                        decoration: InputDecoration(
                          hintText: "Mã khuyến mãi...",
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            side: BorderSide(color: Colors.blue),
                            primary: Colors.white),
                        onPressed: () async {
                          print(coupon.text.trim());
                          CouponModel? getCoupon = await CouponRepository()
                              .getDataCouponByName(
                                  'name=${coupon.text.trim()}');
                          if (getCoupon != null) {
                            if (getCoupon.quantity > 0) {
                              idCoupon = getCoupon.id;
                              print("coupon1: $idCoupon");
                              if (totalPrice >= getCoupon.minPriceToApply) {
                                double stemp = totalPrice;
                                discount =
                                    (totalPrice * getCoupon.discountValue) /
                                        100;
                                if (discount >= getCoupon.maxDiscount) {
                                  stemp = stemp - getCoupon.maxDiscount;
                                  price = stemp + 30000;
                                  discount = getCoupon.maxDiscount.toDouble();
                                } else {
                                  stemp = stemp - discount;
                                  price = stemp + 30000;
                                }
                              } else {
                                print("Giá trị đơn ko đủ để dùng coupon");
                                snackBar(
                                    "Đơn hàng không đáp ứng điều kiện của mã giảm giá");
                              }
                            } else {
                              snackBar("Mã khuyến mãi đã hết");
                            }
                          } else {
                            snackBar("Sai mã khuyến mãi");
                          }

                          setState(() {
                            isClick = true;
                          });
                          print("Khuyến mãi đó");
                        },
                        child: Text(
                          "Áp dụng",
                          style: TextStyle(
                              color: isClick ? Colors.red : Colors.blue),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tạm tính",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("$totalPrice-VNĐ")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phí vận chuyển",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("30.000-VNĐ")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "khuyến Mãi",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("-$discount-VNĐ")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tổng tính",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("$price-VNĐ")
                  ],
                ),
              ],
            ),
          ),
        ),
        Step(
            state: stepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: stepIndex >= 2,
            title: const Text("Hoàn thành"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Chọn địa điểm nhận hàng"),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(children: [
                    Container(
                      height: 45,
                      width: 250,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: DropdownButton(
                        hint: Text('Chọn địa điểm nhận hàng'),
                        value: receiveAt,
                        onChanged: (value) {
                          setState(() {
                            receiveAt = value.toString();
                          });
                          print(receiveAt);
                        },
                        items: listReceiveAt.map((e) {
                          return DropdownMenuItem(
                            child: new Text(e),
                            value: e,
                          );
                        }).toList(),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ]),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [Text("Chọn hình thức thanh toán")],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(children: [
                    Container(
                      height: 45,
                      width: 250,
                      padding: EdgeInsets.fromLTRB(20, 10, 12, 10),
                      child: DropdownButton(
                        hint: Text('Chọn hình thức thanh toán'),
                        value: typePayment,
                        onChanged: (value) {
                          setState(() {
                            typePayment = value.toString();
                          });
                        },
                        items: listTypePayment.map((e) {
                          return DropdownMenuItem(
                            child: new Text(e),
                            value: e,
                          );
                        }).toList(),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ]),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [Text("Chọn cửa hàng gần nhà bạn")],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(children: [
                    Container(
                      height: 45,
                      width: 360,
                      padding: EdgeInsets.fromLTRB(20, 10, 12, 10),
                      child: DropdownButton<BranchModel>(
                        hint: Text('Chọn cửa hàng gần nhà'),
                        value: selectedBranch,
                        onChanged: (value) {
                          setState(() {
                            selectedBranch = value!;
                            idBranch = selectedBranch.id;
                            print(idBranch);
                          });
                        },
                        items: listBranch.map((e) {
                          return DropdownMenuItem(
                            child: new Text(
                              e.address.district + " " + e.address.province,
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: e,
                          );
                        }).toList(),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ]),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            if (typePayment == "COD") {
                              showDialogLoading(context);
                              List<ProductOrderModel> products = [];
                              for (int i = 0; i < listProducts!.length; i++) {
                                for (int j = 0; j < dataProducts!.length; j++) {
                                  if (listProducts![i].idProduct ==
                                      dataProducts![j].id) {
                                    ProductOrderModel p = new ProductOrderModel(
                                        idProduct: listProducts![i].idProduct,
                                        quantity: listProducts![i].quantity,
                                        color: listProducts![i].color,
                                        image: listProducts![i].image,
                                        price: listProducts![i].price,
                                        name: dataProducts![j].name);
                                    products.add(p);
                                  } else {
                                    ProductOrderModel p1 =
                                        new ProductOrderModel(
                                            idProduct:
                                                listProducts![i].idProduct,
                                            quantity: listProducts![i].quantity,
                                            color: listProducts![i].color,
                                            image: listProducts![i].image,
                                            price: listProducts![i].price,
                                            name: dataProducts![j].name);
                                    products.add(p1);
                                  }
                                }
                              }

                              String timeRe = "all day";
                              //"all day", "office day"
                              //"Cả ngày", "Giờ hành chính"
                              if (timeRecieve == "Cả ngày") {
                                timeRe = "all day";
                              } else {
                                timeRe = "office day";
                              }
                              //"at home", "at store"
                              //"Tại nhà", "Tại cửa hàng"
                              String reAt = "at home";
                              if (receiveAt == "Tại nhà") {
                                reAt = "at home";
                              } else {
                                reAt = "at store";
                              }
                              Map<String, dynamic> info = {
                                "receiver": name.text,
                                "phone": phone.text,
                                "address":
                                    "${addressDetail.text}, $village, $district, $province",
                                "receiveAt": reAt,
                                "timeReceive": timeRe,
                                "message": note.text == "" ? "null" : note.text
                              };
                              // var uInfo = info.toJson();

                              var listp =
                                  products.map((e) => e.toJson()).toList();

                              var status =
                                  await OrderRepository().createOrderCODAPI(
                                idBranch: idBranch,
                                receiverInfo: info,
                                coupon:
                                    coupon.text == "" ? "null" : coupon.text,
                                totalPrice: price,
                                products: listp,
                              );
                              Navigator.pop(context);
                              if (status.statusCode == 200 ||
                                  status.statusCode == 201) {
                                var applyCoupon = await CouponRepository()
                                    .applyCouponAPI(idCoupon);
                                model.setHasCart = false;
                                if (applyCoupon.statusCode == 200) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => CustomDialog(
                                            title: "Thanh toán thành công",
                                            description:
                                                "Cảm ơn quý khách đã tin dùng HQD store",
                                          ));
                                } else {
                                  snackBar("Không tìm thấy mã giảm giá");
                                  showDialog(
                                      context: context,
                                      builder: (context) => CustomDialog(
                                            title: "Thanh toán thành công",
                                            description:
                                                "Cảm ơn quý khách đã tin dùng HQD store",
                                          ));
                                }
                              } else {
                                snackBar("Tạo hóa đơn thất bại");
                              }
                            } else {
                              showDialogLoading(context);
                              String timeRe1 = "all day";
                              //"all day", "office day"
                              //"Cả ngày", "Giờ hành chính"
                              if (timeRecieve == "Cả ngày") {
                                timeRe1 = "all day";
                              } else {
                                timeRe1 = "office day";
                              }
                              //"at home", "at store"
                              //"Tại nhà", "Tại cửa hàng"
                              String reAt1 = "at home";
                              if (receiveAt == "Tại nhà") {
                                reAt1 = "at home";
                              } else {
                                reAt1 = "at store";
                              }
                              Map<String, dynamic> info1 = {
                                "receiver": name.text,
                                "phone": phone.text,
                                "address":
                                    "${addressDetail.text}, $village, $district, $province",
                                "receiveAt": reAt1,
                                "timeReceive": timeRe1,
                                "message": note.text == "" ? "null" : note.text
                              };
                              // var uInfo = info1.toJson();
                              var payment = await OrderRepository()
                                  .createOrderOnlineAPI(
                                      idBranch: idBranch,
                                      coupon: coupon.text == ""
                                          ? "null"
                                          : coupon.text,
                                      totalPrice: price,
                                      receiverInfo: info1);
                              Navigator.pop(context);
                              if (payment.statusCode == 200 ||
                                  payment.statusCode == 201) {
                                String dataURL = "a";
                                dataURL = jsonDecode(payment.body)['data'];

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PaymentPaypalScreen(
                                          url: dataURL,
                                          coupon: idCoupon,
                                        )));
                              } else {
                                snackBar("Thanh toán thất bại");
                              }
                            }
                          },
                          child: (typePayment == "COD")
                              ? Text('Thanh toán')
                              : Text("Thanh toán qua Paypal"))
                    ],
                  )
                ],
              ),
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Tạo hóa đơn",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Theme(
          data: ThemeData(
              accentColor: Colors.orange,
              primarySwatch: Colors.orange,
              colorScheme: ColorScheme.light(primary: Colors.orange)),
          child: Container(
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: stepIndex,
              steps: stepList(),
              onStepContinue: () {
                if (stepIndex == 0) {
                  if (stepIndex < (stepList().length - 1)) {
                    if (_formKey.currentState!.validate()) {
                      stepIndex += 1;
                    }
                  }
                } else {
                  if (stepIndex < (stepList().length - 1)) {
                    stepIndex += 1;
                  }
                }

                setState(() {});
              },
              onStepCancel: () {
                if (stepIndex == 0) {
                  return;
                }
                stepIndex -= 1;
                setState(() {});
              },
            ),
          ),
        ));
  }
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;

  CustomDialog({
    required this.title,
    required this.description,
  });
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
            children: [
              Text(
                "Thanh toán thành công",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text("Cảm ơn bạn đã tin tưởng và mua hàng tại HQD store!",
                  style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green[400]),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyHomePage()));
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
              Icons.check_circle,
              size: 80,
              color: Colors.green[400],
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
