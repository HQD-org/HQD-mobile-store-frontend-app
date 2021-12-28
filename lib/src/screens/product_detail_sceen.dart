import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/product_model_s.dart';
import 'package:mobile_store/src/providers/user_provider.dart';
import 'package:mobile_store/src/repository/cart_repository.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  ProductDetailScreen({required this.product});
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailScreenState();
  }
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int currentIndex = 0;
  int selectedIndexRadio = 0; // custom cho radio group
  int selectedIndexRadioRAM = 0;
  int selectedIndexRadioCapacity = 0;
  double currentPrice = 0;
  String currentColors = "Chưa chọn màu";
  String currentRAM = "Chưa chọn RAM";
  String currentCapacity = "Chưa chọn dung lượng";
  PageController pageController = PageController(initialPage: 0);
  bool isMore = false;
  List<String> listImgs = []; // list Img use to Slider
  List<String> productColors = [];
  List<String> productsRAM = [];
  List<String> productsCapacity = [];
  bool isActive = true;
  int dem = 0;
  Widget customRadio(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedIndexRadio = index;
          currentColors = productColors[index];
          for (int i = 0; i < widget.product.color.length; i++) {
            if (widget.product.color[i].name == productColors[index]) {
              currentPrice = widget.product.color[i].price.toDouble();
            }
          }
        });
      },
      child: Text(
        text,
        style: TextStyle(
            color: selectedIndexRadio == index ? Colors.red : Colors.grey[800]),
      ),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(
              color: selectedIndexRadio == index ? Colors.red : Colors.white),
          primary: Colors.white),
    );
  }

  Widget customRadioRAM(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedIndexRadioRAM = index;
          currentRAM = productsRAM[index];
          //print('Chọn màu: ${productColors[selectedIndex]}');
        });
      },
      child: Text(
        text,
        style: TextStyle(
            color:
                selectedIndexRadioRAM == index ? Colors.red : Colors.grey[800]),
      ),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(
              color:
                  selectedIndexRadioRAM == index ? Colors.red : Colors.white),
          primary: Colors.white),
    );
  }

  Widget customRadioCapacity(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedIndexRadioCapacity = index;
          currentCapacity = productsCapacity[index];
          //print('Chọn màu: ${productColors[selectedIndex]}');
        });
      },
      child: Text(
        text,
        style: TextStyle(
            color: selectedIndexRadioCapacity == index
                ? Colors.red
                : Colors.grey[800]),
      ),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(
              color: selectedIndexRadioCapacity == index
                  ? Colors.red
                  : Colors.white),
          primary: Colors.white),
    );
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
    //listImgs = widget.product.color
    for (int j = 0; j < widget.product.model.color.length; j++) {
      listImgs.add(widget.product.model.color[j].images[0]);
    }
    for (int i = 0; i < widget.product.color.length; i++) {
      productColors.add(widget.product.color[i].name);
      widget.product.color[i].quantityInfo.forEach((element) {
        dem = dem + element.quantity;
      });
    }
    productsRAM.add(widget.product.ram);
    productsCapacity.add(widget.product.capacity);
    if (widget.product.status == "active" && dem > 0) {
      isActive = true;
    } else {
      isActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sản phẩm: ${widget.product.name}',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print("Giỏ hàng");
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 0.1,
        child: Container(
          height: 70,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black26),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$currentPrice-VNĐ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              isActive
                  ? ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pinkAccent)),
                      onPressed: () async {
                        if (currentRAM == "Chưa chọn RAM") {
                          snackBar("Chưa chọn Ram");
                          return;
                        }
                        if (currentCapacity == "Chưa chọn dung lượng") {
                          snackBar("Chưa chọn dung lượng");
                          return;
                        }
                        if (currentColors == "Chưa chọn màu") {
                          snackBar("Chưa chọn màu");
                          return;
                        }

                        var status = await CartRepository().addToCartAPI(
                            idProduct: widget.product.id,
                            color: currentColors,
                            image: listImgs[0]);
                        if (status.statusCode == 200) {
                          model.setHasCart = true;
                          snackBar("Thêm vào giỏ thành công");
                        } else {
                          snackBar("Lỗi");
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            "Add to cart",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          )
                        ],
                      ),
                    )
                  : Text(
                      "Hết hàng",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red.shade500,
                          fontWeight: FontWeight.bold),
                    ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: PageView.builder(
                      itemCount: listImgs.length,
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          listImgs[index],
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Center(child: Icon(Icons.error));
                          },
                        );
                      }),
                ),
                Positioned(
                    // khúc này tạo một hàng các nút cho người dùng bấm chọn hình trên slider
                    bottom: 10.0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(listImgs.length, (index) {
                        return AnimatedContainer(
                          duration: Duration(microseconds: 400),
                          height: 8.0,
                          width: currentIndex == index ? 24.0 : 8.0,
                          margin: EdgeInsets.only(right: 4.0),
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? Colors.white
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        );
                      }).toList(),
                    )),
                Align(
                    // biểu tượng favorite trên Product_card
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 8.0, right: 8.0),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {
                          print('Thích sản phẩm');
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // tên sản phẩm
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "${widget.product.name}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Đánh giá
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Đánh giá",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5.0),
                        padding: EdgeInsets.all(4.0),
                        width: 60,
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
                              size: 20,
                            ),
                            Text(
                              "4.5",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                      ),
                      Row(
                        children: [
                          Text(
                            "Giảm giá",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            padding: EdgeInsets.all(4.0),
                            width: 70,
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
                                  size: 20,
                                ),
                                Text(
                                  "0%",
                                  style: TextStyle(
                                      fontSize: 16,
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Chi tiết sản phẩm",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Trạng thái: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        isActive ? "Còn hàng" : "Ngừng kinh doanh",
                        style: TextStyle(
                            fontSize: 20,
                            color: isActive
                                ? Colors.green.shade500
                                : Colors.red.shade500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.smart_screen_sharp,
                        size: 30,
                      ),
                      Text(
                        " - Màn hình: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Flexible(
                        child: Text(
                          "${widget.product.model.screen}",
                          style: TextStyle(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.android,
                        size: 30,
                      ),
                      Text(
                        " - Hệ điều hành: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${widget.product.model.operation}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.camera,
                        size: 30,
                      ),
                      Text(
                        " - Camera trước: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${widget.product.model.frontCamera}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 30,
                      ),
                      Text(
                        " - Camera Sau:  ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Flexible(
                        child: Text(
                          "${widget.product.model.rearCamera}",
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.memory,
                        size: 30,
                      ),
                      Text(
                        " - Chip: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${widget.product.model.chip}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 30,
                      ),
                      Text(
                        " - SIM: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${widget.product.model.sim}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.battery_alert,
                        size: 30,
                      ),
                      Text(
                        " - Pin: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${widget.product.model.battery}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.branding_watermark_sharp,
                        size: 30,
                      ),
                      Text(
                        " - Thương hiệu: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${widget.product.brand.name}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.memory_outlined,
                        size: 30,
                      ),
                      Text(
                        " - RAM: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "$currentRAM",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ListView.builder(
                      itemCount: productsRAM.length,
                      itemBuilder: (contex, index) {
                        return customRadioRAM(productsRAM[index], index);
                      },
                      padding: EdgeInsets.all(5.0),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.memory_sharp,
                        size: 30,
                      ),
                      Text(
                        " - Dung lượng: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "$currentCapacity",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ListView.builder(
                      itemCount: productsCapacity.length,
                      itemBuilder: (contex, index) {
                        return customRadioCapacity(
                            productsCapacity[index], index);
                      },
                      padding: EdgeInsets.all(5.0),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.color_lens,
                        size: 30,
                      ),
                      Text(
                        " - Chọn màu: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "$currentColors",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ListView.builder(
                      itemCount: productColors.length,
                      itemBuilder: (contex, index) {
                        return customRadio(productColors[index], index);
                      },
                      padding: EdgeInsets.all(5.0),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        " - Mô tả: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isMore = !isMore;
                          });
                        },
                        child: Text(
                          isMore ? "View less" : "See more",
                          style: TextStyle(color: Colors.pink),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: isMore
                        ? Text("${widget.product.model.description}")
                        : Text(
                            "${widget.product.model.description}",
                            style: TextStyle(),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
