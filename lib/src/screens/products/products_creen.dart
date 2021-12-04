import 'package:flutter/material.dart';
import 'package:mobile_store/src/repository/product_repository.dart';

import 'package:mobile_store/src/widgets/product_card_gridview.dart';

class ProductsScreen extends StatefulWidget {
  String title;
  ProductsScreen({required this.title});
  @override
  State<StatefulWidget> createState() {
    return _ProductsScreenState();
  }
}

class _ProductsScreenState extends State<ProductsScreen> {
  getAllProduct() async {
    return ProductRepository().getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}'),
        ),
        body: FutureBuilder(
          future: getAllProduct(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                ),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ProductCardGrid(
                    productCartGrid: snapshot.data[index],
                  );
                },
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
              );
            }
          },
        ));
  }
}
