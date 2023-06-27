import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varichem_warehouse/models/measurement_unit.dart';
import 'package:varichem_warehouse/providers/measurement_unit_provider.dart';
import 'package:varichem_warehouse/widgets/add_measurement_unit.dart';
import 'package:varichem_warehouse/widgets/edit_measurement_unit.dart';

class MeasurementUnits extends StatefulWidget {
  const MeasurementUnits({super.key});

  @override
  State<MeasurementUnits> createState() => _MeasurementUnitsState();
  
}

class _MeasurementUnitsState extends State<MeasurementUnits> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeasurementUnitProvider>( context, listen: true);
    
    List<MeasurementUnit> measurementUnits = provider.allMeasurementUnits;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text( 'Measurement units' ),
      ),
      body: ListView.builder(
          itemCount: measurementUnits.length,
          itemBuilder: ( context, index) {
            MeasurementUnit measurementUnit = measurementUnits[index];
            
            return ListTile(
              title: Text( measurementUnit.name),
              subtitle: Text( measurementUnit.code),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: ( BuildContext context) {
                              return EditMeasurementUnit(
                                measurementUnit: measurementUnit,
                                measurementUnitCallback: provider.updateMeasurementUnit
                                );
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
                context: context,
                isScrollControlled: true,
                builder: ( BuildContext context) {
                  return AddMeasurementUnit( measurementUnitCallback: 
                  provider.addMeasurementUnit);
                });
          },
          child: const Icon( Icons.add),
      ),
    );
    
  }
  
}