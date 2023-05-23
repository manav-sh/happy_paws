import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/constants/styles.dart';

Future achievementInfo(String title, String medal, int completed, int total) {
  return Get.defaultDialog(
    radius: 20,
    title: "",
    titlePadding: const EdgeInsets.all(0),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    content: Column(
      children: [
        Image.asset(
          'assets/images/$medal.png',
          width: Get.width / 3,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: popupHeading,
        ),
        const SizedBox(
          height: 15,
        ),
        (total - completed <= 0)
            ? const Text(
                'Congratulations..! You have successfully earned this badge.',
                textAlign: TextAlign.center,
                style: TextStyle(color: lightBlack),
              )
            : Text(
                'You have completed $completed contributions out of $total. Keep spreading the furrLove and earn the badge.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: lightBlack),
              ),
        const SizedBox(
          height: 15,
        ),
      ],
    ),
    confirm: Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
              color: primaryRed,
              borderRadius: BorderRadius.circular(40),
            ),
            width: Get.width / 2,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Okay',
              style: popupButton,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    ),
  );
}
