import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varichem_warehouse/providers/auth_provider.dart';
import 'package:varichem_warehouse/screens/bin_locations.dart';
import 'package:varichem_warehouse/screens/goods_received_vouchers.dart';
import 'package:varichem_warehouse/screens/products.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> widgetOptions = const [
    BinLocations(),
    Products(),
    GoodsReceivedVouchers()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Varichem Pharmaceuticals',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: widgetOptions.elementAt(selectedIndex),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 4,
            child: BottomNavigationBar(
                elevation: 0,
                unselectedItemColor: Colors.black87,
                selectedItemColor: Colors.blueAccent,
                type: BottomNavigationBarType.fixed,
                // showUnselectedLabels: true,
                currentIndex: selectedIndex,
                onTap: onTapped,
                backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      label: 'Bin locations', icon: Icon(Icons.location_pin)),
                  BottomNavigationBarItem(
                      label: 'Products', icon: Icon(Icons.snippet_folder)),
                  BottomNavigationBarItem(
                      label: 'Receive products',
                      icon: Icon(Icons.folder_open)),
                  BottomNavigationBarItem(
                      label: 'Log out', icon: Icon(Icons.logout))
                ]),
          )),
    );
  }

  Future<void> onTapped(int index) async {
    if (index == 4) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);

      await authProvider.logout();
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }
}
