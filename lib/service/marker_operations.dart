import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/constants/db.dart';
import 'package:happy_paws/models/map_places.dart';
import 'package:happy_paws/service/image_storage.dart';
import 'package:happy_paws/utils/logger.dart';
import 'package:happy_paws/widgets/loading_builders.dart';

class MarkerOperations extends GetxController {
  RxBool dataFetched = false.obs;
  RxList<MapPlaces> mapsPlaces = <MapPlaces>[].obs;
  RxSet<Circle> mapsCircles = <Circle>{}.obs;

  Future<void> addArea(
    BuildContext context,
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
        await placesDb.doc(id).set({
          'location': point,
          'photoUrl': url,
          'addedBy': username,
          'addedOn': addedOn,
          'description': description,
          'address': address
        }).then((value) {
          ProcessLoaders.hideLoading(context);
          Get.snackbar(
              'Success', 'Your contribution has beed added on the maps');
        }).catchError((err) {
          Get.snackbar(
              'Error', 'Error while adding place to maps. please try again');
        });
      } else {
        ProcessLoaders.hideLoading(context);
        Get.snackbar('Image Upload Error',
            'Error while uploading image. Please Try again');
      }
    } catch (e) {
      ProcessLoaders.hideLoading(context);
      Get.snackbar('Error', 'Some technical error occured');
    }
  }

  Future<void> getMapCircles() async {
    dataFetched.value = false;
    List<MapPlaces> mapsPlacesDb = [];
    await placesDb.get().then((e) {
      mapsPlacesDb = e.docs
          .map((e) => MapPlaces.fromMapPlaces(e.data(), e.reference.id))
          .toList();
    });

    mapsPlaces.assignAll(mapsPlacesDb);
    List<Circle> tempList = [];
    // mapsPlaces.map((value) {
    // tempList.add(Circle(
    //     circleId: CircleId(value.placeId),
    //     center: value.latLng,
    //     radius: 20,
    //     fillColor: primaryRedBg,
    //     strokeWidth: 2,
    //     strokeColor: primaryRed500));
    // logger.i(tempList);
    // });
    logger.i(mapsPlaces);
    for (var i in mapsPlacesDb) {
      tempList.add(Circle(
          circleId: CircleId(i.placeId),
          center: i.latLng,
          radius: 20,
          fillColor: primaryRedBg,
          strokeWidth: 2,
          strokeColor: primaryRed500,
      ));
    }
    mapsCircles = tempList.toSet().obs;
    mapsCircles.refresh();
    logger.i(mapsCircles); // mapCircles is of type RxSet<Circle>
    dataFetched.value = true;
    // return mapsPlaces;
  }
}

class MarkerOperationsGetx extends GetxController {
  RxList<MapPlaces> places = <MapPlaces>[].obs;
}
