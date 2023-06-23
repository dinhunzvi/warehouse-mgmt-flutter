import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  final Function productCallback;

  const AddProduct({super.key, required this.productCallback});


  @override
  State<AddProduct> createState() => _AddProductState();

}

class _AddProductState extends State<AddProduct> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final productNameController = TextEditingController();
  final productCodeController = TextEditingController();

  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only( top: 50, left: 10, right: 10),
      child: Form(
        key: _formKey,
          child: Column(

          )),
    );

  }

  Widget buildBinLocationsDropdown() {

  }

}