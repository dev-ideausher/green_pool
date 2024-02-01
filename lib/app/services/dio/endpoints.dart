class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://51.20.170.89:4000/v1/";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  //post url
  static const String register = "auth/register";
  static const String vehicleDetails = "driver/vehicledetails";

  //get url
  static const String userLogin = "auth/login";
  static const String userByID = "user";
  static const String emergencyContacts = "user/emergencyContacts";

  //patch url
  static const String userDetails = "user/updateProfileDetails";
}
