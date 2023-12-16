import 'package:car_pool1_driver/LoginScreen.dart';
import 'package:car_pool1_driver/OrderHistory.dart';
import 'package:car_pool1_driver/ProfilePage.dart';
import 'package:car_pool1_driver/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1_driver/Shared/SharedWidgets/drawer_widget.dart';
import 'package:car_pool1_driver/models/global_var.dart';
import 'package:car_pool1_driver/trips/trip.dart';
import 'package:car_pool1_driver/trips/trip_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<dynamic> availableTrips = [];
  late List<dynamic> myDriverInfo = [];

  DatabaseReference tripsRef = FirebaseDatabase.instance.ref("Trips/");
  void initState() {
    fetchmyData();
    super.initState();
  }


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

  fetchmyData() async {
    tripsRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        availableTrips.clear();
        Map <dynamic,dynamic> tripVals;
        event.snapshot.children.forEach((child) {

          tripVals = child.value as Map;
          if(tripVals['Driver_ID'] == userID)
          {
            availableTrips.add(child.value);
          }

          //print(availableTrips);
        });


        setState(() {
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));

        });
      }
      else {
        availableTrips.clear();
      }
    }, onError: (error) {
      print("error retrieving!");
    });
  }


  @override
  Widget build(BuildContext context) {
    fetchmyData();
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('My Trips',
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
          //future: availableTrips.length,
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
                    //await fetchDriverData(availableTrips[index]['Driver_ID']);
                    //print(myDriverInfo[0]['name']);
                    // Handle route selection, e.g., navigate to a details page
                    /*_navigateToTripDetails(availableTrips[index], myDriverInfo[0]['name'], myDriverInfo[0]['ProfileImage'],
                        myDriverInfo[0]['car_info'], myDriverInfo[0]['phone']);*/
                    /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            TripDetailsPage(
                                availableTrips[index], myDriverInfo[0]['name'],
                                myDriverInfo[0]['ProfileImage'],
                                myDriverInfo[0]['car_info'],
                                myDriverInfo[0]['phone'])));*/
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