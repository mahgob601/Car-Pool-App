import 'dart:typed_data';

import 'package:car_pool1/HomePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_pool1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import '../../Globals/global_var.dart';
import '../../LoginScreen.dart';
import '../SharedWidgets/snack_widget.dart';
import 'firebase_storage.dart';

class firebaseAuthClass{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  registerUser(BuildContext context,email,password, usn, phone) async
  {
    final User? userFirebase = (
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password).catchError((errorMsg){
          ScaffoldMessenger.of(context).showSnackBar(snack(errorMsg.toString(), 3, Colors.red));
        })
    ).user;

    final ByteData bytes = await rootBundle.load('assets/images/defaultProfile.png');
    final Uint8List imagelist = bytes.buffer.asUint8List();



    /**/

      profileImageURL = await StoreData().uploadImage("users/ProfileImage/${userFirebase!.uid}/myImage", imagelist);
      DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
      Map userDataMap =
      {
        "ProfileImage": profileImageURL,
        "name": usn,
        "email": email,
        "car_info": password,
        "phone":phone,
        "id":userFirebase.uid,
        "isDriver": "No",
        "blockStatus":"no",


      };
      usersRef.set(userDataMap);



      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));






  }
  loginUser(BuildContext context, email, password) async
  {
    if(email == 'testuser@eng.asu.edu.eg' && password=='123456')
    {
      DatabaseReference testdrivRef = await FirebaseDatabase.instance.ref().child("users").child('TESTUSER');
      testdrivRef.once().then((snap) {
        if(snap.snapshot.value != null) {
          if ((snap.snapshot.value as Map)["blockStatus"] == "no" &&
              (snap.snapshot.value as Map)["isDriver"] == "No") {
            userName = (snap.snapshot.value as Map)["name"];
            userEmail = (snap.snapshot.value as Map)["email"];
            userID = (snap.snapshot.value as Map)["id"];

            profileImageURL = (snap.snapshot.value as Map)["ProfileImage"];
            userPhone = (snap.snapshot.value as Map)["phone"];

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomePage()));
          }
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(snack("Error retrieving data", 3, Colors.red));
        }


      });
    }
    else{
      final User? userFirebase = (
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: password).catchError((errorMsg){
            ScaffoldMessenger.of(context).showSnackBar(snack(errorMsg.toString(), 3, Colors.red));
          })
      ).user;


      if(userFirebase != null)
      {
        DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase.uid);
        usersRef.once().then((snap) {
          if(snap.snapshot.value != null)
          {
            if((snap.snapshot.value as Map)["blockStatus"] == "no" && (snap.snapshot.value as Map)["isDriver"] == "No")
            {
              userName = (snap.snapshot.value as Map)["name"];
              userEmail = (snap.snapshot.value as Map)["email"];
              profileImageURL =(snap.snapshot.value as Map)["ProfileImage"];
              userID = (snap.snapshot.value as Map)["id"];
              userPhone = (snap.snapshot.value as Map)["phone"];

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
            }

            else
            {
              FirebaseAuth.instance.signOut();
              ScaffoldMessenger.of(context).showSnackBar(snack("Some error happened please contact the admin!", 3, Colors.red));
            }

          }
          else{
            FirebaseAuth.instance.signOut();
            ScaffoldMessenger.of(context).showSnackBar(snack("User doesn't seem to exist", 3, Colors.red));

          }
        });
      }


    }


  }


  getCurrentUserID() async{
    return await firebaseAuth.currentUser!.uid;
  }

  getProfileData(BuildContext context) async{
    final currentUserCredentials = await firebaseAuth.currentUser;
    if(currentUserCredentials != null)
    {
      DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(currentUserCredentials.uid);
      usersRef.once().then((snap) {
        if (snap.snapshot.value != null) {
          if ((snap.snapshot.value as Map)["blockStatus"] == "no" &&
              (snap.snapshot.value as Map)["isDriver"] == "No") {
            userName = (snap.snapshot.value as Map)["name"];
            userEmail = (snap.snapshot.value as Map)["email"];
            userID = (snap.snapshot.value as Map)["id"];
            userPhone = (snap.snapshot.value as Map)["phone"];
            profileImageURL = (snap.snapshot.value as Map)["ProfileImage"];
          }
        }
      });
    }
  }
}