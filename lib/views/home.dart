import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/controller/location_permission_controller.dart';
import 'package:happy_paws/service/marker_operations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller = Completer();

  final LocationController getLocation = Get.put(LocationController());
  final MarkerOperations markerOperations = Get.put(MarkerOperations());

  late String _mapStyle;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    controller.setMapStyle(_mapStyle);
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/mapStyle.txt').then((string) {
      _mapStyle = string;
    });
    getLocation.updateLocation();
    markerOperations.getMapCircles();
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
                  zoom: 18.5,
                ),
                circles: markerOperations.dataFetched.isTrue
                    ? markerOperations.mapsCircles
                    : {
                        Circle(
                            circleId: const CircleId('temp_marker'),
                            center: LatLng(
                                getLocation.currentPosition!.value.latitude,
                                getLocation.currentPosition!.value.longitude),
                            radius: 10,
                            fillColor: primaryRedBg,
                            strokeWidth: 2,
                            strokeColor: primaryRed500,
                            consumeTapEvents: true,
                            onTap: () {
                              Get.bottomSheet(Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 30),
                                child: const Text('I am bottom sheet'),
                              ));
                            })
                      },
                myLocationEnabled: true,
                compassEnabled: false,
                zoomControlsEnabled: false,
                padding: const EdgeInsets.only(top: 100),
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
        ),
      ],
    );
  }
}
