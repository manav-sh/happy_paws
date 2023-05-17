import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future addBottomSheet() {
  return Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      padding: const EdgeInsets.only(bottom: 30, top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              alignment: Alignment.topCenter,
              height: 5,
              width: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3), color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                'Add a New Plant',
                // style: bottomSheet,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                'Add a New Plant',
                // style: bottomSheet,
              ),
            ),
          )
        ],
      ),
    ),
    enterBottomSheetDuration: const Duration(milliseconds: 250),
    exitBottomSheetDuration: const Duration(milliseconds: 250),
  );
}
