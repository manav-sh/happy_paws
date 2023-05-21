import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_paws/constants/auth.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/constants/styles.dart';
import 'package:happy_paws/views/developement_view.dart';
import 'package:happy_paws/widgets/home_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: primaryRedLight,
        foregroundColor: black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                color: primaryRedLight),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(children: [
              NetWorkImageIcon(
                activeBg: Colors.white,
                imageUrl: auth.currentUser!.photoURL.toString(),
                size: 100,
                borderSize: 4,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    auth.currentUser!.displayName.toString(),
                    style: profileName,
                  ),
                  const SizedBox(height: 10)
                ],
              )
            ]),
          ),
          const SizedBox(
            height: 35,
          ),
          ListTile(
            title: const Text('Profile', style: profileListItems),
            onTap: () => Get.to(() => const DevelopmentView()),
          ),
          ListTile(
            title: const Text('Achievements', style: profileListItems),
            onTap: () => Get.to(() => const DevelopmentView()),
          ),
          ListTile(
            title: const Text('Sign Out', style: profileListItems),
            onTap: () => authController.signOut(),
          ),
        ],
      ),
    );
  }
}
