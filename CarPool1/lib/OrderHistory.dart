import 'package:car_pool1/Shared/SharedWidgets/drawer_widget.dart';

import 'package:car_pool1/trips/trip.dart';

import 'package:flutter/material.dart';

import 'Globals/global_var.dart';
import 'Globals/tip_globals.dart';
import 'Shared/SharedTheme/SharedColor.dart';

Map<dynamic,dynamic> myInd ={};
class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {

   List<MyTrip> myOrderHistory=[];

  Map<dynamic,dynamic> myTrip = {};
  Map<dynamic,dynamic> myTripsKeys = {};
  void initState()
  {

    fetchRequestAndRideStatusChanges();
    super.initState();
  }



  fetchRequestAndRideStatusChanges() async {
    userRequestsRef.onValue.listen((snap){
      if(snap.snapshot.value != null)
        {
          myOrderHistory.clear();
          snap.snapshot.children.forEach((child) async {

            myTrip = child.value as Map;

            //var check = await userRequestsRef.child(child.key!).child(userID).once();
            //myInd = check.snapshot.value as Map;

           /* if(check.snapshot.exists)
              {
                print(myTrip['Pickup'].toString());
                MyTrip trip = MyTrip(driverName: myTrip['Driver_Name'].toString(), driverNumber: myTrip['Driver_Number'].toString(),
                    driverProfileURL: myTrip['Driver_Profile'].toString()
                    , meetingPoint: myTrip['Pickup'].toString(), myRequestStatus: myTrip['UserRequests'][userID]['Request_Status'],
                    tripRideStatus: myTrip['Ride_Status'].toString()
                    , dropPoint: myTrip['Dropoff'].toString(), date: myTrip['Date'].toString(),
                    price: double.parse(myTrip['Offered_Price']), time: myTrip['Time'].toString());

                myOrderHistory.add(trip);
              }*//* if(check.snapshot.exists)
              {
                print(myTrip['Pickup'].toString());
                MyTrip trip = MyTrip(driverName: myTrip['Driver_Name'].toString(), driverNumber: myTrip['Driver_Number'].toString(),
                    driverProfileURL: myTrip['Driver_Profile'].toString()
                    , meetingPoint: myTrip['Pickup'].toString(), myRequestStatus: myTrip['UserRequests'][userID]['Request_Status'],
                    tripRideStatus: myTrip['Ride_Status'].toString()
                    , dropPoint: myTrip['Dropoff'].toString(), date: myTrip['Date'].toString(),
                    price: double.parse(myTrip['Offered_Price']), time: myTrip['Time'].toString());

                myOrderHistory.add(trip);
              }*/
           if(myTrip['UserRequests'].keys.toList().contains(userID))
              {
                print(myTrip['Pickup'].toString());
                MyTrip trip = MyTrip(driverName: myTrip['Driver_Name'].toString(),
                    driverNumber: myTrip['Driver_Number'].toString(),
                    driverProfileURL: myTrip['Driver_Profile'].toString()
                    , meetingPoint: myTrip['Pickup'].toString(),
                    myRequestStatus: myTrip['UserRequests'][userID]['Request_Status'],
                    tripRideStatus: myTrip['Ride_Status'].toString()
                    , dropPoint: myTrip['Dropoff'].toString(), date: myTrip['Date'].toString(),
                    price: double.parse(myTrip['Offered_Price']), time: myTrip['Time'].toString());

                myOrderHistory.add(trip);


              }

            setState(() {

            });

            //print(myOrderHistory.length);

          });
          setState(() {

          });


        }
      else {
        myOrderHistory.clear();
      }
    }, onError: (error) {
      print("error retrieving!");

    });

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
                    'Pickup: ${myOrderHistory[index].meetingPoint}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8,),
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
                  myOrderHistory[index].myRequestStatus == 'Accepted'?
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
                  ) : SizedBox(height: 0,),
                  Text(
                    'Pickup Time: ${myOrderHistory[index].time}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Driver: ${myOrderHistory[index].driverName}',
                    style: TextStyle(fontSize: 16),
                  ),
                  myOrderHistory[index].myRequestStatus == 'Accepted'?
                  Text(
                    'Driver Phone: ${myOrderHistory[index].driverNumber}',
                    style: TextStyle(fontSize: 16),
                  ):SizedBox(height: 0,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}


