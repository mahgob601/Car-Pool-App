import 'dart:io';
import 'dart:typed_data';


import 'package:car_pool1_driver/models/global_var.dart';
import 'package:car_pool1_driver/ProfilePage.dart';
import 'package:car_pool1_driver/Shared/DBHandler/firebase_storage.dart';
import 'package:car_pool1_driver/Shared/SharedMethods/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'Shared/SharedTheme/SharedColor.dart';
import 'Shared/SharedWidgets/profile_widget.dart';
import 'Shared/SharedWidgets/snack_widget.dart';
import 'Shared/SharedWidgets/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //User user = UserPreferences.myUser;


  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController editusernameController = TextEditingController();






  Future<Uint8List> selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      tempProfileImage = img;
    });
    return img;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:18.0),
          child: Text(
            "Edit Profile",
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height:10),
          Center(

              child: Stack(
                children: [
                  tempProfileImage != null?
                  ClipOval(
                    child: Material(
                      child: Ink.image(
                        image: MemoryImage(tempProfileImage!),
                        fit: BoxFit.cover,
                        width: 128,
                        height: 128 ,
                        child: InkWell(onTap: ()
                        {
                          selectImage();
                          setState(() {

                          });


                        },),
                      ),
                    ),
                  ) :
                  ClipOval(
                    child: Material(
                      child: Ink.image(
                        image: NetworkImage(profileImageURL),
                        fit: BoxFit.cover,
                        width: 128,
                        height: 128 ,
                        child: InkWell(onTap: ()
                        {
                          selectImage();
                          setState(() {

                          });

                        },),
                      ),
                    ),
                  )
                  ,
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
                                Icons.add_a_photo,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                  ),

                ],
              )
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: editusernameController,

                decoration: InputDecoration(
                  labelText: userName,
                  floatingLabelBehavior: FloatingLabelBehavior.never,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),

                  ),
                ),

              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try{
                  final User? user = auth.currentUser;
                  DatabaseReference usereRef = FirebaseDatabase.instance.ref().child("drivers").child("${user!.uid}");
                  if(tempProfileImage != null)
                  {
                    profileImageURL = await StoreData().uploadImage('drivers/ProfileImage/${user!.uid}/myImage', tempProfileImage!);
                    usereRef.update({"ProfileImage":profileImageURL});
                  }
                  if(editusernameController.text.trim().isNotEmpty)
                  {
                    usereRef.update({"name":editusernameController.text});
                    userName = editusernameController.text;
                  }



                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyProfile()));

                }
                catch(err){
                  ScaffoldMessenger.of(context).showSnackBar(snack("${err.toString()}", 3, Colors.red));

                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                primary: Colors.blueGrey, // Change the color according to your design
              ),
              child: Text(
                'Update info',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ),
          const SizedBox(height:8),
          Center(
            child: ElevatedButton(
              onPressed: ()  {

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyProfile()));

              },


              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                primary: Colors.red, // Change the color according to your design
              ),
              child: Text(
                'Discard',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          )


        ],
      ),
    );
  }
}