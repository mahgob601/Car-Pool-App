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

  late List<dynamic> userRequests = [];



  String tripStatus = 'Pending'; // Default trip status

  @override
  void initState()
  {
    DatabaseReference userRequestsRef = FirebaseDatabase.instance.ref("Trips/${widget.tripID}");
    fetchRequests(userRequestsRef.child('UserRequests'));
    super.initState();
  }



  fetchRequests(DatabaseReference userRequestsRef) async {
    userRequestsRef.onValue.listen((event) {
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
          // Passenger list
          Expanded(
            child: ListView.builder(
              itemCount: userRequests.length,
              itemBuilder: (context, index) {
                return Card(

                  child: userRequests[index]['Request_Status'] != 'Pending' ?Container(
                    color: userRequests[index]['Request_Status'] == 'Accepted' ? Colors.green : Colors.red,
                    child: ListTile(


                      title: Text('${userRequests[index]['name']}\n${userRequests[index]['phone']}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(userRequests[index]['userProfileImage']), // Replace with driver image URL
                        radius: 30,
                      ),
                      subtitle: Text('Status: ${userRequests[index]['Request_Status']}' ,style: TextStyle(
                          color: userRequests[index]['Request_Status'] == 'Accepted' ? Colors.white : Colors.white70
                      ),),

                    ),
                  ) : ListTile(
                    title: Text('${userRequests[index]['name']}\n${userRequests[index]['phone']}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userRequests[index]['userProfileImage']), // Replace with driver image URL
                      radius: 30,
                    ),
                    subtitle: Text('Status: ${userRequests[index]['Request_Status']}' ,style: TextStyle(
                      color: userRequests[index]['Request_Status'] == 'Accepted' ? Colors.green[900] : Colors.orange
                    ),),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            // Handle accept action
                            _handleAcceptPassenger(userRequests[index]['User_ID']);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            // Handle reject action
                            _handleRejectPassenger(userRequests[index]['User_ID']);
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

  void _handleAcceptPassenger(String userID) async{
    var database = await FirebaseDatabase.instance
        .ref()
        .child("Trips/${widget.tripID}/UserRequests")
        .once();

    // hena


    // Implement logic to accept the passenger
    DatabaseReference tripRef = FirebaseDatabase.instance.ref("Trips/${widget.tripID}");
    tripRef.once().then((snap) async {
      if (snap.snapshot.value != null) {
        int noPass = (snap.snapshot.value as Map)["Passengers"];
        if(noPass+1 == 2)
        {
          await tripRef.update({
            'Passengers': noPass + 1
          });
          await tripRef.child('UserRequests/$userID').update({
            'Request_Status':'Accepted'
          });
          await tripRef.update({
            'Booking_Status': 'Booked'
          });

          Map<dynamic,dynamic> myreqs = await database.snapshot.value as Map;
          late List pendingUsers = [];
          myreqs.forEach((key, value) {
            if(value['Request_Status'] == 'Pending' && key.toString() != userID)
            {
              pendingUsers.add(key.toString());
            }
          });

          for(String i in pendingUsers)
            {
              await tripRef.child('UserRequests/${i}').update({
                'Request_Status':'Rejected'
              });

            }

          /*print(myreqs);
          print('lol');
          print(pendingUsers);*/
          //hena




        }
        else if(noPass+1 < 2)
          {
            await tripRef.update({
              'Passengers': noPass + 1
            });
            await tripRef.child('UserRequests/$userID').update({
              'Request_Status':'Accepted'
            });
          }
        else
          {
            ScaffoldMessenger.of(context).showSnackBar(snack("Cannot accept more than 3 clients for a ride", 3, Colors.red));
            await tripRef.child('UserRequests/$userID').update({
              'Request_Status':'Rejected'
            });
          }
      }
    });






    
    //print('Accepted ${userID}');
    setState(() {});
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

