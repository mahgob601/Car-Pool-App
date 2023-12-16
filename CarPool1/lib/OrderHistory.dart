import 'package:car_pool1/Shared/SharedWidgets/drawer_widget.dart';
import 'package:car_pool1/User/purchases.dart';
import 'package:car_pool1/User/user_preferences.dart';
import 'package:car_pool1/trips/trip_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'LoginScreen.dart';
import 'ProfilePage.dart';
import 'Shared/SharedTheme/SharedColor.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  
  List<Purchase> myPurchases =
      [
        Purchase(user: UserPreferences.myUser, trip: TripPreferences.myTrips[0], purchaseDate: DateTime.now().subtract(Duration(days: 1))),
        Purchase(user: UserPreferences.myUser, trip: TripPreferences.myTrips[1], purchaseDate: DateTime.now().subtract(Duration(days: 1))),
  Purchase(user: UserPreferences.myUser, trip: TripPreferences.myTrips[4], purchaseDate: DateTime.now().subtract(Duration(days: 1))),
      ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text('Trips History',
            style:
            TextStyle(
              color: Colors.white,
            )

            ,),
        ),
        centerTitle: true,
        backgroundColor: SharedColor.tealColor,
      ),
      drawer:myDrawer(),

      body: Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: ListView.builder(
          itemCount: myPurchases.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Card(
                color: SharedColor.tealColor,
                child: ListTile(
                  title: Text(
                    'From: ${myPurchases[index].trip.meetingPoint}\nTo: ${myPurchases[index].trip.dropPoint}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold


                    ),

                  ),
                  leading:Text(
                    '${myPurchases[index].trip.date}\n${myPurchases[index].trip.time}',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14
                    ),
                  ) ,
                  trailing: Text(
                    'Booked At:\n${DateFormat('dd-MM-yyyy').format(myPurchases[index].purchaseDate)}',
                    style: TextStyle(
                        color:Colors.white70,
                      fontSize: 14,
                    ),

                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


}


