import 'package:car_pool1/HomePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:car_pool1/firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Globals/global_var.dart';
import '../../Globals/tip_globals.dart';
import '../SharedWidgets/snack_widget.dart';


class TripController
{
reserveTrip(String TripID, BuildContext context) async{
  DatabaseReference userRequestsRef = FirebaseDatabase.instance.ref("Trips/${TripID}/UserRequests/$userID");
  await userRequestsRef.set({
    'User_ID': userID,
    'name':userName,
    'Request_Status':'Pending',
    'userProfileImage': profileImageURL,
    'phone': userPhone,
  });



 }



fetchDriverData(String driverID) async {

  final snapshot = await driverInfoRef.child('${driverID}').get();
  if (snapshot.exists) {
    myDriverInfo.clear();
    myDriverInfo.add(snapshot.value);
    print(snapshot.value);
  }
  else {
    myDriverInfo.clear();
    print('no dattttttta!!!');
  }
}

fetchAllTrips() async
{
  tripsRef.onValue.listen((event) {
    if (event.snapshot.exists) {
      Map<dynamic,dynamic> currentTrip ={};
      availableTrips.clear();
      event.snapshot.children.forEach((child) {
        //myTrip['UserRequests'].keys.toList().contains(userID)

        availableTrips.add(child.value);


        //print(availableTrips);
      });
      availableTrips.map((e) => e);
      availableTrips = availableTrips.where((theTrip) {
        DateTime tripDate = DateTime.parse(theTrip['Date']);
        print(tripDate);
        DateTime reservationTime;

        DateTime now = DateTime.now();

        if (theTrip['Time'] == "7.30 AM") {
          reservationTime = DateTime(tripDate.year, tripDate.month, tripDate.day, 22, 0, 0).subtract(Duration(days: 1)); // 10:00 pm previous day
        } else {
          reservationTime = DateTime(tripDate.year, tripDate.month, tripDate.day, 16, 0, 0); // 1:00 pm same day
        }

        // Return true if the current time is before the reservation time
        return now.isBefore(reservationTime);
      }).toList();


      HomePage.updateState();

      /*setState(() {

      });*/
    }
    else {
      availableTrips.clear();
    }
  }, onError: (error) {
    print("error retrieving!");
  });
}



      }




