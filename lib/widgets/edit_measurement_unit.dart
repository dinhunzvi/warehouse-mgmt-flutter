import 'package:flutter/material.dart';
import 'package:varichem_warehouse/models/measurement_unit.dart';

class EditMeasurementUnit extends StatefulWidget {
  final Function measurementUnitCallback;
  final MeasurementUnit measurementUnit;

  const EditMeasurementUnit(
      {required this.measurementUnit,
      required this.measurementUnitCallback,
      super.key});

  @override
  State<EditMeasurementUnit> createState() => _EditMeasurementUnit();
}

class _EditMeasurementUnit extends State<EditMeasurementUnit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final codeController = TextEditingController();
  final nameController = TextEditingController();

  String errorMessage = '';

  @override
  void initState() {
    codeController.text = widget.measurementUnit.code.toString();
    nameController.text = widget.measurementUnit.name.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Name is required';
                }

                return null;
              },
              onChanged: (text) => setState(() {
                errorMessage = '';
              }),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: codeController,
              decoration: const InputDecoration(
                hintText: 'Code',
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Measurement code is required';
                }

                return null;
              },
              onChanged: (text) => setState(() {
                errorMessage = '';
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => editMeasurementUnit(context),
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
        ),
      ),
    );
  }

  Future editMeasurementUnit(context) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.measurementUnit.code = codeController.text;
    widget.measurementUnit.name = nameController.text;

    await widget.measurementUnitCallback(widget.measurementUnit);

    Navigator.pop(context);
  }
}
