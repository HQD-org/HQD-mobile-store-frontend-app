import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/product_model_s.dart';
import 'package:mobile_store/src/providers/product_provider.dart';
import 'package:mobile_store/src/repository/product_repository.dart';

import 'package:mobile_store/src/widgets/product_card_gridview.dart';
import 'package:provider/provider.dart';

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
    var provider = Provider.of<ProductProvider>(context);
    List<ProductModel>? listDataProduct = provider.getAllProduct;
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}'),
        ),
        body: listDataProduct == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                ),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ProductCardGrid(
                    productCartGrid: listDataProduct[index],
                  );
                },
                itemCount: listDataProduct.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
              ));
  }
}


// FutureBuilder(
//         future: getAllProduct(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return Container(
//               padding: EdgeInsets.all(5.0),
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 8.0,
//                 ),
//                 scrollDirection: Axis.vertical,
//                 itemBuilder: (context, index) {
//                   return ProductCardGrid(
//                     productCartGrid: snapshot.data[index],
//                   );
//                 },
//                 itemCount: snapshot.data.length,
//                 shrinkWrap: true,
//                 physics: ScrollPhysics(),
//               ),
//             );
//           }
//         },
//       ),