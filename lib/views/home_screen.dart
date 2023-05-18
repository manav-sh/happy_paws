import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/controller/location_permission_controller.dart';
import 'package:happy_paws/controller/navbar_controller.dart';
import 'package:happy_paws/views/home.dart';
import 'package:happy_paws/widgets/add_bottomsheet.dart';
import 'package:happy_paws/widgets/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const LatLng _center = LatLng(45.521563, -122.677433);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final NavbarController navbarController =
      Get.put(NavbarController(), permanent: false);

  final LocationController getLocation = Get.put(LocationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation.locationStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(() => IndexedStack(
            index: navbarController.index.value,
            children: [
              (getLocation.isGranted.value == 0)
                  ? const Center(child: CircularProgressIndicator())
                  : ((getLocation.isGranted.value == 1)
                      ? const Center(
                          child: Text('Not granted'),
                        )
                      : Home()),
              const Center(
                child: Text('NGOs'),
              ),
              const Center(
                child: Text('Profile'),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addBtn',
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
                    onTap: () => navbarController.changeIndex(2),
                    borderRadius: BorderRadius.circular(16),
                    child: NavBarIcon(
                        icon: 'profile',
                        color: navbarController.isActive(2)
                            ? primaryRed
                            : const Color(0xff5c5c5c),
                        activeBg: navbarController.isActive(2)
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
