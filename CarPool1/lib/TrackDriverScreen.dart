import 'package:car_pool1/Shared/SharedWidgets/drawer_widget.dart';
import 'package:flutter/material.dart';

import 'Shared/SharedTheme/SharedColor.dart';

class TrackDriverScreen extends StatefulWidget {
  const TrackDriverScreen({super.key});

  @override
  State<TrackDriverScreen> createState() => _TrackDriverScreenState();
}

class _TrackDriverScreenState extends State<TrackDriverScreen> {
  final String driverName = 'Hesham Yousry';
  final String driverLocation = 'Nasr City (2.0 km away)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text('Track Driver',
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Material(
                child: Ink.image(
                  image: NetworkImage('https://cdn.aarp.net/content/dam/aarp/auto/2021/03/1140-man-driving-a-car.jpg'),
                  fit: BoxFit.cover,
                  width: 128,
                  height: 128 ,

                ),
              ),
            ),
            SizedBox(height: 12,),
            Text(
              'Driver Information',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Driver Name: $driverName',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Current Location: $driverLocation',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Icon(
                  Icons.location_on,
                  size: 50.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
