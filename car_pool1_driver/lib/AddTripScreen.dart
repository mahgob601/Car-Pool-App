import 'package:car_pool1_driver/Shared/SharedWidgets/drawer_widget.dart';
import 'package:car_pool1_driver/models/global_var.dart';
import 'package:flutter/material.dart';
import 'Shared/DBHandler/TripController.dart';
import 'Shared/DBHandler/firebaseAuth.dart';
import 'models/trip_model.dart';
import 'Shared/SharedTheme/SharedColor.dart';
import 'Shared/SharedTheme/SharedFont.dart';
import 'Shared/SharedWidgets/snack_widget.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({super.key});

  @override
  State<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  TextEditingController pickupPointController = TextEditingController();
  TextEditingController destinationPointController = TextEditingController();
  TextEditingController offeredPriceController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("7.30 AM"),value: "7.30"),
      DropdownMenuItem(child: Text("5.30 PM"),value: "5.30"),

    ];
    return menuItems;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String selectedValue = "7.30 AM";
  String selectedPickup = "G3 ASU Engineering";
  String selectedDropoff = "G3 ASU Engineering";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: SharedColor.backgroundColor,
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:18.0),
          child: Text(
            "Add Trip",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      drawer: myDrawer(),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: selectedValue == "7.30 AM" ? Column(
            children: [

              input_field('Pickup Point', Icons.my_location_rounded, pickupPointController, false),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Select dropoff: ", style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(width:20),
                  DropdownButton(
                    value: selectedDropoff,
                    items: [
                      DropdownMenuItem(
                          child: Text("G3 ASU Engineering"),
                          value: "G3 ASU Engineering"
                      ),
                      DropdownMenuItem(
                        child: Text("G4 ASU Engineering"),
                        value: "G4 ASU Engineering",
                      )
                    ], onChanged: (String? dropvalue) {
                    setState(() {
                      selectedDropoff = dropvalue!;
                    });
                  },
                  ),
                ],
              ),
              input_field('Offered Price', Icons.monetization_on, offeredPriceController, false),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pickup date: ", style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(width:20),
                    Text("${selectedDate.toLocal()}".split(' ')[0]),
                    SizedBox(width:20),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select date'),
                    ),
                  ],

                ),
              ),

              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Select time: ", style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(width:20),
                  DropdownButton(
                    value: selectedValue,
                    items: [
                      DropdownMenuItem(
                          child: Text("7.30 AM"),
                          value: "7.30 AM"
                      ),
                      DropdownMenuItem(
                        child: Text("5.30 PM"),
                        value: "5.30 PM",
                      )
                    ], onChanged: (String? value) {
                      setState(() {
                        selectedValue = value!;
                        destinationPointController.text = '';
                        pickupPointController.text = '';
                      });
                  },
                  ),
                ],
              ),






              const SizedBox(height: 10.0,),
              TextButton(
                child: Text('Add Trip', style: SharedFont.whiteStyle),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    maximumSize: Size(200.0, 50.0),
                    minimumSize: Size(200.0, 50.0)
                ),
                onPressed: () {
                  if (pickupPointController.text.trim().isEmpty || offeredPriceController.text.trim().isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        snack('Some Fields Required', 3, Colors.red)
                    );
                  }

                  else {
                    print(selectedDate.toString().split(' ')[0].split('-')[2]);

                    TripControllerClass().addTrip(context, Trip(userID, pickupPointController.text.trim(), selectedDropoff, selectedDate.toString().split(' ')[0], selectedValue, offeredPriceController.text, 'Available',0, 'Not Started'));

                  }
                },
              ),

              SizedBox(
                height: 10,
              ),


            ],
          ) :
          Column(
            children: [
              const SizedBox(height: 10.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Select pickup: ", style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(width:20),
                  DropdownButton(
                    value: selectedPickup,
                    items: [
                      DropdownMenuItem(
                          child: Text("G3 ASU Engineering"),
                          value: "G3 ASU Engineering"
                      ),
                      DropdownMenuItem(
                        child: Text("G4 ASU Engineering"),
                        value: "G4 ASU Engineering",
                      )
                    ], onChanged: (String? pickvalue) {
                    setState(() {
                      selectedPickup = pickvalue!;
                    });
                  },
                  ),
                ],
              ),
              input_field('Dropoff Point', Icons.location_on, destinationPointController, false),

              input_field('Offered Price', Icons.monetization_on, offeredPriceController, false),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pickup date: ", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(width:20),
                    Text("${selectedDate.toLocal()}".split(' ')[0]),
                    SizedBox(width:20),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select date'),
                    ),
                  ],

                ),
              ),

              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Select time: ", style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(width:20),
                  DropdownButton(
                    value: selectedValue,
                    items: [
                      DropdownMenuItem(
                          child: Text("7.30 AM"),
                          value: "7.30 AM"
                      ),
                      DropdownMenuItem(
                        child: Text("5.30 PM"),
                        value: "5.30 PM",
                      )
                    ], onChanged: (String? value) {
                    setState(() {
                      selectedValue = value!;
                      destinationPointController.text = '';
                      pickupPointController.text = '';
                    });
                  },
                  ),
                ],
              ),






              const SizedBox(height: 10.0,),
              TextButton(
                child: Text('Add Trip', style: SharedFont.whiteStyle),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    maximumSize: Size(200.0, 50.0),
                    minimumSize: Size(200.0, 50.0)
                ),
                onPressed: () {
                  if (destinationPointController.text.trim().isEmpty || offeredPriceController.text.trim().isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        snack('Some Fields Required', 3, Colors.red)
                    );
                  }
                  else
                    {
                      TripControllerClass().addTrip(context, Trip(userID, selectedPickup, destinationPointController.text.trim(), selectedDate.toString().split(' ')[0], selectedValue, offeredPriceController.text,'Available',0, 'Not Started'));
                    }

                },
              ),

              SizedBox(
                height: 10,
              ),


            ],
          )
        ),
      ),
    );
  }
  OutlineInputBorder fieldBorder(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.0),
        borderRadius: BorderRadius.circular(20.0)
    );
  }

  Container input_field(String label, IconData icon, TextEditingController controller, bool isSecure) {
    return Container(
      margin: EdgeInsets.all(8),
      child: TextField(
          decoration: InputDecoration(
              border: fieldBorder(SharedColor.greyColor),
              enabledBorder: fieldBorder(SharedColor.greyColor),
              focusedBorder: fieldBorder(SharedColor.greyColor),
              errorBorder: fieldBorder(Colors.red),
              labelText: label,
              labelStyle: SharedFont.subGreyStyle,
              prefixIcon: Icon(icon, color: SharedColor.greyColor, size: 20.0),

          ),
          style: SharedFont.subBlackStyle,
          obscureText: isSecure,
          controller: controller
      ),
    );
  }
}
