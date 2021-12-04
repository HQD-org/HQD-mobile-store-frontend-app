import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/product_model_s.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel>? _listAllDataProduct;

  List<ProductModel>? get getAllProduct => _listAllDataProduct;
  set setAllProduct(List<ProductModel> list) {
    _listAllDataProduct = list;
  }
}

ProductProvider productProvider = ProductProvider();
