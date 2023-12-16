import 'package:car_pool1/LoginScreen.dart';
import 'package:car_pool1/OrderHistory.dart';
import 'package:car_pool1/ProfilePage.dart';
import 'package:car_pool1/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1/Shared/SharedWidgets/drawer_widget.dart';
import 'package:car_pool1/trips/trip.dart';
import 'package:car_pool1/trips/trip_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'tripDetails.dart';

import 'Shared/SharedTheme/SharedFont.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    // Simulate fetching data from a database
    //_fetchRideRequests();
  }
  late List<dynamic> availableTrips = [];
  late List<dynamic> myDriverInfo = [];

  DatabaseReference tripsRef = FirebaseDatabase.instance.ref("Trips/");

  final Map<String, String> monthToCapital = {
    '01': 'JAN',
    '02': 'FEB',
    '03': 'MAR',
    '04': 'APR',
    '05': 'MAY',
    '06': 'JUN',
    '07': 'JUL',
    '08': 'AUG',
    '09': 'SEP',
    '10': 'OCT',
    '11': 'NOV',
    '12': 'DEC',
  };

  fetchDriverData(String driverID) async {
    DatabaseReference driverInfoRef = FirebaseDatabase.instance.ref("drivers");
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


  @override
  Widget build(BuildContext context) {
    tripsRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        availableTrips.clear();
        event.snapshot.children.forEach((child) {
          availableTrips.add(child.value);
          //print(availableTrips);
        });


        setState(() {

        });
      }
      else {
        availableTrips.clear();
      }
    }, onError: (error) {
      print("error retrieving!");
    });
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Available Trips',
            style:
            TextStyle(
              color: Colors.white,
            )

            ,),
        ),
        centerTitle: true,
        backgroundColor: SharedColor.tealColor,
      ),
      drawer: myDrawer(),

      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemCount: availableTrips.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Card(

                color: availableTrips[index]["Booking_Status"] == 'Available'
                    ? SharedColor.tealColor
                    : Colors.orange,
                child: ListTile(

                  title: Text(
                    'From: ${availableTrips[index]["Pickup"]}\nTo: ${availableTrips[index]["Dropoff"]}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold


                    ),

                  ),


                  leading: Text(
                    '${int.parse(availableTrips[index]["Date"].split(
                        '-')[2])} ${monthToCapital[availableTrips[index]["Date"]
                        .split('-')[1]]}\n${availableTrips[index]["Time"]}',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14
                    ),
                  ),
                  trailing: Text(
                    '${availableTrips[index]["Offered_Price"]} EGP',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16
                    ),
                  ),
                  onTap: () async {
                    //List<dynamic> driverInfo;
                    await fetchDriverData(availableTrips[index]['Driver_ID']);
                    //print(myDriverInfo[0]['name']);
                    // Handle route selection, e.g., navigate to a details page
                    /*_navigateToTripDetails(availableTrips[index], myDriverInfo[0]['name'], myDriverInfo[0]['ProfileImage'],
                        myDriverInfo[0]['car_info'], myDriverInfo[0]['phone']);*/
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            TripDetailsPage(
                                availableTrips[index], myDriverInfo[0]['name'],
                                myDriverInfo[0]['ProfileImage'],
                                myDriverInfo[0]['car_info'],
                                myDriverInfo[0]['phone'])));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}