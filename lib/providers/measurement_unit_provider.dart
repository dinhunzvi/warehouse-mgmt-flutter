import 'package:flutter/material.dart';
import 'package:varichem_warehouse/providers/auth_provider.dart';
import 'package:varichem_warehouse/services/api_service.dart';

import '../models/measurement_unit.dart';

class MeasurementUnitProvider extends ChangeNotifier {
  late ApiService apiService;

  late AuthProvider authProvider;

  List<MeasurementUnit> measurementUnits = [];

  MeasurementUnitProvider( this.authProvider) {
    apiService = ApiService(authProvider.token);

    notifyListeners();
  }

  Future<void> init() async {
    measurementUnits = await apiService.getMeasurementUnits();

    notifyListeners();
  }

  get allMeasurementUnits {
    return measurementUnits;
  }

  Future<void> addMeasurementUnit( String name, String code) async {
    MeasurementUnit measurementUnit = await
    apiService.addMeasurementUnit(name, code);
    measurementUnits.add( measurementUnit);

    notifyListeners();
  }

  Future<void> updateMeasurementUnit( MeasurementUnit measurementUnit) async {
    MeasurementUnit updatedMeasurementUnit = await
    apiService.updateMeasurementUnit(measurementUnit);
    int index = measurementUnits.indexOf( measurementUnit);
    measurementUnits[index] = updatedMeasurementUnit;

    notifyListeners();

  }

}