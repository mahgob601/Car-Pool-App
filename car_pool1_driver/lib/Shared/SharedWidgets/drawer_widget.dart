import 'package:car_pool1_driver/Cart.dart';
import 'package:car_pool1_driver/models/global_var.dart';
import 'package:car_pool1_driver/HomePage.dart';
import 'package:car_pool1_driver/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1_driver/AddTripScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../LoginScreen.dart';
import '../../OrderHistory.dart';
import '../../ProfilePage.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({super.key});

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(

            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Text(''),
          ),
          ListTile(
            leading: Icon(
              Icons.home,

            ),
            title: const Text('My Trips'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,

            ),
            title: const Text('My Profile'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyProfile()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add
            ),
            title: const Text('Add Trip'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AddTripScreen()));
            },
          ),



          ListTile(
            leading: Icon(
              Icons.logout,
            ),
            title: const Text('Sign out'),
            onTap: () async {
              userName = '';
              userEmail = '';
              profileImageURL = '';
              userID = '';
              tempProfileImage = null;
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}



