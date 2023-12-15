import 'package:car_pool1_driver/LoginScreen.dart';
import 'package:car_pool1_driver/OrderHistory.dart';
import 'package:car_pool1_driver/ProfilePage.dart';
import 'package:car_pool1_driver/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1_driver/Shared/SharedWidgets/drawer_widget.dart';
import 'package:car_pool1_driver/trips/trip.dart';
import 'package:car_pool1_driver/trips/trip_preferences.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Trip> availableTrips = TripPreferences.myTrips;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text('Available Trips',
            style:
            TextStyle(
              color: Colors.white,
            )

            ,),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      drawer: myDrawer(),

      body: Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: ListView.builder(
          itemCount: availableTrips.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Card(
                color: Colors.blueGrey,
                child: ListTile(
                  title: Text(
                    'From: ${availableTrips[index].meetingPoint}\nTo: ${availableTrips[index].dropPoint}',
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold


                    ),

                  ),
                  leading:Text(
                      '${availableTrips[index].date}\n${availableTrips[index].time}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14
                    ),
                  ) ,
                  trailing: ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      color: Colors.blueGrey[600],
                      child: IconButton(
                        icon:Icon(Icons.add, color: Colors.white,),
                        onPressed:(){} ,
                      ),
                    ),
                  ),
                  onTap: () {
                    // Handle route selection, e.g., navigate to a details page
                    _navigateToTripDetails(availableTrips[index]);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToTripDetails(Trip trip) {
    // Add navigation logic here, e.g., push a new page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TripDetailsPage(trip)),
    );
  }
}

class TripDetailsPage extends StatelessWidget {
  final Trip trip;



  TripDetailsPage(this.trip);

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
      body:Center(
        child: ListView(
          children: [Center(
            child: Row(
              /*crossAxisAlignment: CrossAxisAlignment.center,*/


              children: [
                Center(
                  child: Column(
                   /* crossAxisAlignment: CrossAxisAlignment.center,*/
                    children: [
                      TripDetailCard(
                        title: 'Destination',
                        value: trip.dropPoint,
                      ),
                      SizedBox(height: 16.0),
                      TripDetailCard(
                        title: 'Pickup Point',
                        value: trip.meetingPoint,
                      ),
                      SizedBox(height: 16.0),
                      TripDetailCard(
                        title: 'Driver Name',
                        value: trip.driverName,
                      ),
                      SizedBox(height: 16.0),
                      TripDetailCard(
                        title: 'Pickup date',
                        value: trip.date,
                      ),
                      SizedBox(height: 16.0),
                      TripDetailCard(
                        title: 'Pickup Time',
                        value: trip.time.toString(),
                      ),

                      SizedBox(height: 16.0),
                      TripDetailCard(
                        title: 'Price',
                        value: trip.price.toString(),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ClipOval(
                    child: Material(
                      child: Ink.image(
                        image: NetworkImage('https://cdn.aarp.net/content/dam/aarp/auto/2021/03/1140-man-driving-a-car.jpg'),
                        fit: BoxFit.cover,
                        width: 128,
                        height: 128 ,

                      ),
                    ),
                  ),
                )
              ],
            ),
          ),]
        ),
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
    return Center(
      child: Card(
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
      ),
    );
  }
}