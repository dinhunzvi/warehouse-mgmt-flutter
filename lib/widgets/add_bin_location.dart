import 'package:flutter/material.dart';

class AddBinLocation extends StatefulWidget {
  final Function binLocationCallback;

  const AddBinLocation({super.key, required this.binLocationCallback});

  @override
  State<AddBinLocation> createState() => _AddBinLocationState();
}

class _AddBinLocationState extends State<AddBinLocation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  String errorMessage = '';

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
                    onPressed: () => addBinLocation(context),
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

  Future addBinLocation( context) async {
    final form = _formKey.currentState;

    if ( !form!.validate()) {
      return;
    }

    await widget.binLocationCallback( nameController.text);

    Navigator.pop(context);
  }
}
