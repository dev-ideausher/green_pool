import 'dart:convert';

import 'package:dio/dio.dart';
import 'client.dart';
import 'endpoints.dart';

class APIManager {
  ///Post API

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
          {required dynamic body, String queryParam = ""}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.matchingRides + queryParam, data: jsonEncode(body));

  static Future<Response> postAllRiderSendRequest(
          {required dynamic rideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.riderAllSendRequests + rideId);

  static Future<Response> postConfirmRide({required dynamic body}) async =>
      // rider will send request to matching driver for a ride
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.riderRideRequest, data: jsonEncode(body));

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

  static Future<Response> postAcceptRiderRequest(
          {required dynamic body}) async =>
      // driver will accept the request send by a rider
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.acceptRidersRequest, data: jsonEncode(body));

  static Future<Response> postRejectRiderRequest(
          {required dynamic body}) async =>
      // driver will reject the request send by a rider
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.rejectRidersRequest, data: jsonEncode(body));

  static Future<Response> postRateUsers({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.rateAnyUser, data: jsonEncode(body));

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

  ///Get api
  static Future<Response> getLogin() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.userLogin);

  static Future<Response> getUserByID() async => await DioClient(
        Dio(),
        showSnakbar: true,
      ).get(Endpoints.userByID);

  static Future<Response> getAllMyRides() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.driverMyRides);

  static Future<Response> getMyRidesDetails({required String rideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.driverMyRidesDetails + rideId);

  static Future<Response> getAllDriverSendRequest(
          {required String driverId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.allDriverSendRequests + driverId);

  static Future<Response> getAllDriverConfirmRequest(
          {required String driverRideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.allDriverConfirmRequests + driverRideId);

  static Future<Response> getAllRiderConfirmRequest(
          {required String driverRideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.viewDriversRequest + driverRideId);

  // patch
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

  static Future<Response> rejectDriversRequest({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.rejectDriversRequest,
        data: body,
      );

  static Future<Response> startRide({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.startRide,
        data: body,
      );

  static Future<Response> notificationPreferences(
          {required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
        Endpoints.notificationPreferences,
        data: body,
      );
}
