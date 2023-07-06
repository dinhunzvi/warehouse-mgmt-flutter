import 'package:flutter/material.dart';
import 'package:varichem_warehouse/models/raw_material.dart';
import 'package:varichem_warehouse/providers/auth_provider.dart';
import '../services/api_service.dart';

class RawMaterialProvider extends ChangeNotifier {
  List<RawMaterial> rawMaterials = [];

  late ApiService apiService;

  late AuthProvider authProvider;

  RawMaterialProvider( this.authProvider) {
    apiService = ApiService(authProvider.token);

    init();
  }

  Future<void> init() async {


    notifyListeners();

  }

  get allRawMaterials {
    return rawMaterials;
  }

  Future<void> addRawMaterial( int measurementUnitId, int binLocationId,
      String name ) async {
      RawMaterial rawMaterial = await apiService.addRawMaterial(
          measurementUnitId, binLocationId, name);
      rawMaterials.add( rawMaterial);

      notifyListeners();
  }

  Future<void> updateRawMaterial( RawMaterial rawMaterial ) async {
    RawMaterial updatedRawMaterial = await apiService.updateRawMaterial(rawMaterial);
    int index = rawMaterials.indexOf( rawMaterial);
    rawMaterials[index] = updatedRawMaterial;

    notifyListeners();
  }
}