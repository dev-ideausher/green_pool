import 'dart:convert';

import 'package:dio/dio.dart';
import 'client.dart';
import 'endpoints.dart';

class APIManager {
  //--------------------Post API--------------------//
  static Future<Response> postRegister({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.register, data: jsonEncode(body));

  static Future<Response> postEmergencyDetails({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.emergencyContacts, data: jsonEncode(body));

  static Future<Response> postDriverPostRide({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.driverPostRide, data: jsonEncode(body));

  static Future<Response> postRiderFindRide({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.riderFindRide, data: jsonEncode(body));

  static Future<Response> postMatchngRides(
          {required dynamic body, dynamic queryParam}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).post(
          Endpoints.matchingRides,
          data: jsonEncode(body),
          queryParameters: queryParam);

  static Future<Response> postAllRiderSendRequest(
          {required dynamic rideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .post(Endpoints.riderAllSendRequests + rideId);

  static Future<Response> postCreateAlert({required dynamic body}) async =>
      // rider will send request to matching driver for a ride
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.riderCreateAlert, data: jsonEncode(body));

  static Future<Response> postSendRequestToRider(
          {required dynamic body}) async =>
      // driver will send request to rider for a ride
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.sendRequestToRider, data: jsonEncode(body));

  static Future<Response> postSendRequestToDriver(
          {required dynamic body}) async =>
      // rider will send request to driver
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.sendRequestToDriver, data: jsonEncode(body));

  static Future<Response> postRateUsers({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.rateAnyUser, data: jsonEncode(body));

  static Future<Response> postRateApplication({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.appRating, data: jsonEncode(body));

  static Future<Response> sendMessage({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .post(Endpoints.sendMessage, data: jsonEncode(body));

  static Future<Response> postStudentDiscount({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.studentDiscount, data: jsonEncode(body));

  static Future<Response> addAmount({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.addAmount, data: jsonEncode(body));

  static Future<Response> postRegisterAcc({dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.userLogin, data: jsonEncode(body));

  static Future<Response> postLogin() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.userLogin);

  static Future<Response> postVehicleDetails({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.vehicleDetails,
              data: body,
              options: Options(headers: {
                'Content-Type': 'multipart/form-data',
              }));

  static Future<Response> postBugReport({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.bugReport,
              data: body,
              options: Options(headers: {
                'Content-Type': 'multipart/form-data',
              }));

  static Future<Response> postFileDispute({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.fileDispute,
              data: body,
              options: Options(headers: {
                'Content-Type': 'multipart/form-data',
              }));

  //--------------------Get api--------------------//

  static Future<Response> helpAndSupport() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.helpAndSupport);

  static Future<Response> getUserByID() async => await DioClient(
        Dio(),
        showSnakbar: true,
      ).get(Endpoints.userByID);

  static Future<Response> getChatList() async => await DioClient(
        Dio(),
        showSnakbar: true,
      ).get(Endpoints.getChatList);

  static Future<Response> getPrivacyPolicy() async => await DioClient(
        Dio(),
        showSnakbar: true,
      ).get(Endpoints.privacyPolicy);

  static Future<Response> walletBalance() async => await DioClient(
        Dio(),
        showSnakbar: true,
      ).get(Endpoints.walletBalance);

  static Future<Response> transactions() async => await DioClient(
        Dio(),
        showSnakbar: true,
      ).get(Endpoints.transactions);

  static Future<Response> notifications() async => await DioClient(
        Dio(),
        showSnakbar: true,
      ).get(Endpoints.notifications);

  static Future<Response> getCancelRefundPolicy() async => await DioClient(
        Dio(),
        showSnakbar: true,
      ).get(Endpoints.cancelAndRefundPolicy);

  static Future<Response> getAllMyRides() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.driverMyRides);

  static Future<Response> getCompanyDetails() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.companyDetails);

  static Future<Response> getRideHistory() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.rideHistory);

  static Future<Response> getAllRecurringRides() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.allRecurringRides);

  static Future<Response> getRecurringRideDetails(
          {required String rideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.recurringRideDetails + rideId);

  static Future<Response> getMyRidesDetails({required String rideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.driverMyRidesDetails + rideId);

  static Future<Response> getRideFare({required num distance}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.rideFare + distance.toString());

  static Future<Response> getAllDriverSendRequest(
          {required String driverId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.allDriverSendRequests + driverId);

  static Future<Response> getAllDriverConfirmRequest(
          {required String driverRideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.allDriverConfirmRequests + driverRideId);

  static Future<Response> getAllRiderConfirmRequest(
          {required String driverRideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.viewDriversRequest + driverRideId);

  static Future<Response> getChatRoomId({required String receiverId}) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false)
          .get("${Endpoints.getChatRoomId}$receiverId");

  static Future<Response> getArrivalTime(
          {required String origin, required String destination}) async =>
      await DioClient(
        Dio(),
        baseUrl: Endpoints.googleBaseUrl,
        showSnakbar: true,
        isOverlayLoader: false,
      ).get(
          "${Endpoints.getArrivalTime}$origin&destination=$destination&key=${Endpoints.googleApiKey}");

  static Future<Response> getAllSchools({required String schoolName}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.searchSchools + schoolName);

  //--------------------patch--------------------//
  static Future<Response> userDetails({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.userDetails,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

  static Future<Response> updateVehicleDetails({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.vehicleDetails,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

  static Future<Response> acceptDriversRequest({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.acceptDriversRequest,
        data: body,
      );

  static Future<Response> emergencyContactsUpdate(
          {required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.emergencyContactsUpdate,
        data: body,
      );

  static Future<Response> rejectDriversRequest({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.rejectDriversRequest,
        data: body,
      );

  static Future<Response> startRide({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: true).patch(
        Endpoints.startRide,
        data: body,
      );

  static Future<Response> endRide({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.endRide,
        data: body,
      );

  static Future<Response> pickUpRider({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.pickUpRider,
        data: body,
      );

  static Future<Response> dropOffRider({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.dropOffRider,
        data: body,
      );

  static Future<Response> notificationPreferences(
          {required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.notificationPreferences,
        data: body,
      );

  static Future<Response> cancelRide({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).patch(
        Endpoints.cancelRide,
        data: body,
      );

  static Future<Response> riderCancelRide({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).patch(
        Endpoints.riderCancelRide,
        data: body,
      );

  static Future<Response> enableDisableRecurring(
          {required dynamic driverRIdeId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).patch(
        Endpoints.enableOrDisableRecurring + driverRIdeId,
      );

  static Future<Response> enablePinkMode() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.pinkMode,
      );

  static Future<dynamic> deleteChat({
    required String chatRoomId,
  }) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .delete(Endpoints.deleteChat + chatRoomId);

  static Future<dynamic> deleteAccount() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .delete(Endpoints.deleteAccount);

  static Future<Response> patchAcceptRiderRequest(
          {required dynamic body}) async =>
      // driver will accept the request send by a rider
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .patch(Endpoints.acceptRidersRequest, data: jsonEncode(body));

  static Future<Response> patchRejectRiderRequest(
          {required dynamic body}) async =>
      // driver will reject the request send by a rider
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .patch(Endpoints.rejectRidersRequest, data: jsonEncode(body));
}
