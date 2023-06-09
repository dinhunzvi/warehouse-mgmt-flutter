import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varichem_warehouse/models/product.dart';
import '../models/measurement_unit.dart';
import '../providers/measurement_unit_provider.dart';

class EditProduct extends StatefulWidget {
  final Function productCallBack;
  final Product product;

  const EditProduct({required this.product, required this.productCallBack, super.key });

  @override
  State<EditProduct> createState() => _EditProductState();

}

class _EditProductState extends State<EditProduct> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final productNameController = TextEditingController();
  final productCodeController = TextEditingController();
  final measurementUnitController = TextEditingController();

  String errorMessage = '';

  @override
  void initState() {
    productCodeController.text = widget.product.code.toString();
    productNameController.text = widget.product.name.toString();
    measurementUnitController.text = widget.product.measurementUnitName.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( top: 50, left: 10, right: 10),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildMeasurementUnitsDropdown(),
              const SizedBox( height: 24 ),
              TextFormField(
                controller: productNameController,
                decoration: const InputDecoration(
                    hintText: 'Name'
                ),
              ),
              const SizedBox( height: 24 ),
              TextFormField(
                controller: productCodeController,
                decoration: const InputDecoration(
                    hintText: 'Code'
                ),
                validator: ( value ) {
                  if ( value!.trim().isEmpty) {
                    return 'Name is required';
                  }

                  return null;
                },
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
              ),
              const SizedBox( height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => updateProduct(context),
                      child: const Text( 'Save' )),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red
                    ),
                    child: const Text( 'Cancel' ),
                  )
                ],
              )
            ],
          )),
    );

  }

  Widget buildMeasurementUnitsDropdown() {
    return Consumer<MeasurementUnitProvider>(
      builder: ( context, mProvider, child) {
        List<MeasurementUnit> measurementUnits = mProvider.measurementUnits;

        return DropdownButtonFormField(
          elevation: 8,
          items: measurementUnits.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
                value: e.id.toString(),
                child: Text(e.name,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 20.0
                  ),));
          }).toList(),
          onChanged: ( String? newValue) {
            if ( newValue == null) {
              return;
            }

            setState(() {
              measurementUnitController.text = newValue.toString();
            });
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Measurement unit'
          ),
          dropdownColor: Colors.white,
          validator: ( value) {
            if ( value  == null ) {
              return 'Select measurement unit';
            }
          },
        );


      },
    );
  }

  Future updateProduct( context ) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.product.name = productNameController.text;
    widget.product.code = productCodeController.text;
    widget.product.measurementUnitId = int.parse(measurementUnitController.text);

    await widget.productCallBack( widget.product);

    Navigator.pop(context);

  }
}