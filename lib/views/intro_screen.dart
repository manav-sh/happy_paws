import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/constants/styles.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  static void showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => const Center(
        child:
            SizedBox(height: 35, width: 35, child: CircularProgressIndicator()),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_login.png'),
                fit: BoxFit.cover)),
        child: GlassmorphicContainer(
            width: Get.width,
            height: Get.height,
            borderRadius: 0,
            linearGradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.3)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            border: 0,
            blur: 15,
            borderGradient: const LinearGradient(
                colors: [Colors.transparent, Colors.transparent]),
            child: Container(
              height: Get.height,
              width: Get.width,
              padding: const EdgeInsets.only(
                  bottom: 30, left: 20, right: 20, top: 60),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/doggy_image.png',
                          width: Get.width,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: const [
                            Text(
                              'Come. Change Lives',
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 23),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Help us rewrite the story of street dogs. Together, we can create a brighter future.',
                              style: TextStyle(
                                  color: lightBlack,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: Get.height * 0.17,
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed('/register');
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: const Color(0xFFEC3B3B),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 0),
                            child: Text(
                              'Register',
                              style: loginButton,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your logic here
                              Get.toNamed('/login');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.transparent,
                              foregroundColor: primaryRed,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              side: const BorderSide(
                                color: Color(0xFFEC3B3B),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: loginButton,
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            )),
      ),
    );
  }
}
