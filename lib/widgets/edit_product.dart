import 'package:flutter/material.dart';
import 'package:varichem_warehouse/models/product.dart';

class EditProduct extends StatefulWidget {
  final Function productCallBack;
  final Product product;

  const EditProduct({required this.product, required this.productCallBack, super.key });

  @override
  State<EditProduct> createState() => _EditProductState();

}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


  Future updateProduct( context ) async {

  }
}