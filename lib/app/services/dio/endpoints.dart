import 'dart:io';

class Endpoints {
  Endpoints._();

  //TODO: update in android manifest too if any changes
  static String googleApiKey = Platform.isAndroid ? 'AIzaSyAs_QL4LPuvaU23w-t0wOUJyUziRmSIlkE' : 'AIzaSyBq5jpn2f8NAb4pb562ejP2YCg47uX1_nU';

  // base url
  static const String baseUrl = "https://api.greenpool.ca/v1/";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  //post url
  static const String register = "auth/register";
  static const String vehicleDetails = "driver/vehicledetails";
  static const String bugReport = "company/appBugReportByUser";
  static const String fileDispute = "fileDispute";
  static const String driverPostRide = "driver/ride";
  static const String riderFindRide = "rider/ride";
  static const String riderRideRequest = "rider/confirmRide";
  static const String sendRequestToRider = "driver/sendRequestToRider"; // to send request to riders from Send Requests view
  static const String sendRequestToDriver = "rider/sendReuestToDriver";
  static const String rateAnyUser = "user/ratingByUser";

  //get url
  static const String userLogin = "auth/login";
  static const String userByID = "user";
  static const String getChatRoomId = "chat/getChatRoomId?receiverId=";
  static const String sendMessage = "chat";
  static const String emergencyContacts = "user/emergencyContacts";
  static const String driverMyRides = "driver/myrides";
  static const String driverMyRidesDetails = "driver/myrides?rideId=";
  static const String allRecurringRides = "driver/recurringRides";
  static const String recurringRideDetails = "driver/recurringRides/";
  static const String rideHistory = "rider/rideHistory";
  static const String matchingRides = "rider/driversRequests"; // to get matching rides according to the Find ride data
  static const String riderAllSendRequests = 'rider/driversRequests?rideId=';
  static const String allDriverSendRequests = "driver/sendRequestOfRiders/"; // to get riders in send request column
  static const String allDriverConfirmRequests = "driver/ridersRequest/"; // to get all the requests that riders have sent to driver
  static const String acceptRidersRequest = "driver/confirmRide"; // to accept the riders request from Confirm Request View
  static const String rejectRidersRequest = "driver/cancelRide"; // to reject the riders request from Confirm Request View
  static const String viewDriversRequest = "rider/requestSendByDriver/"; // to view the drivers request from Confirm Request View

  //patch url
  static const String userDetails = "user/updateProfileDetails";
  static const String acceptDriversRequest = "rider/acceptConfirmRide";
  static const String rejectDriversRequest = "rider/rejectConfirmRide";
  static const String startRide = "driver/startRideByDriver";
  static const String endRide = "driver/endRideByDriver";
  static const String pinkMode = "user/updatePinkMode";
  static const String notificationPreferences = "user/updateNotificationPreferences";
  static const String cancelRide = "driver/cancelRideByMyRides";
  static const String riderCancelRide = "rider/cancelRideByMyRides";
  static const String googleBaseUrl = "https://maps.googleapis.com/maps/api/";
  static const String getArrivalTime = "directions/json?origin=";
}
