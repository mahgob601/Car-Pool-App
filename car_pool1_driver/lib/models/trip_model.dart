
class Trip{
  String driverID = '';
  String pickup= '';
  String dropoff= '';
  String tripDate = '';
  String tripTime= '';
  String offeredPrice= '';
  /*String driverName = '';
  String carModel = '';
  String driverProfileURL = '';*/

  Trip(String driverID, /*String driverName, String driverProfileURL, String carModel,*/String pickup ,String dropoff,String tripDate,String tripTime,String offeredPrice)
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


  }
}