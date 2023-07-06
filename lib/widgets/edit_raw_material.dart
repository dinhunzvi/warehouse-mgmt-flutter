import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varichem_warehouse/models/raw_material.dart';

import '../models/bin_location.dart';
import '../models/measurement_unit.dart';
import '../providers/bin_location_provider.dart';
import '../providers/measurement_unit_provider.dart';

class EditRawMaterial extends StatefulWidget {
  final RawMaterial rawMaterial;
  final Function rawMaterialCallback;
  const EditRawMaterial({super.key, required this.rawMaterial, required this.rawMaterialCallback});

  @override
  State<EditRawMaterial> createState() => _EditRawMaterialState();
}

class _EditRawMaterialState extends State<EditRawMaterial> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final measurementUnitController = TextEditingController();
  final binLocationController = TextEditingController();
  final nameController = TextEditingController();

  String errorMessage = '';

  @override
  void initState() {
    measurementUnitController.text = widget.rawMaterial.measurementUnitId.toString();
    binLocationController.text = widget.rawMaterial.binLocationId.toString();
    nameController.text = widget.rawMaterial.name.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
      child: Form(
          child: Column(
            children: <Widget>[
              buildMeasurementUnitsDropdown(),
              const SizedBox(
                height: 20,
              ),
              buildMeasurementUnitsDropdown(),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }

                  return null;
                },
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => {
                        editRawMaterial(context)
                      },
                      child: const Text( 'Save' ) ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red
                    ),
                    child: const Text( 'Cancel' ),)
                ],
              )
            ],
          )),
    );
  }

  Widget buildMeasurementUnitsDropdown() {
    return Consumer<MeasurementUnitProvider>(
      builder: (context, mProvider, child) {
        List<MeasurementUnit> measurementUnits = mProvider.measurementUnits;

        return DropdownButtonFormField(
          elevation: 8,
          items: measurementUnits.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
                value: e.id.toString(),
                child: Text(
                  e.name,
                  style: const TextStyle(color: Colors.black, fontSize: 20.0),
                ));
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue == null) {
              return;
            }

            setState(() {
              measurementUnitController.text = newValue.toString();
            });
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: 'Measurement unit'),
          dropdownColor: Colors.white,
          validator: (value) {
            if (value == null) {
              return 'Select measurement unit';
            }
          },
        );
      },
    );
  }

  Widget buildBinLocationsDropdown() {
    return Consumer<BinLocationProvider>(
      builder: (context, bProvider, child) {
        List<BinLocation> binLocations = bProvider.binLocations;

        return DropdownButtonFormField(
          elevation: 8,
          items: binLocations.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
                value: e.id.toString(),
                child: Text(
                  e.name,
                  style: const TextStyle(color: Colors.black, fontSize: 20.0),
                ));
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue == null) {
              return;
            }

            setState(() {
              binLocationController.text = newValue.toString();
            });
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: 'Measurement unit'),
          dropdownColor: Colors.white,
          validator: (value) {
            if (value == null) {
              return 'Select bin location';
            }
          },
        );
      },
    );
  }

  Future editRawMaterial( context) async {
    final form = _formKey.currentState;
    
    if ( !form!.validate()) {
      return;
    }
    
    widget.rawMaterial.binLocationId = int.parse( binLocationController.text);
    widget.rawMaterial.measurementUnitId = 
        int.parse(measurementUnitController.text);
    widget.rawMaterial.name = nameController.text;
    
    await widget.rawMaterialCallback( widget.rawMaterial );
    
    Navigator.pop(context);
  }

}
