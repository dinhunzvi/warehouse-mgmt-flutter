import 'package:flutter/material.dart';
import 'package:varichem_warehouse/screens/auth/login.dart';
import 'package:varichem_warehouse/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: const Color(0xFFF2994A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular( 14 ),
              side: BorderSide.none
            ),
            elevation: 0
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color( 0xFFFBFBFB ),
          filled: true,
          border: defaultOutlineInputBorder,
          enabledBorder: defaultOutlineInputBorder,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular( 14 ),
            borderSide: const BorderSide( color: Color( 0xFFF2994A))
          )
        ),

      ),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

