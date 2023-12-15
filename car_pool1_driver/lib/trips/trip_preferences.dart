import 'package:car_pool1_driver/trips/trip.dart';
import 'package:flutter/material.dart';

class TripPreferences
{
  static List<Trip> myTrips=
  [
    Trip(location:'Abbasya',meetingPoint: 'Chillout Abbasya', driverName: 'Ahmed Khaled' ,dropPoint: 'G3 Faculty of Eng ASU', date: '22 NOV', price: 25 ,time: '7.30 AM'),

    Trip(location:'Abdo Basha',meetingPoint: 'G3 Faculty of Eng ASU', driverName: 'Ahmed Khaled',dropPoint: 'Chillout Abbasya', date: '22 NOV', price: 25  ,time: '5.30 PM'),

    Trip(location:'Abbasya',meetingPoint: 'Abbasya Square', driverName: 'Hesham Yousry',dropPoint: 'G3 Faculty of Eng ASU', date: '22 NOV', price: 15,time: '7.30 AM'),

    Trip(location:'Abbasya',meetingPoint: 'Chillout Abbasya', driverName: 'Ahmed Khaled',dropPoint: 'G4 Faculty of Eng ASU', date: '23 NOV', price: 25 ,time: '7.30 AM'),

    Trip(location:'Abbasya',meetingPoint: 'Abbasya Square', driverName: 'Ahmed Khaled' ,dropPoint: 'G4 Faculty of Eng ASU', date: '23 NOV', price: 15 ,time: '7.30 AM'),

    Trip(location:'Abdo Basha',meetingPoint: 'G4 Faculty of Eng ASU', driverName: 'Hesham Yousry' ,dropPoint: 'Chillout Abbasya', date: '23 NOV', price: 25,time: '5.30 PM'),

    Trip(location:'Abbasya',meetingPoint: 'Chillout Abbasya', driverName: 'Ali Youssef' ,dropPoint: 'G3 Faculty of Eng ASU', date: '24 NOV', price: 25,time: '7.30 AM'),


    Trip(location:'Abbasya',meetingPoint: 'Abbasya Square', driverName: 'Ahmed Khaled' ,dropPoint: 'G4 Faculty of Eng ASU', date: '24 NOV', price: 15 ,time: '7.30 AM'),


    Trip(location:'Abdo Basha',meetingPoint: 'G3 Faculty of Eng ASU', driverName: 'Ali Youssef',dropPoint: 'Chillout Abbasya', date: '24 NOV', price: 25,time: '5.30 PM'),


  ];


}