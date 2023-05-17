import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/controller/navbar_controller.dart';
import 'package:happy_paws/widgets/add_bottomsheet.dart';
import 'package:happy_paws/widgets/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  static const LatLng _center = LatLng(45.521563, -122.677433);

  final NavbarController navbarController =
      Get.put(NavbarController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            compassEnabled: false,
            zoomControlsEnabled: false,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              height: 50,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryRed,
        onPressed: () => addBottomSheet(),
        child: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Obx(() => BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => navbarController.changeIndex(0),
                    borderRadius: BorderRadius.circular(16),
                    child: NavBarIcon(
                        icon: 'home',
                        color: navbarController.isActive(0)
                            ? primaryRed
                            : const Color(0xff5c5c5c),
                        activeBg: navbarController.isActive(0)
                            ? primaryRedBg
                            : Colors.transparent),
                  ),
                  InkWell(
                    onTap: () => navbarController.changeIndex(1),
                    borderRadius: BorderRadius.circular(16),
                    child: NavBarIcon(
                        icon: 'contributions',
                        color: navbarController.isActive(1)
                            ? primaryRed
                            : const Color(0xff5c5c5c),
                        activeBg: navbarController.isActive(1)
                            ? primaryRedBg
                            : Colors.transparent),
                  ),
                  InkWell(
                    onTap: () => navbarController.changeIndex(3),
                    borderRadius: BorderRadius.circular(16),
                    child: NavBarIcon(
                        icon: 'profile',
                        color: navbarController.isActive(3)
                            ? primaryRed
                            : const Color(0xff5c5c5c),
                        activeBg: navbarController.isActive(3)
                            ? primaryRedBg
                            : Colors.transparent),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          )),
    );
  }
}
