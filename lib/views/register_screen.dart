import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:happy_paws/constants/auth.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/constants/styles.dart';
import 'package:happy_paws/controller/register_form_controller.dart';
import 'package:happy_paws/widgets/form_widgets.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  RegisterFormController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                Colors.white.withOpacity(0.45),
                Colors.white.withOpacity(0.30)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              border: 0,
              blur: 15,
              borderGradient: const LinearGradient(
                  colors: [Colors.transparent, Colors.transparent]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        verticalDirection: VerticalDirection.up,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 50),
                          //   child: Row(
                          //     children: const [
                          //       Expanded(
                          //           child: Divider(
                          //         color: lightBlack,
                          //       )),
                          //       Text('  or  '),
                          //       Expanded(
                          //           child: Divider(
                          //         color: lightBlack,
                          //       ))
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            child: Column(children: [
                              const Text(
                                'Let\'s begin your Pawsome journey!',
                                style: TextStyle(
                                    color: lightBlack,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              FormInputWithIcon(
                                  code: 1, //Code 1 refers email input
                                  type: TextInputType.emailAddress,
                                  hintText: 'Email',
                                  icon: Icons.mail_rounded),
                              const SizedBox(height: 10),
                              PasswordInput(
                                code: 2, //Code 2 refers password input.
                                type: TextInputType.visiblePassword,
                                hintText: 'Password',
                                icon: Icons.key_rounded,
                                inputAction: TextInputAction.done,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (controller.email.value != "" ||
                                      controller.password.value != "") {
                                    authController.register(
                                        controller.email.value,
                                        controller.password.value);
                                  } else {
                                    Get.snackbar('Please enter values',
                                        'Please enter values to continue.');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Text(
                                      'Register',
                                      style: loginButton,
                                    ),
                                    const Spacer()
                                  ],
                                ),
                              )
                            ]),
                          ),
                          Transform.translate(
                            offset: const Offset(0, 16),
                            child: Image.asset(
                              'assets/images/dog-hi.png',
                              width: Get.width * 0.44,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            )));
  }
}
