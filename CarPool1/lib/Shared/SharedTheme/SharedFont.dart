import 'package:flutter/material.dart';
import 'package:car_pool1/Shared/SharedTheme/SharedColor.dart';

class SharedFont {
  static final TextStyle primaryBlackStyle = TextStyle(color: SharedColor.blackColor, fontSize: 20.0, fontWeight: FontWeight.bold);
  static final TextStyle subGreyStyle = TextStyle(color: SharedColor.greyColor, fontSize: 15.0, fontWeight: FontWeight.bold);
  static final TextStyle subBlackStyle = TextStyle(color: SharedColor.blackColor, fontSize: 17.0, fontWeight: FontWeight.normal);
  static final TextStyle subTealStyle = TextStyle(color: SharedColor.tealColor, fontSize: 15.0, fontWeight: FontWeight.bold);
  static final TextStyle whiteStyle = TextStyle(color: Colors.white, fontSize: 20.0);
  static final TextStyle appBarTitle = TextStyle(color:SharedColor.tealColor, fontSize: 30.0, fontWeight: FontWeight.bold );
}