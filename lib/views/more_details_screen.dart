import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:happy_paws/constants/auth.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/constants/styles.dart';
import 'package:happy_paws/controller/image_controller.dart';
import 'package:happy_paws/controller/register_form_controller.dart';
import 'package:happy_paws/service/image_storage.dart';
import 'package:happy_paws/widgets/form_widgets.dart';
import 'package:happy_paws/widgets/loading_builders.dart';

class MoreDetailsScreen extends StatelessWidget {
  MoreDetailsScreen({super.key});

  final imagepickingController = Get.put(ImagePickingController());

  RegisterFormController controller = Get.put(RegisterFormController());

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
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            child: Column(children: [
                              const Text(
                                'Okay! One last step.',
                                style: TextStyle(
                                    color: lightBlack,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Obx(() => InkWell(
                                    onTap: () {
                                      imagepickingController.getImage();
                                    },
                                    child: imagepickingController
                                            .imageSelected.value
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Get.width * 0.4),
                                            child: Image.file(
                                              imagepickingController
                                                  .photo.value!,
                                              height: Get.width * 0.3,
                                              width: Get.width * 0.3,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Container(
                                            height: Get.width * 0.3,
                                            width: Get.width * 0.3,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Get.width / 3),
                                                color:
                                                    lightGrey.withOpacity(0.5)),
                                            child: Icon(
                                              Icons.add_a_photo,
                                              color:
                                                  lightBlack.withOpacity(0.6),
                                            ),
                                          ),
                                  )),
                              SizedBox(height: 10),
                              Text(
                                imagepickingController.imageSelected.value
                                    ? 'Tap image to change'
                                    : 'Select Profile Photo',
                                style: TextStyle(
                                    color: lightBlack.withOpacity(0.8)),
                              ),
                              const SizedBox(height: 30),
                              FormInputWithIcon(
                                  code: 3,
                                  type: TextInputType.text,
                                  hintText: 'Full Name',
                                  icon: Icons.person),
                              const SizedBox(height: 10),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  if (controller.fullname.value == "") {
                                    Get.snackbar(
                                        'Warning', 'Please input your name');
                                    return;
                                  }
                                  if (imagepickingController.photo.value ==
                                      null) {
                                    Get.snackbar(
                                        'Warning', 'Please select image');
                                    return;
                                  }
                                  ProcessLoaders.showLoading(context);
                                  await FirestoreImage.uploadFile(
                                          imagepickingController.photo.value)
                                      .then((value) {
                                    if (value != null) {
                                      authController.addAdditionalInfo(
                                          controller.fullname.value, value, "");
                                      ProcessLoaders.hideLoading(context);
                                      Get.offAllNamed('/home');
                                    }
                                  }).onError((error, stackTrace) {
                                    Get.snackbar('Error',
                                        'Error occured while image upload.');
                                    ProcessLoaders.hideLoading(context);
                                  });
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
                                      'Finish',
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
