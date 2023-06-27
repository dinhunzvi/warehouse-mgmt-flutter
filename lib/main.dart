import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varichem_warehouse/constants.dart';
import 'package:varichem_warehouse/providers/auth_provider.dart';
import 'package:varichem_warehouse/providers/bin_location_provider.dart';
import 'package:varichem_warehouse/providers/goods_received_voucher_provider.dart';
import 'package:varichem_warehouse/providers/measurement_unit_provider.dart';
import 'package:varichem_warehouse/providers/product_provider.dart';
import 'package:varichem_warehouse/screens/auth/login.dart';
import 'package:varichem_warehouse/screens/bin_locations.dart';
import 'package:varichem_warehouse/screens/goods_received_vouchers.dart';
import 'package:varichem_warehouse/screens/home.dart';
import 'package:varichem_warehouse/screens/measurement_units.dart';
import 'package:varichem_warehouse/screens/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<BinLocationProvider>(
                  create: (context) => BinLocationProvider(authProvider)),
              ChangeNotifierProvider<MeasurementUnitProvider>(
                  create: (context) => MeasurementUnitProvider(authProvider)),
              ChangeNotifierProvider<ProductProvider>(
                  create: (context) => ProductProvider(authProvider)),
              ChangeNotifierProvider<GoodsReceivedVoucherProvider>(
                  create: (context) =>
                      GoodsReceivedVoucherProvider(authProvider))
            ],
            child: MaterialApp(
              title: 'Varichem Pharmaceuticals',
              theme: ThemeData(
                //scaffoldBackgroundColor: Colors.black87,
                primarySwatch: Colors.purple,
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: const Color(0xFFF2994A),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide.none),
                        elevation: 0)),
                inputDecorationTheme: InputDecorationTheme(
                    fillColor: const Color(0xFFFBFBFB),
                    filled: true,
                    border: defaultOutlineInputBorder,
                    enabledBorder: defaultOutlineInputBorder,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: Color(0xFFF2994A)))),
              ),
              debugShowCheckedModeBanner: false,
              routes: {
                '/': (context) {
                  final authProvider = Provider.of<AuthProvider>(context);
                  if (authProvider.isAuthenticated) {
                    return const Home();
                  } else {
                    return const Login();
                  }
                },
                '/login': (context) => const Login(),
                'products': (context) => const Products(),
                'measurement-units': (context) => const MeasurementUnits(),
                'bin-locations': (context) => const BinLocations(),
                'goods-received-vouchers': (context) =>
                    const GoodsReceivedVouchers()
              },
            ),
          );
        },
      ),
    );
  }
}
