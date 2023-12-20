
// Those two lists are used in fetching trips data for users
import 'package:firebase_database/firebase_database.dart';


late List<dynamic> availableTrips = [];
late List<dynamic> myDriverInfo = [];
bool timeConstraintsForUser = true;
final Map<String, String> monthToCapital = {
  '01': 'JAN',
  '02': 'FEB',
  '03': 'MAR',
  '04': 'APR',
  '05': 'MAY',
  '06': 'JUN',
  '07': 'JUL',
  '08': 'AUG',
  '09': 'SEP',
  '10': 'OCT',
  '11': 'NOV',
  '12': 'DEC',
};

DatabaseReference driverInfoRef = FirebaseDatabase.instance.ref("drivers");
DatabaseReference tripsRef = FirebaseDatabase.instance.ref("Trips/");
DatabaseReference userRequestsRef = FirebaseDatabase.instance.ref("Trips/");