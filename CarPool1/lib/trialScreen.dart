import 'package:flutter/material.dart';
class UserTrip {
  final String orderId;
  final String destination;
  final String date;
  final String status;
  //final String mySRequesttatus
  final String pickupTime;
  final String driverName;
  final String driverPhoneNumber;

  UserTrip({
    required this.orderId,
    required this.destination,
    required this.date,
    required this.status,
    required this.pickupTime,
    required this.driverName,
    required this.driverPhoneNumber,
  });
}
class OrderHistoryScreen extends StatefulWidget {
  //final List<UserTrip> orderHistory;

  final List<UserTrip> orderHistory = [
    UserTrip(
      orderId: '1',
      destination: 'City A',
      date: '2023-01-01',
      status: 'Completed',
      pickupTime: '10:00 AM',
      driverName: 'John Doe',
      driverPhoneNumber: '+1234567890',
    ),
    UserTrip(
      orderId: '2',
      destination: 'City B',
      date: '2023-02-01',
      status: 'Pending',
      pickupTime: '11:30 AM',
      driverName: 'Jane Smith',
      driverPhoneNumber: '+9876543210',
    ),
    UserTrip(
      orderId: '3',
      destination: 'City C',
      date: '2023-03-01',
      status: 'Cancelled',
      pickupTime: '09:15 AM',
      driverName: 'Bob Johnson',
      driverPhoneNumber: '+1122334455',
    ),
  ];
  OrderHistoryScreen();

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: widget.orderHistory.length,
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
                    'Order ID: ${widget.orderHistory[index].orderId}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Destination: ${widget.orderHistory[index].destination}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Date: ${widget.orderHistory[index].date}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Status: ${widget.orderHistory[index].status}',
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.orderHistory[index].status == 'Completed'
                          ? Colors.green
                          : widget.orderHistory[index].status == 'Pending'
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ),
                  Text(
                    'Pickup Time: ${widget.orderHistory[index].pickupTime}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Driver: ${widget.orderHistory[index].driverName}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Driver Phone: ${widget.orderHistory[index].driverPhoneNumber}',
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
