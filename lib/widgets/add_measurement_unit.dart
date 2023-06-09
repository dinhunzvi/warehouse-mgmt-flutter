import 'package:flutter/material.dart';

class AddMeasurementUnit extends StatefulWidget {
  final Function measurementUnitCallback;

  const AddMeasurementUnit({required this.measurementUnitCallback,super.key });

  @override
  State<AddMeasurementUnit> createState() => _AddMeasurementUnit();

}

class _AddMeasurementUnit extends State<AddMeasurementUnit> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final codeController = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only( top: 50, left: 10, right: 10),
    child: Form(
      key: _formKey,
      child: Column(
      children: <Widget>[
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Name',
          ),
          validator: ( String? value ) {
            if ( value!.isEmpty ) {
              return 'Name is required';
            }

            return null;
          },
          onChanged: ( text) => setState(() {
            errorMessage = '';
          }),
        ),
        const SizedBox( height: 15),
        TextFormField(
          controller: codeController,
          decoration: const InputDecoration(
            hintText: 'Code',
          ),
          validator: ( String? value ) {
            if ( value!.isEmpty ) {
              return 'Measurement code is required';
            }

            return null;
          },
          onChanged: ( text) => setState(() {
            errorMessage = '';
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => addMeasurementUnit(context),
                child: const Text( 'Save' )),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
              ),
                child: const Text( 'Cancel' ),
            ),

          ],
        ),
        Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        )
      ],
      ),

    ),);
  }

  Future addMeasurementUnit( context ) async {
    final form = _formKey.currentState;

    if ( !form!.validate()) {
      return;
    }

    await widget.measurementUnitCallback(
      nameController.text, codeController.text
    );

    Navigator.pop(context);
  }

}