import 'package:car_pool1_driver/Shared/DBHandler/firebaseAuth.dart';
import 'package:car_pool1_driver/models/global_var.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_pool1_driver/models/trip_model.dart';

import '../SharedWidgets/snack_widget.dart';

class TripControllerClass{
  addTrip(BuildContext context, Trip trip) async
  {
    DatabaseReference tripsRef = FirebaseDatabase.instance.ref().child("Trips").push();
    Map tripDataMap =
    {
      "Trip_ID": tripsRef.key,
      "Driver_ID": trip.driverID,
      "Pickup": trip.pickup,
      "Dropoff": trip.dropoff,
      "Time":trip.tripTime,
      "Date": trip.tripDate,
      "Offered_Price": trip.offeredPrice,
      "Booking_Status": trip.bookingStatus,
      "Passengers": trip.passengers,
      "Ride_Status": trip.rideStatus,
      'Driver_Name': userName,
      'Driver_Profile': profileImageURL,
      'Driver_Number': driverNumber,


    };
    tripsRef.set(tripDataMap);
    ScaffoldMessenger.of(context).showSnackBar(
        snack('Trip Successfully added !', 3, Colors.green)
    );

  }



}