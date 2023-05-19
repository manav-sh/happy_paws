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
            onTap: () {
              Get.back();
              Get.dialog(
                Scaffold(
                  appBar: AppBar(
                    title: const Text('Add Dog'),
                    centerTitle: true,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                          ),
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            hintText: 'Dog Description',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white10),
                            ),
                          ),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            hintText: 'Address',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white10),
                            ),
                          ),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 45)),
                    child: const Text('Save'),
                  ).paddingSymmetric(horizontal: 15, vertical: 10),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                'Add a new dog',
                // style: bottomSheet,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.back();
              Get.dialog(
                Scaffold(
                  appBar: AppBar(
                    title: const Text('Request help'),
                    centerTitle: true,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                          ),
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            hintText: 'Dog Description',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white10),
                            ),
                          ),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            hintText: 'Address',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white10),
                            ),
                          ),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 45)),
                    child: const Text('Save'),
                  ).paddingSymmetric(horizontal: 15, vertical: 10),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                'Request for NGO help',
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
