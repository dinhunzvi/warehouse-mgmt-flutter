import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varichem_warehouse/models/raw_material.dart';
import 'package:varichem_warehouse/providers/raw_material_provider.dart';
import 'package:varichem_warehouse/widgets/add_raw_material.dart';
import 'package:varichem_warehouse/widgets/edit_raw_material.dart';

class RawMaterials extends StatefulWidget {
  const RawMaterials({super.key});

  @override
  State<RawMaterials> createState() => _RawMaterialsState();
}

class _RawMaterialsState extends State<RawMaterials> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RawMaterialProvider>(context, listen: true);

    List<RawMaterial> rawMaterials = provider.allRawMaterials;

    return Scaffold(
      appBar: AppBar(
        title : const Text( 'Raw materials' )
      ),
    body: ListView.builder(
      itemCount: rawMaterials.length,
    itemBuilder: ( context, index  ) {
        RawMaterial rawMaterial = rawMaterials[index];
        return ListTile(
          title: Text( rawMaterial.name),
          subtitle: Text( rawMaterial.measurementUnit),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text( rawMaterial.binLocation),
              IconButton(
                  onPressed: () => {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: ( BuildContext context ) {
                          return EditRawMaterial( rawMaterial: rawMaterial,
                          rawMaterialCallback: provider.updateRawMaterial);
                        })
                  },
                  color: Colors.blue,
                  icon: const Icon(Icons.edit))
            ],
          ),
        );
    }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
            showModalBottomSheet(
              isScrollControlled: true,
                context: context,
                builder: ( BuildContext context ) {
                  return AddRawMaterial(rawMaterialCallback: provider.addRawMaterial);
                })
          },
        child: const Icon(
            Icons.add ),
      ),
    );
  }
}
