import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_paws/constants/auth.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/controller/firebase_auth_getx.dart';
import 'package:happy_paws/views/add_dog.dart';
import 'package:happy_paws/views/home_screen.dart';
import 'package:happy_paws/views/intro_screen.dart';
import 'package:happy_paws/views/login_screen.dart';
import 'package:happy_paws/views/more_details_screen.dart';
import 'package:happy_paws/views/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/intro', page: () => const IntroScreen()),
        GetPage(name: '/addDog', page: () => const AddDog()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/moreInfo', page: () => MoreDetailsScreen()),
      ],
      title: 'Happy Paws',
      theme: ThemeData(
          primarySwatch: const MaterialColor(0xFFEC3B3B, <int, Color>{
            50: Color(0x2FEC3B3B),
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
          fontFamily: 'DMSans',
          splashColor: primaryRedBg,
          highlightColor: primaryRedBg),
      home: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
