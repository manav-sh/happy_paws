import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_paws/controller/location_permission_controller.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller = Completer();

  final LocationController getLocation = Get.put(LocationController());

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation.updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => getLocation.isDataFetched.value
            ? GoogleMap(
                minMaxZoomPreference: const MinMaxZoomPreference(5, 20),
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(getLocation.currentPosition!.value.latitude,
                      getLocation.currentPosition!.value.longitude),
                  zoom: 18.0,
                ),
                compassEnabled: false,
                zoomControlsEnabled: false,
              )
            : const Center(
                child: CircularProgressIndicator(),
              )),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Row(children: const [
              ImageIcon(
                AssetImage('assets/images/dog_paws.png'),
                size: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                'Happy Paws',
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ]),
          ),
        )
      ],
    );
  }
}
