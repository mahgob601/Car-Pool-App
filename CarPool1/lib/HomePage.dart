import 'package:car_pool1/Globals/global_var.dart';
import 'package:car_pool1/LoginScreen.dart';
import 'package:car_pool1/OrderHistory.dart';
import 'package:car_pool1/ProfilePage.dart';
import 'package:car_pool1/Shared/DBHandler/trip_controller.dart';
import 'package:car_pool1/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1/Shared/SharedWidgets/drawer_widget.dart';
import 'package:car_pool1/Shared/DBHandler/trip_controller.dart';
import 'package:car_pool1/trips/trip.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'tripDetails.dart';
import 'Globals/tip_globals.dart';
import 'Shared/SharedTheme/SharedFont.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

  static void updateState() {
    _HomePageState? currentState = _HomePageState.currentState;
    if (currentState != null) {
      currentState.updateState();
    }
  }
}

class _HomePageState extends State<HomePage> {
  static _HomePageState? currentState;
  TripController TC = TripController();

  void state() {
    setState((){});
  }
  void initState(){
    //print(DateTime.now());
    TC.fetchAllTrips();
    super.initState();
    currentState = this;
    // Simulate fetching data from a database
    //_fetchRideRequests();
  }


  @override
  void dispose() {
    currentState = null;
    super.dispose();
  }

  void updateState() {
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {

    TC.fetchAllTrips();
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
                    await TC.fetchDriverData(availableTrips[index]['Driver_ID']);
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