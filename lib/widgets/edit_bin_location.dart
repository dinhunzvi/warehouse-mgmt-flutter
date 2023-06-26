import 'package:flutter/material.dart';
import 'package:varichem_warehouse/models/bin_location.dart';

class EditBinLocation extends StatefulWidget {
  final Function binLocationCallback;

  final BinLocation binLocation;

  const EditBinLocation({super.key, required this.binLocationCallback, required this.binLocation});

  @override
  State<EditBinLocation> createState() => _EditBinLocationState();
}

class _EditBinLocationState extends State<EditBinLocation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  String errorMessage = '';

  @override
  void initState() {

    nameController.text = widget.binLocation.name;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( top: 50, left: 10, right: 10 ),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'Name'
                ),
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
                validator: ( String? value) {
                  if ( value!.isEmpty) {
                    return 'Name is required';
                  }

                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () => updateBinLocation(context),
                    child: const Text('Save'),
                  ),
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  )
                ],
              )
            ],
          )),
    );
  }

  Future updateBinLocation( context) async {
    final form = _formKey.currentState;

    if ( !form!.validate()) {
      return;
    }

    widget.binLocation.name = nameController.text;

    await widget.binLocationCallback( widget.binLocation);

    Navigator.pop(context);
  }
}
