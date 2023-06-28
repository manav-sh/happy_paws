import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_paws/constants/auth.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/controller/location_permission_controller.dart';
import 'package:happy_paws/controller/navbar_controller.dart';
import 'package:happy_paws/service/marker_operations.dart';
import 'package:happy_paws/views/home.dart';
import 'package:happy_paws/views/profile_screen.dart';
import 'package:happy_paws/widgets/add_bottomsheet.dart';
import 'package:happy_paws/widgets/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NavbarController navbarController =
      Get.put(NavbarController(), permanent: false);

  final LocationController getLocation = Get.put(LocationController());
  final MarkerOperations markerOperations = Get.put(MarkerOperations());

  @override
  void initState() {
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
                          child: Text('Location Permission Not granted'),
                        ).paddingSymmetric(horizontal: 20)
                      : const Home()),
              const ProfileScreen(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      navbarController.changeIndex(0);
                      markerOperations.getMapCircles();
                    },
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
                  // InkWell(
                  //   onTap: () => navbarController.changeIndex(1),
                  //   borderRadius: BorderRadius.circular(16),
                  //   child: NavBarIcon(
                  //       icon: 'contributions',
                  //       color: navbarController.isActive(1)
                  //           ? primaryRed
                  //           : const Color(0xff5c5c5c),
                  //       activeBg: navbarController.isActive(1)
                  //           ? primaryRedBg
                  //           : Colors.transparent),
                  // ),
                  InkWell(
                    onTap: () => navbarController.changeIndex(1),
                    borderRadius: BorderRadius.circular(20),
                    child: (auth.currentUser!.photoURL == null)
                        ? NavBarIcon(
                            icon: 'profile',
                            color: navbarController.isActive(1)
                                ? primaryRed
                                : const Color(0xff5c5c5c),
                            activeBg: navbarController.isActive(1)
                                ? primaryRedBg
                                : Colors.transparent)
                        : NetWorkImageIcon(
                            imageUrl: auth.currentUser!.photoURL.toString(),
                            size: 35,
                            borderSize: 3,
                            activeBg: navbarController.isActive(1)
                                ? primaryRedLight
                                : primaryRedBg),
                  ),
                  // const SizedBox(width: 20),
                ],
              ),
            ),
          )),
    );
  }
}
