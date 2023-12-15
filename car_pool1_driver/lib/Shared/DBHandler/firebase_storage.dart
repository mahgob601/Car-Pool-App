import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage fb_storage =  FirebaseStorage.instance;

class StoreData{
  Future<String> uploadImage(String childName, Uint8List file) async{
   Reference ref =  fb_storage .ref().child(childName);
   UploadTask uploadTask = ref.putData(file);
   TaskSnapshot snapshot = await uploadTask;
   String downloadURL = await snapshot.ref.getDownloadURL();
   return downloadURL;
  }
}