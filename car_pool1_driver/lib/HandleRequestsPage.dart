import 'dart:convert';

import 'package:car_pool1_driver/models/global_var.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:car_pool1_driver/firebase_options.dart';


import 'Shared/SharedWidgets/snack_widget.dart';


class HandleRequestsPage extends StatefulWidget {
  String tripID;
  HandleRequestsPage(this.tripID);
  @override
  _HandleRequestsPageState createState() => _HandleRequestsPageState();
}

class _HandleRequestsPageState extends State<HandleRequestsPage> {

  Map<String,String> userRequests = {};
  List<Map<String,String>> thisTripInfo = [];
  List<Map<String,String>> currentRequests=[];
  bool timeConstraintsFlag = true;



  String tripStatus = 'Pending'; // Default trip status

  @override
  void initState()
  {
    DatabaseReference userRequestsRef = FirebaseDatabase.instance.ref("Trips/${widget.tripID}");
    fetchRequests(userRequestsRef);
    super.initState();
  }



  fetchRequests(DatabaseReference userRequestsRef) async {
    Map<dynamic,dynamic> myVals = {};

    List<String> overdueRequests = [];
    userRequestsRef.onValue.listen((event) async {
      if (event.snapshot.exists) {
        final thisTripInfo = Map<String, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
        //userRequests = jsonDecode(thisTripInfo['UserRequests']);
        print(thisTripInfo['UserRequests'].keys.toList());
        currentRequests.clear();

        for(String key in thisTripInfo['UserRequests'].keys.toList())
          {
            print('${thisTripInfo['UserRequests'][key]['User_ID']} ${thisTripInfo['UserRequests'][key]['Request_Status']}');
            userRequests = {'Request_Status':'${thisTripInfo['UserRequests'][key]['Request_Status']}','User_ID':'${thisTripInfo['UserRequests'][key]['User_ID']}',
              'name':'${thisTripInfo['UserRequests'][key]['name']}', 'phone':'${thisTripInfo['UserRequests'][key]['phone']}',
              'userProfileImage':'${thisTripInfo['UserRequests'][key]['userProfileImage']}'
            };

            currentRequests.add(userRequests);
          }



        setState(() {
        });
      }
      else {
        currentRequests.clear();
        overdueRequests.clear();
        /*setState(() {
        });*/
      }
    }, onError: (error) {
      print("error retrieving!");
    });
  }



  @override
  Widget build(BuildContext context) {
    //fetchRequests();
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Handle Trip',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0, fontWeight: FontWeight.bold
              )
          ),

        ),

        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          // Trip status section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Trip Status: $tripStatus',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            timeConstraintsFlag = !timeConstraintsFlag;
            setState(() {

            });
          }, child: timeConstraintsFlag? Text('Time Constraints is ON', style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),):Text('Time Constraints is OFF', style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white
    )),
          style: ElevatedButton.styleFrom(
            backgroundColor: timeConstraintsFlag? Colors.green:Colors.red
          ),),
          // Passenger list
          Expanded(
            child: ListView.builder(
              itemCount: currentRequests.length,
              itemBuilder: (context, index) {
                return Card(

                  child: currentRequests[index]['Request_Status'] != 'Pending' ?Container(
                    color: currentRequests[index]['Request_Status'] == 'Accepted' ? Colors.green : Colors.red,
                    child: ListTile(


                      title: Text('${currentRequests[index]['name']}\n${currentRequests[index]['phone']}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(currentRequests[index]['userProfileImage']!), // Replace with driver image URL
                        radius: 30,
                      ),
                      subtitle: Text('Status: ${currentRequests[index]['Request_Status']}' ,style: TextStyle(
                          color: currentRequests[index]['Request_Status'] == 'Accepted' ? Colors.white : Colors.white70
                      ),),

                    ),
                  ) : ListTile(
                    title: Text('${currentRequests[index]['name']}\n${currentRequests[index]['phone']}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(currentRequests[index]['userProfileImage']!), // Replace with driver image URL
                      radius: 30,
                    ),
                    subtitle: Text('Status: ${currentRequests[index]['Request_Status']}' ,style: TextStyle(
                      color: currentRequests[index]['Request_Status'] == 'Accepted' ? Colors.green[900] : Colors.orange
                    ),),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            // Handle accept action
                            _handleAcceptPassenger(index,currentRequests[index]['User_ID']!);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            // Handle reject action
                            _handleRejectPassenger(currentRequests[index]['User_ID']!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Trip status buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                  onPressed: () {
                    _changeTripStatus('In Progress');
                  },
                  child: Text('In Progress', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),

                      )),


                  onPressed: () {
                    _changeTripStatus('Completed');
                  },
                  child: Text('Completed', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                  onPressed: () {
                    _changeTripStatus('Cancelled');
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.white)),
                ),



              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleAcceptPassenger(int i, String theuserID) async{
    var database = await FirebaseDatabase.instance
        .ref()
        .child("Trips/${widget.tripID}/UserRequests")
        .once();
    Map<dynamic,dynamic> checkTrip = {};

    // hena


    // Implement logic to accept the passenger
    DatabaseReference tripRef = FirebaseDatabase.instance.ref("Trips/${widget.tripID}");
    tripRef.once().then((snap) async {
      checkTrip = snap.snapshot.value as Map;


        DateTime tripDate = DateTime.parse(checkTrip['Date']);
        print(tripDate);
        DateTime reservationTime;
        DateTime now = DateTime.now();
        print(checkTrip['Time']);
        if (checkTrip['Time'] == "7.30 AM") {
          reservationTime = DateTime(tripDate.year, tripDate.month, tripDate.day, 23, 30, 0).subtract(Duration(days: 1)); // 11:30 pm previous day
        } else {
          reservationTime = DateTime(tripDate.year, tripDate.month, tripDate.day, 16, 30, 0); // 4:30 pm same day
        }






      if (snap.snapshot.value != null) {
        int noPass = (snap.snapshot.value as Map)["Passengers"];
        if (timeConstraintsFlag) {
          if (noPass + 1 == 3 && now.isBefore(reservationTime)) {
            await tripRef.update({
              'Passengers': noPass + 1
            });
            await tripRef.child('UserRequests/$theuserID').update({
              'Request_Status': 'Accepted'
            });
            await tripRef.update({
              'Booking_Status': 'Booked'
            });

            Map<dynamic, dynamic> myreqs = await database.snapshot.value as Map;
            late List pendingUsers = [];
            myreqs.forEach((key, value) {
              if (value['Request_Status'] == 'Pending' &&
                  key.toString() != userID) {
                pendingUsers.add(key.toString());
              }
            });

            for (String i in pendingUsers) {
              await tripRef.child('UserRequests/${i}').update({
                'Request_Status': 'Rejected'
              });
            }

            /*print(myreqs);
          print('lol');
          print(pendingUsers);*/
            //hena

          }
          else if (noPass + 1 < 3 && now.isBefore(reservationTime)) {
            await tripRef.update({
              'Passengers': noPass + 1
            });
            await tripRef.child('UserRequests/$theuserID').update({
              'Request_Status': 'Accepted'
            });
          }
          else if (noPass + 1 == 3 && now.isAfter(reservationTime)) {

              if (currentRequests[i]['Request_Status'].toString() ==
                  'Pending') {
                await tripRef.child(
                    'UserRequests/$theuserID').update({
                  'Request_Status': 'Rejected',
                });
                ScaffoldMessenger.of(context).showSnackBar(snack(
                    "Time Limit to accept is exceeded", 3, Colors.red));
              }


          }
          else if (noPass + 1 < 3 && now.isAfter(reservationTime)) {
            if (currentRequests[i]['Request_Status'].toString() ==
                'Pending') {
              await tripRef.child(
                  'UserRequests/$theuserID').update({
                'Request_Status': 'Rejected',
              });
              ScaffoldMessenger.of(context).showSnackBar(snack(
                  "Time Limit to accept is exceeded", 3, Colors.red));
            }

          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(snack(
                "Cannot accept more than 3 clients for a ride", 3, Colors.red));
            await tripRef.child('UserRequests/$theuserID').update({
              'Request_Status': 'Rejected'
            });
          }
        }
        else{
          if (noPass + 1 == 3) {
            await tripRef.update({
              'Passengers': noPass + 1
            });
            await tripRef.child('UserRequests/$theuserID').update({
              'Request_Status': 'Accepted'
            });
            await tripRef.update({
              'Booking_Status': 'Booked'
            });

            Map<dynamic, dynamic> myreqs = await database.snapshot.value as Map;
            late List pendingUsers = [];
            myreqs.forEach((key, value) {
              if (value['Request_Status'] == 'Pending' &&
                  key.toString() != userID) {
                pendingUsers.add(key.toString());
              }
            });

            for (String i in pendingUsers) {
              await tripRef.child('UserRequests/${i}').update({
                'Request_Status': 'Rejected'
              });
            }

            /*print(myreqs);
          print('lol');
          print(pendingUsers);*/
            //hena

          }
          else if (noPass + 1 < 3 ) {
            await tripRef.update({
              'Passengers': noPass + 1
            });
            await tripRef.child('UserRequests/$theuserID').update({
              'Request_Status': 'Accepted'
            });
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(snack(
                "Cannot accept more than 3 clients for a ride", 3, Colors.red));
            await tripRef.child('UserRequests/$theuserID').update({
              'Request_Status': 'Rejected'
            });

          }


      }

      }
    });






    
    //print('Accepted ${userID}');
    //setState(() {});
  }

  void _handleRejectPassenger(String userID) async{
    // Implement logic to reject the passenger
    DatabaseReference userRequestsRef = FirebaseDatabase.instance.ref("Trips/${widget.tripID}/UserRequests/");
    await userRequestsRef.child(userID).update({
      'Request_Status':'Rejected'
    });

    print('Rejected ${userID}');
    setState(() {});
  }

  void _changeTripStatus(String newStatus) async{
    DatabaseReference tripRef =  FirebaseDatabase.instance.ref("Trips/${widget.tripID}/");
    tripRef.update({
      'Ride_Status':newStatus,
    });
    // Implement logic to change trip status
    setState(() {
      tripStatus = newStatus;
    });
  }
}

