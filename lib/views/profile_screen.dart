import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_paws/constants/auth.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/constants/styles.dart';
import 'package:happy_paws/views/developement_view.dart';
import 'package:happy_paws/widgets/home_widgets.dart';
import 'package:happy_paws/widgets/popups.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  final int contributions = 20;

  Widget achievementCard(double size, bool completed, String medal,
      int requiredContributions, String name) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () =>
          achievementInfo(name, medal, contributions, requiredContributions),
      child: Container(
        width: size,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                width: 1.5,
                style: completed ? BorderStyle.solid : BorderStyle.none,
                color:
                    completed ? Colors.green.shade300 : Colors.grey.shade300),
            color: completed ? Colors.green.shade50 : Colors.grey.shade100),
        child: Column(children: [
          Opacity(
            opacity: completed ? 0.9 : 0.4,
            child: Image.asset(
              'assets/images/$medal.png',
              width: size - 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: completed ? cardCompleted : cardNotCompleted)
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.grey.shade200,
        foregroundColor: black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                color: Colors.grey.shade200),
            padding:
                const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 30),
            child: Row(children: [
              (auth.currentUser!.photoURL == null)
                  ? const Icon(
                      Icons.person,
                      size: 100,
                    )
                  : NetWorkImageIcon(
                      activeBg: Colors.transparent,
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
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade500, width: 1.4),
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(children: [
                      Image.asset(
                        'assets/images/bronze_medal.png',
                        width: 20,
                        scale: 1.7,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$contributions contributions',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ]),
                  )
                ],
              )
            ]),
          ),
          const SizedBox(
            height: 35,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Badges',
              style: profileBadges,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                achievementCard(
                    width / 3.7,
                    (10 - contributions <= 0) ? true : false,
                    'bronze_medal',
                    10,
                    'Furrbuddy'),
                achievementCard(
                    width / 3.7,
                    (50 - contributions <= 0) ? true : false,
                    'silver_medal',
                    50,
                    'Barktender'),
                achievementCard(
                    width / 3.7,
                    (100 - contributions <= 0) ? true : false,
                    'gold_medal',
                    100,
                    'Woofkeeper'),
              ],
            ),
          ),
          ListTile(
            leading: const ImageIcon(
              AssetImage('assets/icons/contributions.png'),
              size: 25,
              color: lightBlack,
            ),
            title: const Text('Achievements', style: profileListItems),
            onTap: () => Get.to(() => const DevelopmentView()),
            minLeadingWidth: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app_outlined,
              size: 25,
              color: lightBlack,
            ),
            title: const Text('Sign Out', style: profileListItems),
            onTap: () => authController.signOut(),
            minLeadingWidth: 20,
          ),
        ],
      ),
    );
  }
}
