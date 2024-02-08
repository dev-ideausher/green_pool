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

  static Future<Response> getUserByID() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.userByID);

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
}
