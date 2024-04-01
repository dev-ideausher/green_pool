import 'dart:io';

class Endpoints {
  Endpoints._();

  //TODO: update in android manifest too if any changes
  static String googleApiKey = Platform.isAndroid ? 'AIzaSyAs_QL4LPuvaU23w-t0wOUJyUziRmSIlkE' : 'AIzaSyBq5jpn2f8NAb4pb562ejP2YCg47uX1_nU';

  // base url
  static const String baseUrl = "http://51.20.170.89:4000/v1/";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  //post url
  static const String register = "auth/register";
  static const String vehicleDetails = "driver/vehicledetails";
  static const String bugReport = "company/appBugReportByUser";
  static const String driverPostRide = "driver/ride";
  static const String riderFindRide = "rider/ride";
  static const String riderRideRequest = "rider/confirmRide";
  static const String driverRideRequest = "driver/confirmRide"; //driver will send request to rider (from send request view)

  //get url
  static const String userLogin = "auth/login";
  static const String userByID = "user";
  static const String emergencyContacts = "user/emergencyContacts";
  static const String driverMyRides = "driver/myrides";
  static const String driverMyRidesDetails = "driver/myrides?rideId=";
  static const String matchingRides = "rider/driversRequests"; // to get matching rides according to the Find ride data
  static const String riderAllSendRequests = 'rider/driversRequests?rideId=';
  static const String allDriverSendRequests = "driver/sendRequestOfRiders/"; // to get riders in send request column
  static const String allDriverConfirmRequests = "driver/ridersRequest/"; // to get all the requests that riders have sent to driver
  static const String acceptRidersRequest = "driver/updateRidePost"; // to accept the riders request from Confirm Request View
  static const String acceptDriversRequest =
      "rider/requestSendByDriver/"; // to accept the drivers request from Confirm Request View (my rides me find a ride waale container pe tap karke jo confirm req wala view aayega)

  //patch url
  static const String userDetails = "user/updateProfileDetails";
}
