import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_paws/views/developement_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 35,
          ),
          CircleAvatar(
            backgroundColor: Colors.red.shade400,
            foregroundColor: Colors.black,
            maxRadius: 50,
            child: Icon(
              Icons.person,
              size: 35,
            ),
          ),

          SizedBox(
            height: 35,
          ),
          ListTile(
            title: Text('Profile'),
            onTap: ()=> Get.to(()=> DevelopmentView()),
          ),
          ListTile(
            title: Text('Achievements'),
            onTap: ()=> Get.to(()=> DevelopmentView()),
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: ()=> Get.toNamed('/login'),
          ),
        ],
      ),
    );
  }
}
