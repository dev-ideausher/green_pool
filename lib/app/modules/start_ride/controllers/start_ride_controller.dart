import 'dart:async';
import 'dart:convert';
import 'dart:developer';
//test
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/data/start_ride_model.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/dio/endpoints.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/booking_detail_model.dart';
import '../../../data/chat_arg.dart';
import '../../../services/gp_util.dart';
import '../../home/controllers/home_controller.dart';

class StartRideController extends GetxController {
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  late GoogleMapController mapController;
  final Set<Marker> markers = <Marker>{}.obs;
  final RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  final Rx<BookingDetailModelData> myRidesModel = BookingDetailModelData().obs;
  RxBool isLoad = true.obs;
  RxBool isRideStarted = false.obs;
  var startRideResponse = StartRideModel().obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await myRidesDetailsAPI(Get.arguments);

    //  myRidesModel.value.riderBookingDetails?.origin?.coordinates = [74.9454334456202, 30.211063461596073];
    //  myRidesModel.value.riderBookingDetails?.destination?.coordinates = [74.91410641185684, 30.321220704270132];
    await getPolyPoints();
    //myRidesModel.value.isStarted! ? null :
    isLoad.value = false;
  }

  myRidesDetailsAPI(String rideId) async {
    try {
      final response = await APIManager.getMyRidesDetails(rideId: rideId);
      var data = jsonDecode(response.toString());
      myRidesModel.value = BookingDetailModel.fromJson(data).data!;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          bearing: 270.0,
          target: LatLng(
              myRidesModel
                      .value
                      .driverBookingDetails
                      ?.riders?[0]
                      ?.riderBookingDetails?[0]
                      ?.origin
                      ?.coordinates
                      ?.last ?? //source
                  0.0,
              myRidesModel.value.driverBookingDetails?.riders?[0]
                      ?.riderBookingDetails?[0]?.origin?.coordinates?.first ??
                  0.0),
          tilt: 30.0,
          zoom: 17.0),
    ));
    mapController.animateCamera(CameraUpdate.newLatLngBounds(
        boundsFromLatLngList(polylineCoordinates), 70));

    polylineCoordinates.refresh();
    onChangeLocation();
  }

  Future<void> getPolyPoints() async {
    try {
      final List<double?> originCoordinates = myRidesModel
              .value
              .driverBookingDetails
              ?.riders?[0]
              ?.riderBookingDetails?[0]
              ?.origin
              ?.coordinates ??
          [0.0, 0.0];
      final List<double?> destinationCoordinates = myRidesModel
              .value
              .driverBookingDetails
              ?.riders?[0]
              ?.riderBookingDetails?[0]
              ?.destination
              ?.coordinates ??
          [0.0, 0.0];
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
          Endpoints.googleApiKey,
          PointLatLng(originCoordinates.last!, originCoordinates.first!),
          PointLatLng(
              destinationCoordinates.last!, destinationCoordinates.first!));
      if (result.points.isNotEmpty) {
        polylineCoordinates.assignAll(result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList());
      }
      polylineCoordinates.refresh();
      markers.clear();
      addMarkers(LatLng(originCoordinates.last!, originCoordinates.first!),
          ImageConstant.pngSourceIcon);
      addMarkers(
          LatLng(destinationCoordinates.last!, destinationCoordinates.first!),
          ImageConstant.pngDestinationIcon);
      mapController.animateCamera(CameraUpdate.newLatLngBounds(
          GpUtil.boundsFromLatLngList(polylineCoordinates), 70));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addMarkers(LatLng carLocation, String image) async {
    // String imgurl = "https://www.fluttercampus.com/img/car.png";
    // Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
    //     .buffer
    //     .asUint8List();
    markers.add(Marker(
      markerId: MarkerId(carLocation.toString()),
      position: carLocation, //position of marker
      infoWindow: const InfoWindow(
        title: 'Car Point ',
        snippet: 'Car Marker',
      ),
      // icon: BitmapDescriptor.fromBytes(bytes), //Icon for Marker
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(200.kw, 200.kh)), image),
    ));
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double minLat = list.first.latitude;
    double maxLat = list.first.latitude;
    double minLng = list.first.longitude;
    double maxLng = list.first.longitude;
    for (LatLng point in list) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }
    return LatLngBounds(
        southwest: LatLng(minLat, minLng), northeast: LatLng(maxLat, maxLng));
  }

  StreamSubscription<Position>? positionStream;

  void onChangeLocation() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) async {
      if (position != null) {
        final currentLat = position.latitude;
        final currentLong = position.longitude;
        myRidesModel
            .value
            .driverBookingDetails
            ?.riders?[0]
            ?.riderBookingDetails?[0]
            ?.origin
            ?.coordinates = [currentLong, currentLat];
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(currentLat, currentLong),
            ),
          ),
        );
        await getPolyPoints();
        polylineCoordinates.refresh();
      }
    });
  }

  startRideAPI() async {
    try {
      final response = await APIManager.startRide(
          body: {"driverRideId": myRidesModel.value.driverRideId});
      var data = jsonDecode(response.toString());
      if (data['status']) {
        isRideStarted.value = true;
      }

      showMySnackbar(msg: "${response.statusMessage}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  endRideAPI() async {
    try {
      final response = await APIManager.endRide(
          body: {"driverRideId": myRidesModel.value.driverRideId});
      log("END RIDE EXECUTED--------> ${response.statusMessage}}");
      Get.offNamed(Routes.RATING_DRIVER_SIDE, arguments: myRidesModel.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  pickUpAPI() async {
    try {
      final response = await APIManager.pickUpRider(body: {
        "riderId": myRidesModel.value.driverBookingDetails?.riders?[0]
            ?.riderBookingDetails?[0]?.riderId,
        "riderRideId": myRidesModel.value.riderRideId,
        "riderNotificationPreferences": myRidesModel
            .value.driverBookingDetails?.riders?[0]?.notificationPreferences!
            .toJson(),
        "riderName":
            myRidesModel.value.driverBookingDetails?.riders?[0]?.fullName,
        "driverId": myRidesModel.value.driverId
      });
      print("pickup API res: ${response.data.toString()}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  dropOffAPI() async {
    try {
      final res = await APIManager.dropOffRider(body: {
        "riderId": myRidesModel.value.driverBookingDetails?.riders?[0]
            ?.riderBookingDetails?[0]?.riderId,
        "riderRideId": myRidesModel.value.riderRideId,
        "riderNotificationPreferences": myRidesModel
            .value.driverBookingDetails?.riders?[0]?.notificationPreferences!
            .toJson(),
        "riderName":
            myRidesModel.value.driverBookingDetails?.riders?[0]?.fullName,
        "driverRideId": myRidesModel.value.driverRideId
      });
      print(res.data.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onClose() {
    positionStream?.cancel();
    super.onClose();
  }

  showChatBottomSheet() async {
    try {
      final res = await APIManager.getChatRoomId(
          receiverId: myRidesModel.value.driverBookingDetails?.riders?[0]
                  ?.riderBookingDetails?[0]?.Id ??
              "",
          ridePostId: myRidesModel.value.driverBookingDetails?.riders?[0]
                  ?.riderBookingDetails?[0]?.Id ??
              "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["chatChannelId"] ?? "",
              rideId: myRidesModel.value.driverBookingDetails?.riders?[0]
                      ?.riderBookingDetails?[0]?.Id ??
                  "",
              id: myRidesModel.value.driverBookingDetails?.riders?[0]
                  ?.riderBookingDetails?[0]?.Id,
              name:
                  myRidesModel.value.driverBookingDetails?.riders?[0]?.fullName,
              image: myRidesModel
                  .value.driverBookingDetails?.riders?[0]?.profilePic?.url));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              rideId: myRidesModel.value.driverBookingDetails?.riders?[0]
                      ?.riderBookingDetails?[0]?.Id ??
                  "",
              id: myRidesModel.value.driverBookingDetails?.riders?[0]
                  ?.riderBookingDetails?[0]?.Id,
              name:
                  myRidesModel.value.driverBookingDetails?.riders?[0]?.fullName,
              image: myRidesModel
                  .value.driverBookingDetails?.riders?[0]?.profilePic?.url));
      debugPrint(e.toString());
    }
  }
}
