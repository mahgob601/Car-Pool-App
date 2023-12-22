import 'package:car_pool1/Cart.dart';
import 'package:car_pool1/Globals/global_var.dart';
import 'package:car_pool1/HomePage.dart';
import 'package:car_pool1/Shared/SharedTheme/SharedColor.dart';
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
          DrawerHeader(

            decoration: BoxDecoration(
              color: SharedColor.tealColor,
            ),
            child: Text(''),
          ),
          ListTile(
            leading: Icon(
              Icons.home,

            ),
            title: const Text('Available Trips'),
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
              Icons.history,
            ),
            title: const Text('Order History'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return OrderHistory();}));
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
              userPhone = "";
              userID = "";
              profileImageURL = '';
              tempProfileImage =null;
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}



