import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_paws/views/home_screen.dart';
import 'package:happy_paws/views/login_scren.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFFEC3B3B, <int, Color>{
          50: Color(0x2FD0775B),
          100: Color(0x3FEC3B3B),
          200: Color(0x4FEC3B3B),
          300: Color(0x5fEC3B3B),
          400: Color(0x8FEC3B3B),
          500: Color(0xAfEC3B3B),
          600: Color(0xBFEC3B3B),
          700: Color(0xDFEC3B3B),
          800: Color(0xFFEC3B3B),
          900: Color(0xFFEC3B3B),
        }),
      ),
      home: const LoginScreen(),
    );
  }
}
