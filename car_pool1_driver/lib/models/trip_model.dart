
class Trip{
  String driverID = '';
  String pickup= '';
  String dropoff= '';
  String tripDate = '';
  String tripTime= '';
  String offeredPrice= '';
  String bookingStatus = '';
  int passengers = 0;
  String rideStatus = '';


  Trip(String driverID,String pickup
      ,String dropoff,String tripDate,String tripTime,String offeredPrice,
      String bookingStatus, int passengers, String rideStatus
      )
  {
    this.driverID = driverID;
    /*this.driverName = driverName;
    this.driverProfileURL = driverProfileURL;
    this.carModel = carModel;*/
    this.pickup = pickup;
    this.dropoff = dropoff;
    this.tripDate = tripDate;
    this.tripTime= tripTime;
    this.offeredPrice = offeredPrice;
    this.bookingStatus = bookingStatus;
    this.passengers = passengers;
    this.rideStatus = rideStatus;



  }
}