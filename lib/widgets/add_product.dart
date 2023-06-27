import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varichem_warehouse/models/bin_location.dart';
import 'package:varichem_warehouse/models/measurement_unit.dart';
import 'package:varichem_warehouse/providers/bin_location_provider.dart';
import 'package:varichem_warehouse/providers/measurement_unit_provider.dart';

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
  final measurementUnitController = TextEditingController();
  final binLocationController = TextEditingController();

  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only( top: 50, left: 10, right: 10),
      child: Form(
        key: _formKey,
          child: Column(
            children: <Widget>[
              buildBinLocationsDropdown(),
              const SizedBox( height: 24 ),
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
                      onPressed: () => addProduct(context),
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

  Widget buildBinLocationsDropdown() {
    return Consumer<BinLocationProvider>(
      builder: ( context, cProvider, child) {
        List<BinLocation> binLocations = cProvider.binLocations;

        return DropdownButtonFormField(
          elevation: 8,
          items: binLocations.map<DropdownMenuItem<String>>((e) {
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
              binLocationController.text = newValue.toString();
            });
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Bin location'
          ),
          dropdownColor: Colors.white,
          validator: ( value) {
            if ( value  == null ) {
              return 'Select bin location';
            }
          },
        );
      },
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

  Future addProduct( context) async {
    final form = _formKey.currentState;

    if ( !form!.validate()) {
      return;
    }

    await widget.productCallback(
      measurementUnitController.text,
      binLocationController.text,
      productNameController.text,
      productCodeController.text
    );

    Navigator.pop(context);
  }
}