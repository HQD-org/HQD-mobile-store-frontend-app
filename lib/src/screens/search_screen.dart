import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/product_model_s.dart';
import 'package:mobile_store/src/repository/product_repository.dart';
import 'package:mobile_store/src/widgets/product_search_widget.dart';

class SearchScreen extends StatefulWidget {
  final String searchText;
  SearchScreen({
    required this.searchText,
  });
  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel>? listDataProduct;
  int count = 0;
  bool isLoading = true;
  getProducts() async {
    listDataProduct = await ProductRepository()
        .getAllProductByBrand("name=${widget.searchText}");
    setState(() {
      count = listDataProduct!.length;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Widget checkOutSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Số sản phẩm tìm được: ",
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
                      "Mua tiếp",
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
          title: Text("Search page"),
        ),
        bottomSheet: checkOutSection(),
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return ProductSearchScreen(
                    product: listDataProduct![index],
                  );
                },
                itemCount: listDataProduct!.length,
              ));
  }
}
