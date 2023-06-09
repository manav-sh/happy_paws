import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:happy_paws/constants/auth.dart';
import 'package:happy_paws/constants/db.dart';
import 'package:happy_paws/controller/location_permission_controller.dart';
import 'package:happy_paws/widgets/loading_builders.dart';
import 'package:image_picker/image_picker.dart';

class AddDog extends StatefulWidget {
  const AddDog({super.key});

  @override
  State<AddDog> createState() => _AddDogState();
}

class _AddDogState extends State<AddDog> {
  bool _imageSelected = false;
  File? _photo;

  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  final locationController = Get.put(GetLocation());

  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _photo = File(pickedImage.path);
        _imageSelected = true;
      } else {
        _imageSelected = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Area'),
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
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  locationController.updateLocation();
                },
                child: const Text('Get Current Location')),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                getImage();
              },
              child: _imageSelected
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _photo!,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.45,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: Get.width / 4,
                      width: Get.width / 1.2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add),
                          SizedBox(height: 10),
                          Text('Select Image')
                        ],
                      ),
                    ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Dog Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white10),
                ),
              ),
              maxLines: 5,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white10),
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
        onPressed: () async {
          if (_photo == null) {
            Fluttertoast.showToast(msg: 'Please select image');
            return;
          }
          if (addressController.text == "") {
            Fluttertoast.showToast(msg: 'Please enter address');
            return;
          }
          if (descriptionController.text == "") {
            Fluttertoast.showToast(msg: 'Please enter description');
            return;
          }
          ProcessLoaders.showLoading(context);
          // ignore: avoid_print
          print('after loader');
          await locationController.updateLocation();
          // ignore: avoid_print
          print('after location fetch');
          // await firebase.addDog(dog: _dogModel.toJson());
          final id = DateTime.now().microsecondsSinceEpoch.toString();
          // ignore: use_build_context_synchronously
          await markerOperations.addArea(
              context,
              _photo,
              id,
              locationController.currentPosition!.value,
              auth.currentUser!.displayName.toString(),
              '24/05/2023',
              descriptionController.text,
              addressController.text);
          print('after added');
        },
        style: ElevatedButton.styleFrom(fixedSize: const Size(100, 45)),
        child: const Text('Save'),
      ).paddingSymmetric(horizontal: 15, vertical: 10),
    );
  }
}
