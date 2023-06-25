import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:happy_paws/constants/db.dart';
import 'package:happy_paws/models/map_places.dart';
import 'package:happy_paws/service/image_storage.dart';
import 'package:happy_paws/widgets/loading_builders.dart';

class MarkerOperations {
  Future<void> addArea(
    File? photo,
    String id,
    Position latLng,
    String username,
    String addedOn,
    String description,
    String address,
  ) async {
    try {
      String? url = await FirestoreImage.uploadFile(photo);
      // To store geopoints in fb
      if (url != null) {
        GeoPoint point = GeoPoint(latLng.latitude, latLng.longitude);
        await places.doc(id).set({
          'location': point,
          'photoUrl': url,
          'addedBy': username,
          'addedOn': addedOn,
          'description': description,
          'address': address
        }).then((value) {
          ProcessLoaders.hideLoading();
          Get.snackbar(
              'Success', 'Your contribution has beed added on the maps');
        }).catchError((err) {
          Get.snackbar(
              'Error', 'Error while adding place to maps. please try again');
        });
      } else {
        ProcessLoaders.hideLoading();
        Get.snackbar('Image Upload Error',
            'Error while uploading image. Please Try again');
      }
    } catch (e) {
      ProcessLoaders.hideLoading();
      Get.snackbar('Error', 'Some technical error occured');
    }
  }

  Future<List<MapPlaces>> getAreas() async {
    List<MapPlaces> mapsPlaces = [];
    places.get().then((e) {
      mapsPlaces = e.docs
          .map((e) => MapPlaces.fromMapPlaces(e.data(), e.reference.id))
          .toList();
    });
    return mapsPlaces;
  }
}
