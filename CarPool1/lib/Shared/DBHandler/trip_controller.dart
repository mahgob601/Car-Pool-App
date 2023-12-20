import 'package:firebase_database/firebase_database.dart';
import 'package:car_pool1/firebase_options.dart';

import '../../Globals/global_var.dart';


class TripController
{
reserveTrip(String TripID) async{
  DatabaseReference userRequestsRef = FirebaseDatabase.instance.ref("Trips/${TripID}/UserRequests/$userID");
  DatabaseReference userTripRelationRef = FirebaseDatabase.instance.ref("UserTrips/$userID");

  await userRequestsRef.set({
    'User_ID': userID,
    'name':userName,
    'Request_Status':'Pending',
    'userProfileImage': profileImageURL,
    'phone': userPhone,
  });

  /*await userTripRelationRef.set({
    '$TripID':TripID
  });*/



  }

  checkIfTripAlreadyReserved(String TripID) async
  {
    DatabaseReference myRequestRef = FirebaseDatabase.instance.ref("Trips/${TripID}/UserRequests/$userID");
    myRequestRef.once().then((snap) async {
      if (snap.snapshot.value != null) {


      }
  });

  }
      }




