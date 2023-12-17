import 'package:firebase_database/firebase_database.dart';
import 'package:car_pool1/firebase_options.dart';

import '../../Globals/global_var.dart';


reserveTrip(String TripID) async{
  DatabaseReference userRequestsRef = FirebaseDatabase.instance.ref("Trips/${TripID}/UserRequests/$userID");
  await userRequestsRef.set({
    'User_ID': userID,
    'name':userName,
    'Request_Status':'Pending',
    'phone': userPhone,
  });

}
