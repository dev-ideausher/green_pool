import 'dart:io';

class Endpoints {
  static String success_url =
      "http://api.greenpool.ca/v1/payment/paymentSuccess";
  static String cancel_url =
      "http://api.greenpool.ca/v1/payment/paymentCancelled";

  Endpoints._();

  //TODO: update in android manifest too if any changes
  static String googleApiKey = Platform.isAndroid
      ? 'AIzaSyAs_QL4LPuvaU23w-t0wOUJyUziRmSIlkE'
      : 'AIzaSyBq5jpn2f8NAb4pb562ejP2YCg47uX1_nU';

  // base url
  static const String baseUrl = "https://api.greenpool.ca/v1/";

  // receiveTimeout
  static const int receiveTimeout = 150000;

  // connectTimeout
  static const int connectionTimeout = 150000;
  static const canadaLat = 56.1304;
  static const canadaLong = 106.3468;

  //post url
  static const String register = "auth/register";
  static const String vehicleDetails = "driver/vehicledetails";
  static const String bugReport = "company/appBugReportByUser";
  static const String fileDispute = "fileDispute";
  static const String driverPostRide = "driver/ride";
  static const String riderFindRide = "rider/ride";
  static const String riderCreateAlert = "rider/createAlert";
  static const String sendRequestToRider =
      "driver/sendRequestToRider"; // to send request to riders from Send Requests view
  static const String sendRequestToDriver = "rider/sendReuestToDriver";
  static const String rateAnyUser = "user/ratingByUser";
  static const String studentDiscount = "email/send";
  static const String addAmount = "payment/addAmount";
  static const String appRating = "app/ratingByUser";

  //get url
  static const String userLogin = "auth/login";
  static const String userByID = "user";
  static const String getChatRoomId = "chat/getChatRoomId?receiverId=";
  static const String getChatList = "chat/chatRoomIds";
  static const String sendMessage = "chat";
  static const String searchSchools = "schools/searchByName/";
  static const String emergencyContacts = "user/emergencyContacts";
  static const String driverMyRides = "driver/myrides";
  static const String driverMyRidesDetails = "user/bookingDetails/";
  static const String allRecurringRides = "driver/recurringRides";
  static const String recurringRideDetails = "driver/recurringRides/";
  static const String rideHistory = "rider/rideHistory";
  static const String matchingRides =
      "rider/matchingDrivers"; // to get matching rides according to the Find ride data
  static const String riderAllSendRequests = 'rider/matchingDrivers?rideId=';
  static const String allDriverSendRequests =
      "driver/matchingRiders/"; // to get riders in send request column
  static const String allDriverConfirmRequests =
      "driver/riderSendRequests/"; // to get all the requests that riders have sent to driver
  static const String acceptRidersRequest =
      "driver/acceptRiderRequest"; // to accept the riders request from Confirm Request View
  static const String rejectRidersRequest =
      "driver/rejectRiderRequest"; // to reject the riders request from Confirm Request View
  static const String viewDriversRequest =
      "rider/driverSendRequests/"; // to view the drivers request from Confirm Request View
  static const String companyDetails = "company/companyDetails";
  static const String rideFare = "admin/fare/";
  static const String privacyPolicy = "admin/app/privacyPolicy";
  static const String cancelAndRefundPolicy =
      "admin/cancelAndRefundPolicy/driver";
  static const String walletBalance = "payment/walletBalance";
  static const String transactions = "payment/transactions";
  static const String notifications = "user/notifications";
  static const String helpAndSupport = "company/helpAndSupport";
  static const String welcomeEmail = "email/welComeEmail";
  static const String promoCode = "admin/promoCode/web";

  //patch url
  static const String emergencyContactsUpdate = "user/emergencyContacts";
  static const String userDetails = "user/updateProfileDetails";
  static const String acceptDriversRequest = "rider/acceptDriverRequest";
  static const String rejectDriversRequest = "rider/rejectDriverRequest";
  static const String startRide = "driver/startRideByDriver";
  static const String endRide = "driver/endRideByDriver";
  static const String pickUpRider = "rider/pickUpRider";
  static const String dropOffRider = "rider/dropOffRider";
  static const String pinkMode = "user/updatePinkMode";
  static const String notificationPreferences =
      "user/updateNotificationPreferences";
  static const String cancelRide = "driver/cancelRideByMyRides";
  static const String riderCancelRide = "rider/cancelRideByMyRides";
  static const String googleBaseUrl = "https://maps.googleapis.com/maps/api/";
  static const String getArrivalTime = "directions/json?origin=";
  static const String enableOrDisableRecurring =
      "driver/recurringRides?driverRideId=";
  static const String addPromoCode = "rider/ride/promoCode";

  //delete url
  static const String deleteChat = "/chat/";
  static const String deleteAccount = "/user";
}
