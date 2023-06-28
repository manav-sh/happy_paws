import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_paws/constants/auth.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/controller/password_controller.dart';

class FormInputWithIcon extends StatelessWidget {
  FormInputWithIcon(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.type,
      required this.code,
      this.inputAction = TextInputAction.next});

  final String hintText;
  final IconData icon;
  TextInputAction inputAction;
  final TextInputType type;
  final int code;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: TextField(
        onChanged: (value) {
          registerFormController.updateValue(value, code);
        },
        keyboardType: type,
        textInputAction: inputAction,
        decoration: InputDecoration(
            hintText: hintText,
            icon: Icon(
              icon,
              size: 20,
              color: lightBlack.withOpacity(0.6),
            ),
            border: InputBorder.none),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  PasswordInput(
      {super.key,
      required this.code,
      required this.hintText,
      required this.icon,
      required this.type,
      this.inputAction = TextInputAction.next});

  final String hintText;
  final IconData icon;
  TextInputAction inputAction;
  final TextInputType type;
  final int code;

  final passwordVisibility = Get.put(PasswordVisibility());

  bool isPassword() => type == TextInputType.visiblePassword;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: lightGrey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Obx(
          () => TextField(
            onChanged: (value) =>
                registerFormController.updateValue(value, code),
            keyboardType: type,
            textInputAction: inputAction,
            decoration: InputDecoration(
                hintText: hintText,
                icon: Icon(
                  icon,
                  size: 20,
                  color: lightBlack.withOpacity(0.6),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    passwordVisibility
                        .setStatus(!passwordVisibility.status.value);
                  },
                  child: Icon(
                    passwordVisibility.status.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: lightGrey,
                  ),
                ),
                border: InputBorder.none),
            obscureText: !passwordVisibility.status.value,
          ),
        ));
  }
}
