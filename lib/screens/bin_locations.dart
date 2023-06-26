import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varichem_warehouse/models/bin_location.dart';
import 'package:varichem_warehouse/providers/bin_location_provider.dart';
import 'package:varichem_warehouse/widgets/add_bin_location.dart';
import 'package:varichem_warehouse/widgets/edit_bin_location.dart';

class BinLocations extends StatefulWidget {
  const BinLocations({super.key});

  @override
  State<BinLocations> createState() => _BinLocationsState();

}

class _BinLocationsState extends State<BinLocations> {

  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<BinLocationProvider>( context, listen: true);
  List<BinLocation> binLocations = provider.allBinLocations();

    return Scaffold(
      appBar: AppBar(
        title: const Text( 'Bin locations'),
      ),
      body: ListView.builder(
          itemCount: binLocations.length,
          itemBuilder: ( context, index ) {

            BinLocation binLocation = binLocations[index];

            return ListTile(
              title: Text( binLocation.name),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                            context: context,
                            builder: ( BuildContext context ) {
                              return EditBinLocation(
                                  binLocationCallback: provider.updateBinLocation,
                                  binLocation: binLocation);
                            });
                      },
                      icon: const Icon( Icons.edit))
                ],
              ),
            );

          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
                context: context,
                builder: ( BuildContext context ) {
                return AddBinLocation(binLocationCallback: provider.addBinLocation);
                });
          }),
    );
  }


}