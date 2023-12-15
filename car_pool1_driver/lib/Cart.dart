import 'package:flutter/material.dart';
import 'package:car_pool1_driver/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1_driver/User/purchases.dart';
import 'package:car_pool1_driver/User/purchases_preferences.dart';
import 'package:car_pool1_driver/Shared/SharedWidgets/drawer_widget.dart';
import 'package:intl/intl.dart';
class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {

  final List<Purchase> inCart = [
    PurchasesPreferences.myPurchases[0]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text('My Cart',
            style:
            TextStyle(
              color: Colors.white,
            )

            ,),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      drawer:myDrawer(),

      body: Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: ListView.builder(
          itemCount: inCart.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Card(
                color: Colors.teal,
                child: ListTile(
                  title: Text(
                    'From: ${inCart[index].trip.meetingPoint}\nTo: ${inCart[index].trip.dropPoint}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold


                    ),

                  ),
                  leading:Text(
                    '${inCart[index].trip.date}\n${inCart[index].trip.time}',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14
                    ),
                  ) ,
                  trailing: Text(
                    '${inCart[index].trip.price} EGP',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14
                    ),
                  ) ,
                  onTap: () {
                    // Handle route selection, e.g., navigate to a details page
                    _navigateToTripDetails(inCart[index]);
                  },

                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToTripDetails(Purchase p) {
    // Add navigation logic here, e.g., push a new page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TripDetailsPage(p)),
    );
  }
}

class TripDetailsPage extends StatelessWidget {
  final Purchase p;

  String selectedPaymentOption = '';


  TripDetailsPage(this.p);

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
        backgroundColor: Colors.blueGrey,
      ),
      body:ListView(
        children: [Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TripDetailCard(
              title: 'Destination',
              value: p.trip.dropPoint,
            ),
            SizedBox(height: 16.0),
            TripDetailCard(
              title: 'Pickup Point',
              value: p.trip.meetingPoint,
            ),
            SizedBox(height: 16.0),
            TripDetailCard(
              title: 'Driver Name',
              value: p.trip.driverName,
            ),
            SizedBox(height: 16.0),
            TripDetailCard(
              title: 'Pickup date',
              value: p.trip.date,
            ),
            SizedBox(height: 16.0),
            TripDetailCard(
              title: 'Pickup Time',
              value: p.trip.time.toString(),
            ),

            SizedBox(height: 16.0),
            TripDetailCard(
              title: 'Price',
              value: p.trip.price.toString(),
            ),

            SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  primary: Colors.green, // Change the color according to your design
                ),
                child: Text(
                  'Pay in Cash',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            )

          ],
        ),]
      ),
    );
  }

}




class TripDetailCard extends StatelessWidget {
  final String title;
  final String value;

  TripDetailCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              value,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

