import 'package:flutter/material.dart';
import 'package:varichem_warehouse/screens/bin_locations.dart';
import 'package:varichem_warehouse/screens/goods_received_vouchers.dart';
import 'package:varichem_warehouse/screens/measurement_units.dart';
import 'package:varichem_warehouse/screens/products.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  List<Widget> widgetOptions = const [ MeasurementUnits(), BinLocations(),
    Products(), GoodsReceivedVouchers() ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}