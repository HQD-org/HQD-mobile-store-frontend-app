import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/brand_model.dart';

class BrandDetailScreen extends StatefulWidget {
  final BrandModel brand;
  BrandDetailScreen({required this.brand});
  @override
  State<StatefulWidget> createState() {
    return _BrandDetailScreenState();
  }
}

class _BrandDetailScreenState extends State<BrandDetailScreen> {
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome to ${widget.brand.name}",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            alignment: Alignment.center,
            child: Image.network(
              widget.brand.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Thông tin về thương hiệu",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isMore = !isMore;
                    });
                  },
                  child: isMore
                      ? Text(
                          "View less",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "View more",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: isMore
                ? Text(
                    "${widget.brand.description}",
                  )
                : Text(widget.brand.description,
                    maxLines: 3, overflow: TextOverflow.ellipsis),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Các sản phẩm",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
