import 'dart:ffi';

import 'package:happy_paws/models/food_status.dart';

class NgoDetails {
  NgoDetails(
      {required this.ngoId,
      required this.name,
      required this.location,
      required this.approvalStatus,
      required this.places,
      required this.mobile,
      required this.food});

  final String ngoId, name, location;
  final bool approvalStatus;
  final Long mobile;
  final List<String> places;
  final List<FoodStatus> food;

  static NgoDetails fromMapPlaces(Map<String, dynamic> data, String id) =>
      NgoDetails(
        ngoId: id,
        name: data['name'],
        location: data['location'],
        approvalStatus: data['approvalStatus'],
        places: data['places'],
        mobile: data['mobile'],
        food: data['foodStatus'],
      );
}
