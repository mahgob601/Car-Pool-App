import 'package:car_pool1_driver/User/purchases.dart';
import 'package:car_pool1_driver/User/user_preferences.dart';

import '../trips/trip_preferences.dart';
import 'user.dart';

class PurchasesPreferences{
  static List<Purchase> myPurchases =
  [
    Purchase(user: UserPreferences.myUser, trip: TripPreferences.myTrips[0], purchaseDate: DateTime.now().subtract(Duration(days: 1))),
    Purchase(user: UserPreferences.myUser, trip: TripPreferences.myTrips[1], purchaseDate: DateTime.now().subtract(Duration(days: 1))),
    Purchase(user: UserPreferences.myUser, trip: TripPreferences.myTrips[4], purchaseDate: DateTime.now().subtract(Duration(days: 1))),
  ];

}