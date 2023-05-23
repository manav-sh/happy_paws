import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_paws/models/food_status.dart';

class MapPlaces {
  MapPlaces(
      {required this.placeId,
      required this.latLng,
      required this.addedOn,
      required this.addedBy,
      required this.description,
      required this.foodStatus,
      required this.photoUrl});

  final String placeId, addedBy, photoUrl, description, addedOn;
  final FoodStatus foodStatus;
  final LatLng latLng;

  static MapPlaces fromMapPlaces(Map<String, dynamic> data, String id) =>
      MapPlaces(
        placeId: id,
        description: data['content'],
        photoUrl: data['isDone'],
        addedBy: data['addedBy'],
        addedOn: data['addedOn'],
        latLng: data['latLng'],
        foodStatus: data['foodStatus'],
      );
}
