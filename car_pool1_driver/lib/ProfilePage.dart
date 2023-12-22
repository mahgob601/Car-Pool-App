import 'package:car_pool1_driver/models/global_var.dart';
import 'package:car_pool1_driver/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1_driver/Shared/SharedWidgets/drawer_widget.dart';
import 'package:car_pool1_driver/edit_profile_page.dart';
import 'package:flutter/material.dart';

import 'Shared/SharedTheme/SharedFont.dart';
import 'Shared/SharedWidgets/profile_widget.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:18.0),
          child: Text(
            "My Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      drawer: myDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top:55.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
        Center(
          child: Stack(
            children:
                [
              /*profileImage != null?
              ClipOval(
                child: Material(
                  child: Ink.image(
                    image: MemoryImage(profileImage!),
                    fit: BoxFit.cover,
                    width: 128,
                    height: 128 ,
                    child: InkWell(onTap: ()
                    {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => EditProfilePage()));



                    },),
                  ),
                ),

              ) :*/
              ClipOval(
                child: Material(
                  child: Ink.image(
                    image: NetworkImage(profileImageURL),
                    fit: BoxFit.cover,
                    width: 128,
                    height: 128 ,
                    child: InkWell(onTap: ()
                    {
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => EditProfilePage()));
                    },),
                  ),
                ),
              ),

                  Positioned(
                      bottom: 0,
                      right: 4,
                      child: ClipOval(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(3),
                          child: ClipOval(
                            child: Container(
                              color: Colors.blueGrey,
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
    ]
          ),
        ),
            SizedBox(height: 24,),
            Column(
              children: [
                Text(
                    userName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),

                ),
                SizedBox(height: 14,),
                Text(
                    userEmail,
                  style: TextStyle(color: Colors.grey),

                ),
                SizedBox(height: 24,),

                Text(
                  userEmail,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),


              ],
            ),
            SizedBox(height: 30,),



            Center(
              child: ElevatedButton(
                onPressed: ()  {

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => EditProfilePage()));

                },


                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),

                    backgroundColor: Colors.blueGrey// Change the color according to your design
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            ),
                /*TextButton(
                    child: Text('Edit my account', style: SharedFont.whiteStyle),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        maximumSize: Size(200.0, 50.0),
                        minimumSize: Size(200.0, 50.0)
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => EditProfilePage()));

                    }

                ),*/

              ],
            )


        ),
      );

  }
}
