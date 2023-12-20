import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';



String userName = "";
String userID = "";
String userEmail = "";
String defaultProfileImagePath = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/768px-Windows_10_Default_Profile_Picture.svg.png?20221210150350";
Uint8List? tempProfileImage;
Uint8List? profileImage;
String profileImageURL = "";
String driverNumber = "";