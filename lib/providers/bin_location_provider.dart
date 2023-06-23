import 'package:flutter/material.dart';
import 'package:varichem_warehouse/providers/auth_provider.dart';
import 'package:varichem_warehouse/services/api_service.dart';

import '../models/bin_locations.dart';

class BinLocationProvider extends ChangeNotifier {
  List<BinLocation> binLocations = [];

  late ApiService apiService;

  late AuthProvider authProvider;

  BinLocationProvider( this.authProvider ) {
    apiService = ApiService( authProvider.token);

    init();
  }

  Future<void> init() async {
    binLocations = await apiService.getBinLocations();

    notifyListeners();

  }

  get allBinLocations {
    return binLocations;
  }

  Future<void> addBinLocation( String name) async {
    BinLocation binLocation = await apiService.addBinLocation( name );
    binLocations.add( binLocation);

    notifyListeners();

  }

  Future<void> updateBinLocation( BinLocation binLocation) async {
    BinLocation updatedBinLocation =
      await apiService.updateBinLocation(binLocation);
    int index = binLocations.indexOf(binLocation);
    binLocations[index] = updatedBinLocation;

    notifyListeners();
  }

}