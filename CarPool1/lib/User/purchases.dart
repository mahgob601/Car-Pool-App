import 'package:car_pool1/User/user.dart';
import 'package:car_pool1/trips/trip.dart';

class Purchase {
  final myuser user;
  final Trip trip;
  final DateTime purchaseDate;

  Purchase({required this.user, required this.trip, required this.purchaseDate});
}