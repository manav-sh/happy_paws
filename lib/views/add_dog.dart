import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_paws/constants/auth.dart';
import 'package:happy_paws/constants/db.dart';
import 'package:happy_paws/controller/location_permission_controller.dart';
import 'package:happy_paws/models/dog_model.dart';
import 'package:happy_paws/service/firebase.dart';
import 'package:happy_paws/utils/toast.dart';
import 'package:image_picker/image_picker.dart';

class AddDog extends StatefulWidget {
  const AddDog({super.key});

  @override
  State<AddDog> createState() => _AddDogState();
}

class _AddDogState extends State<AddDog> {
  bool _imageSelected = false;
  File? _photo;
  DogModel _dogModel = DogModel.fromJson({});

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
                      ),
                      child: const Icon(Icons.add),
                    ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onSubmitted: (value) {
                _dogModel.description = value;
              },
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
              onSubmitted: (value) {
                _dogModel.address = value;
              },
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
          // if (_dogModel.address.isEmpty) {
          //   return showToastMsg('Please enter address');
          // }
          // if (_dogModel.description.isEmpty) {
          //   return showToastMsg('Please enter address');
          // }
          // await firebase.addDog(dog: _dogModel.toJson());
          final id = DateTime.now().microsecondsSinceEpoch.toString();
          await markerOperations.addArea(
              _photo,
              id,
              locationController.currentPosition!.value,
              auth.currentUser!.displayName.toString(),
              '24/05/2023',
              _dogModel.description,
              _dogModel.address);
        },
        style: ElevatedButton.styleFrom(fixedSize: const Size(100, 45)),
        child: const Text('Save'),
      ).paddingSymmetric(horizontal: 15, vertical: 10),
    );
  }
}
