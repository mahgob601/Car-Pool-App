import 'package:car_pool1/Shared/SharedWidgets/drawer_widget.dart';

import 'package:car_pool1/trips/trip.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Globals/global_var.dart';
import 'LoginScreen.dart';
import 'ProfilePage.dart';
import 'Shared/SharedTheme/SharedColor.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  DatabaseReference userRequestsRef = FirebaseDatabase.instance.ref("Trips/");
   List<MyTrip> myOrderHistory=[];

  Map<dynamic,dynamic> myTrip = {};
  Map<dynamic,dynamic> myTripsKeys = {};
  void initState()
  {

    fetchRequestAndRideStatusChanges(/*userRequestsRef.child('UserRequests')*/);
    super.initState();
  }



  fetchRequestAndRideStatusChanges(/*DatabaseReference userRequestsRef*/) async {
    userRequestsRef.once().then((snap){
      if(snap.snapshot.value != null)
        {
          myOrderHistory.clear();
          snap.snapshot.children.forEach((child) {

            myTrip = child.value as Map;
            //myTripsKeys = child.key as  Map;
            if(myTrip['UserRequests'].keys.toList().contains(userID))
              {
                MyTrip trip = MyTrip(driverName: myTrip['Driver_Name'].toString(), driverNumber: myTrip['Driver_Number'].toString(),
                    driverProfileURL: myTrip['Driver_Profile'].toString()
                    , meetingPoint: myTrip['Pickup'].toString(), myRequestStatus: myTrip['UserRequests'][userID]['Request_Status'],
                    tripRideStatus: myTrip['Ride_Status'].toString()
                    , dropPoint: myTrip['Dropoff'].toString(), date: myTrip['Date'].toString(),
                    price: double.parse(myTrip['Offered_Price']), time: myTrip['Time'].toString());
                /*MyTrip thisTrip = MyTrip(driverName: 'driverName', driverNumber: 'driverNumber',
                    driverProfileURL: 'driverProfileURL', meetingPoint: 'meetingPoint',
                    myRequestStatus: 'myRequestStatus', tripRideStatus: 'tripRideStatus',
                    dropPoint: 'dropPoint', date: 'date', price: 11.9, time: 'time');*/
                myOrderHistory.add(trip);
                //print(myTrip['Offered_Price'].toString());
                //print(myTrip['UserRequests'][userID]['Request_Status']);
                setState(() {

                });

              }

            print(myOrderHistory.length);
            /*print(myTrip['UserRequests'].keys.toList().contains(userID));
            print(myTrip['Driver_Name']);*/
            //print(myTrip['Pickup']);

            /*for(String i in myTrips['UserRequests'].keys)
              {
                print(i);
              }*/

            //print('lola');
            /*myTrips['UserRequests'].keys.where((k)=>{k.toString() == userID})*/
            

            //print(myTrips['UserRequests']);


          });

        }
      else {
        myOrderHistory.clear();
      }
    }, onError: (error) {
      print("error retrieving!");

    });
    /*userRequestsRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        userRequests.clear();
        Map <dynamic,dynamic> requestVals;
        event.snapshot.children.forEach((child) {

          requestVals = child.value as Map;
          if(requestVals['Request_Status'] != 'Rejected')
          {
            userRequests.add(requestVals);
          }


          //print(availableTrips);
        });


        setState(() {
        });
      }
      else {
        userRequests.clear();
      }
    }, onError: (error) {
      print("error retrieving!");
    });*/
  }



  
  @override
  Widget build(BuildContext context) {
    fetchRequestAndRideStatusChanges();
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Orders History',
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
      body: ListView.builder(
        itemCount: myOrderHistory.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID: ${index}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Destination: ${myOrderHistory[index].dropPoint}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Date: ${myOrderHistory[index].date}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Price: EGP ${myOrderHistory[index].price}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'My Request Status: ${myOrderHistory[index].myRequestStatus}',
                    style: TextStyle(
                      fontSize: 16,
                      color: myOrderHistory[index].myRequestStatus == 'Accepted'
                          ? Colors.green
                          : myOrderHistory[index].myRequestStatus == 'Pending'
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ),
                  Text(
                    'Trip Status: ${myOrderHistory[index].tripRideStatus}',
                    style: TextStyle(
                      fontSize: 16,
                      color: myOrderHistory[index].tripRideStatus == 'Completed'
                          ? Colors.green
                          : myOrderHistory[index].tripRideStatus == 'Pending' || myOrderHistory[index].tripRideStatus == 'In Progress'
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ),
                  Text(
                    'Pickup Time: ${myOrderHistory[index].time}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Driver: ${myOrderHistory[index].driverName}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Driver Phone: ${myOrderHistory[index].driverNumber}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}


