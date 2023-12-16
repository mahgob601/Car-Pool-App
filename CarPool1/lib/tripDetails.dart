import 'package:car_pool1/Cart.dart';
import 'package:flutter/material.dart';

import 'Shared/SharedTheme/SharedColor.dart';
import 'Shared/SharedTheme/SharedFont.dart';
class TripDetailsPage extends StatelessWidget {
  final Map<dynamic,dynamic> myTrip;
  final String driverName;
  final String DriverURlProfile;
  final String carModel;
  final String phone;

  TripDetailsPage(this.myTrip, this.driverName, this.DriverURlProfile, this.carModel, this.phone);
  //print(myTrip);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Text('Trips Details',
              style:
              TextStyle(
                color: Colors.white,
              )

              ,),
          ),
          centerTitle: true,
          backgroundColor: SharedColor.tealColor,
        ),
        body: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(16),
            color: SharedColor.tealColor,
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(DriverURlProfile), // Replace with driver image URL
                    radius: 45,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${driverName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${carModel}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${myTrip['Date'].toString()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 8),
                  Text(
                    myTrip['Time'] == '5.30' ? "${myTrip['Time']} PM" : "${myTrip['Time']} AM" ,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 8),
                  Text(
                    'Pickup: ${myTrip['Pickup']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Dropoff: ${myTrip['Dropoff']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${phone}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${myTrip['Offered_Price']} EGP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 18,),
                  Center(
                    child: TextButton(
                        child: Text('Book Trip', style: SharedFont.whiteStyle),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            maximumSize: Size(120.0, 50.0),
                            minimumSize: Size(120.0, 50.0)
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => MyCart(myTrip['Pickup'],myTrip['Dropoff'], myTrip['Offered_Price'],myTrip['Trip_ID'] )));

                        }

                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}