import 'package:flutter/material.dart';


class HandleRequestsPage extends StatefulWidget {
  @override
  _HandleRequestsPageState createState() => _HandleRequestsPageState();
}

class _HandleRequestsPageState extends State<HandleRequestsPage> {
  List<Passenger> passengers = [
    Passenger('Passenger 1'),
    Passenger('Passenger 2'),
    Passenger('Passenger 3'),
    // Add more passengers as needed
  ];

  String tripStatus = 'Pending'; // Default trip status

  @override
  Widget build(BuildContext context) {
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
              itemCount: passengers.length,
              itemBuilder: (context, index) {
                return Card(

                  child: ListTile(
                    title: Text(passengers[index].name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    
                    subtitle: Text('Status: ${passengers[index].status}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            // Handle accept action
                            _handleAcceptPassenger(passengers[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            // Handle reject action
                            _handleRejectPassenger(passengers[index]);
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
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
                  child: Text('Cancel', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleAcceptPassenger(Passenger passenger) {
    // Implement logic to accept the passenger
    passenger.status = 'Accepted';
    print('Accepted ${passenger.name}');
    setState(() {});
  }

  void _handleRejectPassenger(Passenger passenger) {
    // Implement logic to reject the passenger
    passenger.status = 'Rejected';
    print('Rejected ${passenger.name}');
    setState(() {});
  }

  void _changeTripStatus(String newStatus) {
    // Implement logic to change trip status
    setState(() {
      tripStatus = newStatus;
    });
  }
}

class Passenger {
  final String name;
  String status;

  Passenger(this.name, {this.status = 'Pending'});
}
