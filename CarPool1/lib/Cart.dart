import 'package:car_pool1/Shared/DBHandler/trip_controller.dart';
import 'package:flutter/material.dart';
import 'package:car_pool1/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1/Shared/SharedWidgets/drawer_widget.dart';
import 'package:intl/intl.dart';

import 'Shared/SharedTheme/SharedFont.dart';
import 'Shared/SharedWidgets/snack_widget.dart';
class MyCart extends StatefulWidget {
  final String pickup;
  final String dropoff;
  final String price;
  final String tripID;
  MyCart(this.pickup, this.dropoff, this.price ,this.tripID);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {

  bool isPaymentInCashSelected = false;
  bool isCreditCardSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Payment', style: TextStyle(
            color: Colors.white,
            fontSize: 25.0, fontWeight: FontWeight.bold
        )),
        backgroundColor: SharedColor.tealColor, // Set app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ride details
            Text(
              'Ride Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: SharedColor.tealColor,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(
                Icons.location_pin,
                color: Colors.teal,
              ),
              title: Text('Pickup: ${widget.pickup}'),
            ),

            // Drop-off Location
            ListTile(
              leading: Icon(
                Icons.pin_drop,
                color: Colors.teal,
              ),
              title: Text('Drop-off: ${widget.dropoff}'),
            ),
            SizedBox(height: 20),

            // Payment amount
            Text(
              'Payment Amount',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: SharedColor.tealColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'EGP ${widget.price}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // Payment method selection
            Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: SharedColor.tealColor,
              ),
            ),
            SizedBox(height: 10),

            // Credit Card option
            Card(
              color: isCreditCardSelected ? SharedColor.tealColor : Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(
                  'Credit Card ending in 1234',
                  style: TextStyle(
                    color: isCreditCardSelected ? Colors.white : Colors.black,
                  ),
                ),
                leading: Icon(
                  Icons.credit_card,
                  color: isCreditCardSelected ? Colors.white : SharedColor.tealColor,
                ),
                trailing: Checkbox(
                  value: isCreditCardSelected,
                  onChanged: (value) {
                    // Implement payment method selection logic
                    setState(() {
                      isCreditCardSelected = value ?? false;
                      isPaymentInCashSelected = false;
                    });
                  },
                  activeColor: SharedColor.tealColor,
                ),
              ),
            ),

            // Cash option
            Card(
              color: isPaymentInCashSelected ? SharedColor.tealColor : Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(
                  'Payment in Cash',
                  style: TextStyle(
                    color: isPaymentInCashSelected ? Colors.white : Colors.black,
                  ),
                ),
                leading: Icon(
                  Icons.money,
                  color: isPaymentInCashSelected ? Colors.white : SharedColor.tealColor,
                ),
                trailing: Checkbox(
                  value: isPaymentInCashSelected,
                  onChanged: (value) {
                    // Implement payment method selection logic
                    setState(() {
                      isPaymentInCashSelected = value ?? false;
                      isCreditCardSelected = false;
                    });
                  },
                  activeColor: SharedColor.tealColor,
                ),
              ),
            ),

            SizedBox(height: 20),

            // Payment button
            Center(
              child: ElevatedButton(
                onPressed: ()  async{
                  // Implement payment processing logic
                  if (isCreditCardSelected || isPaymentInCashSelected) {
                    // Handle credit card payment
                    await TripController().reserveTrip(widget.tripID);
                    print('Credit Card payment selected');
                  } else {
                    // Handle other payment methods
                    ScaffoldMessenger.of(context).showSnackBar(
                        snack('Please select a payment method', 3, Colors.red)
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: SharedColor.tealColor,
                  onPrimary: Colors.white,
                    maximumSize: Size(200.0, 50.0),
                    minimumSize: Size(200.0, 50.0)
                ),
                child: Text('Make Payment',style: SharedFont.whiteStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}