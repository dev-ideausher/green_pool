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

  static Future<Response> postMatchngRides({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.matchingRides, data: jsonEncode(body));

  static Future<Response> postAllRiderSendRequest(
          {required dynamic rideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.riderAllSendRequests + rideId);

  static Future<Response> postConfirmRide({required dynamic body}) async =>
      // rider will send request to matching driver for a ride
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.riderRideRequest, data: jsonEncode(body));

  static Future<Response> postDriverSendRiderRequest(
          {required dynamic body}) async =>
      // driver will send request to rider for a ride
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.driverRideRequest, data: jsonEncode(body));

  static Future<Response> postAcceptRiderRequest(
          {required dynamic body}) async =>
      // driver will accept the request send by a rider
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.acceptRidersRequest, data: jsonEncode(body));

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
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.driverMyRides);

  static Future<Response> getMyRidesDetails({required String rideId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.driverMyRidesDetails + rideId);

  // static Future<Response> getMatchingRides(
  //         {required Map<String, dynamic>? body}) async =>
  //     await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
  //         .get(Endpoints.matchingRides, queryParameters: body);

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
          .get(Endpoints.acceptDriversRequest + driverRideId);

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
}
