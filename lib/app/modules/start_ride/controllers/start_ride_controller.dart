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
import 'package:path/path.dart';

import '../../../data/booking_detail_model.dart';
import '../../../data/chat_arg.dart';
import '../../../res/strings.dart';
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
  var startRideResponse = StartRideModel().obs;
  final RxBool isPicked = false.obs;
  final RxInt selectedRider = 0.obs;
  final RxString btnText = "".obs;
  final RxBool isEndRide = false.obs;
  List<PolylineWayPoint> wayPoints = [];

  @override
  Future<void> onInit() async {
    super.onInit();

    await myRidesDetailsAPI(Get.arguments);
    await getPolyPoints();
    getButtonLabel();
    isLoad.value = false;
  }

  myRidesDetailsAPI(String rideId) async {
    try {
      final response = await APIManager.getMyRidesDetails(rideId: rideId);
      var data = jsonDecode(response.toString());
      myRidesModel.value = BookingDetailModel.fromJson(data).data!;
      print(myRidesModel.value);
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
              getLat() //source
              ,
              getLong()),
          tilt: 30.0,
          zoom: 17.0),
    ));
    if (polylineCoordinates.isNotEmpty) {
      mapController.animateCamera(CameraUpdate.newLatLngBounds(
          boundsFromLatLngList(polylineCoordinates), 70));
    }

    polylineCoordinates.refresh();
    onChangeLocation();
  }

  Future<void> getPolyPoints() async {
    late List<double?> stop1Coordinates = [0.0, 0.0];
    late List<double?> stop2Coordinates = [0.0, 0.0];

    //add waypoints
    if (myRidesModel
            .value.driverBookingDetails?.stops?[0]?.coordinates!.first !=
        0.0) {
      stop1Coordinates =
          myRidesModel.value.driverBookingDetails!.stops![0]!.coordinates!;
      wayPoints.add(PolylineWayPoint(
          location:
              "${stop1Coordinates?.last.toString()},${stop1Coordinates?.first.toString()}"));
      if (myRidesModel
              .value.driverBookingDetails?.stops?[1]?.coordinates!.first !=
          0.0) {
        stop2Coordinates =
            myRidesModel.value.driverBookingDetails!.stops![1]!.coordinates!;
        wayPoints.add(PolylineWayPoint(
            location:
                "${stop2Coordinates?.last.toString()},${stop2Coordinates?.first.toString()}"));
      }
    } else {
      print("Waypoints not added");
    }
    try {
      final List<double?> originCoordinates =
          myRidesModel.value.driverBookingDetails?.origin?.coordinates ??
              [0.0, 0.0];
      final List<double?> destinationCoordinates =
          myRidesModel.value.driverBookingDetails?.destination?.coordinates ??
              [0.0, 0.0];
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        googleApiKey: Endpoints.googleApiKey,
        request: PolylineRequest(
            origin:
                PointLatLng(originCoordinates.last!, originCoordinates.first!),
            wayPoints: wayPoints,
            destination: PointLatLng(
                destinationCoordinates.last!, destinationCoordinates.first!),
            mode: TravelMode.driving),
      );
      if (result.points.isNotEmpty) {
        polylineCoordinates.assignAll(result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList());
      }
      polylineCoordinates.refresh();
      markers.clear();
      addMarkers(LatLng(originCoordinates.last!, originCoordinates.first!), "",
          "Origin", 0.0);
      if (stop1Coordinates.first != 0.0) {
        addMarkers(LatLng(stop1Coordinates.last!, stop1Coordinates.first!), "",
            "Stop", 0.0);
        if (stop2Coordinates.first != 0.0) {
          addMarkers(LatLng(stop2Coordinates.last!, stop2Coordinates.first!),
              "", "Stop", 0.0);
        }
      }
      addMarkers(LatLng(originCoordinates.last!, originCoordinates.first!),
          ImageConstant.pngCarPointer, "", 0.0);
      addMarkers(
          LatLng(destinationCoordinates.last!, destinationCoordinates.first!),
          "",
          "Destination",
          0.0);
      mapController.animateCamera(CameraUpdate.newLatLngBounds(
          GpUtil.boundsFromLatLngList(polylineCoordinates), 70));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addMarkers(
      LatLng carLocation, String image, String? title, double? rotation) async {
    markers.add(Marker(
      markerId: MarkerId(carLocation.toString()),
      position: carLocation, //position of marker
      infoWindow: InfoWindow(
        title: title,
        snippet: '',
      ),
      rotation: rotation ?? 0.0,
      //anchor: ,
      // icon: BitmapDescriptor.fromBytes(bytes), //Icon for Marker
      icon: image == ""
          ? BitmapDescriptor.defaultMarker
          : await BitmapDescriptor.fromAssetImage(
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
        final heading = position.heading;
        myRidesModel
            .value
            .driverBookingDetails
            ?.riderBookingDetails?[selectedRider.value]
            ?.origin
            ?.coordinates = [currentLong, currentLat];
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 17,
              target: LatLng(currentLat, currentLong),
            ),
          ),
        );
        markers.clear();
        addMarkers(
            LatLng(
                myRidesModel.value.driverBookingDetails?.origin?.coordinates
                        ?.last ??
                    0.0,
                myRidesModel.value.driverBookingDetails?.origin?.coordinates
                        ?.first ??
                    0.0),
            "",
            "Origin",
            0.0);

        if (myRidesModel
                .value.driverBookingDetails?.stops?[0]?.coordinates?.last !=
            0.0) {
          addMarkers(
              LatLng(
                  myRidesModel.value.driverBookingDetails?.stops?[0]
                          ?.coordinates?.last ??
                      0.0,
                  myRidesModel.value.driverBookingDetails?.stops?[0]
                          ?.coordinates?.first ??
                      0.0),
              "",
              "Stop",
              0.0);
          if (myRidesModel
                  .value.driverBookingDetails?.stops?[1]?.coordinates?.last !=
              0.0) {
            addMarkers(
                LatLng(
                    myRidesModel.value.driverBookingDetails?.stops?[1]
                            ?.coordinates?.last ??
                        0.0,
                    myRidesModel.value.driverBookingDetails?.stops?[1]
                            ?.coordinates?.first ??
                        0.0),
                "",
                "Stop",
                0.0);
          }
        }

        addMarkers(
            LatLng(
                myRidesModel.value.driverBookingDetails?.destination
                        ?.coordinates?.last ??
                    0.0,
                myRidesModel.value.driverBookingDetails?.destination
                        ?.coordinates?.first ??
                    0.0),
            "",
            "Destination",
            0.0);

        addMarkers(LatLng(currentLat, currentLong), ImageConstant.pngCarPointer,
            "Current Location", heading);

        if (myRidesModel.value.driverBookingDetails?.stops?[0]?.coordinates !=
                null ||
            myRidesModel.value.driverBookingDetails?.stops?[0]?.coordinates !=
                "") {
          addMarkers(
              LatLng(
                  myRidesModel.value.driverBookingDetails?.stops?[0]
                          ?.coordinates?.lastOrNull ??
                      0.0,
                  myRidesModel.value.driverBookingDetails?.stops?[0]
                          ?.coordinates?.firstOrNull ??
                      0.0),
              "",
              "Stop",
              0.0);
          if (myRidesModel.value.driverBookingDetails?.stops?[1]?.coordinates !=
                  null ||
              myRidesModel.value.driverBookingDetails?.stops?[1]?.coordinates !=
                  "") {
            addMarkers(
                LatLng(
                    myRidesModel.value.driverBookingDetails?.stops?[1]
                            ?.coordinates?.lastOrNull ??
                        0.0,
                    myRidesModel.value.driverBookingDetails?.stops?[1]
                            ?.coordinates?.firstOrNull ??
                        0.0),
                "",
                "Stop",
                0.0);
          }
        }
      }
    });
  }

  startRideAPI() async {
    try {
      final response = await APIManager.startRide(
          body: {"driverRideId": myRidesModel.value.driverRideId});
      var data = jsonDecode(response.toString());
      if (data['status']) {
        myRidesModel.value.driverBookingDetails?.isStarted = true;
      }
      myRidesModel.refresh();
      showMySnackbar(msg: response.data['message']);
    } catch (e) {
      debugPrint(e.toString());
    }

    myRidesModel.refresh();
  }

  endRideAPI() async {
    try {
      final response = await APIManager.endRide(
          body: {"driverRideId": myRidesModel.value.driverRideId});
      if (response.data['status']) {
        Get.offNamed(Routes.RATING_DRIVER_SIDE, arguments: myRidesModel.value);
      } else {
        showMySnackbar(msg: response.data['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /*pickUpAPI(String riderId) async {
    try {
      final response = await APIManager.pickUpRider(body: {
        "riderId": riderId,
        "riderRideId": myRidesModel.value.riderRideId,
        "riderNotificationPreferences": myRidesModel
            .value
            .driverBookingDetails
            ?.riderBookingDetails?[selectedRider.value]
            ?.riderDetails
            ?.notificationPreferences
            ?.toJson(),
        "riderName": myRidesModel.value.driverBookingDetails
            ?.riderBookingDetails?.firstOrNull?.riderDetails?.fullName,
        "driverId": myRidesModel.value.driverId
      });
      if (response.data['status']) {
        myRidesModel.value.driverBookingDetails
            ?.riderBookingDetails?[selectedRider.value].isStarted = true;
        myRidesModel.refresh();
        showMySnackbar(msg: response.data['message']);
      } else {
        showMySnackbar(msg: response.data['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    myRidesModel.value.driverBookingDetails!.isCompleted = true;
    myRidesModel.refresh();
  }

  dropOffAPI(String riderId) async {
    try {
      final res = await APIManager.dropOffRider(body: {
        "riderId": riderId,
        "riderRideId": myRidesModel.value.riderRideId,
        "riderNotificationPreferences": myRidesModel
            .value
            .driverBookingDetails
            ?.riderBookingDetails?[selectedRider.value]
            ?.riderDetails
            ?.notificationPreferences!
            .toJson(),
        "riderName": myRidesModel.value.driverBookingDetails
            ?.riderBookingDetails?.firstOrNull?.riderDetails?.fullName,
        "driverRideId": myRidesModel.value.driverRideId
      });
      if (res.data["status"]) {
        myRidesModel.value.driverBookingDetails
            ?.riderBookingDetails?[selectedRider.value].isCompleted = true;
      } else {
        showMySnackbar(msg: res.data["message"]);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }*/

  @override
  void onClose() {
    positionStream?.cancel();
    super.onClose();
  }

  showChatBottomSheet() async {
    try {
      final res = await APIManager.getChatRoomId(
          receiverId: myRidesModel
                  .value
                  .driverBookingDetails
                  ?.riderBookingDetails?[selectedRider.value]
                  ?.riderDetails
                  ?.Id ??
              "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: myRidesModel.value.driverBookingDetails
                  ?.riderBookingDetails?[selectedRider.value]?.riderDetails?.Id,
              name: myRidesModel
                      .value
                      .driverBookingDetails
                      ?.riderBookingDetails?[selectedRider.value]
                      ?.riderDetails
                      ?.fullName ??
                  "",
              image: myRidesModel
                      .value
                      .driverBookingDetails
                      ?.riderBookingDetails?[selectedRider.value]
                      ?.riderDetails
                      ?.profilePic
                      ?.url ??
                  ""));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: "",
              deleteUpdateTime: "",
              id: myRidesModel.value.driverBookingDetails
                  ?.riderBookingDetails?[selectedRider.value]?.riderDetails?.Id,
              name: myRidesModel
                      .value
                      .driverBookingDetails
                      ?.riderBookingDetails?[selectedRider.value]
                      ?.riderDetails
                      ?.fullName ??
                  "",
              image: myRidesModel
                      .value
                      .driverBookingDetails
                      ?.riderBookingDetails?[selectedRider.value]
                      ?.riderDetails
                      ?.profilePic
                      ?.url ??
                  ""));
    }
  }

  double getLat() {
    final originCoordinates =
        myRidesModel.value.driverBookingDetails?.riders?.isNotEmpty ?? false
            ? myRidesModel.value.driverBookingDetails?.riders?.isNotEmpty ??
                    false
                ? myRidesModel.value.driverBookingDetails?.riderBookingDetails
                    ?.firstOrNull?.origin?.coordinates?.last
                : null
            : null;

    final coordinates = originCoordinates ?? 0.0;
    return coordinates;
  }

  double getLong() {
    final originCoordinates =
        myRidesModel.value.driverBookingDetails?.riders?.isNotEmpty ?? false
            ? myRidesModel.value.driverBookingDetails?.riders?.isNotEmpty ??
                    false
                ? myRidesModel.value.driverBookingDetails?.riderBookingDetails
                    ?.first?.origin?.coordinates?.first
                : null
            : null;

    final coordinates = originCoordinates ?? 0.0;
    return coordinates;
  }

  getOrigin() {
    try {
      return myRidesModel.value.driverBookingDetails
          ?.riderBookingDetails?[selectedRider.value]?.origin?.name;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  getDestination() {
    try {
      return myRidesModel.value.driverBookingDetails
          ?.riderBookingDetails?[selectedRider.value]?.destination?.name;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  getImage() {
    try {
      return myRidesModel
          .value
          .driverBookingDetails
          ?.riderBookingDetails?[selectedRider.value]
          ?.riderDetails
          ?.profilePic
          ?.url;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  String getName() {
    try {
      return myRidesModel
              .value
              .driverBookingDetails
              ?.riderBookingDetails?[selectedRider.value]
              ?.riderDetails
              ?.fullName ??
          "";
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  getPhone() {
    try {
      return myRidesModel.value.driverBookingDetails?.riderBookingDetails
              ?.firstOrNull?.riderDetails?.phone ??
          "";
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  actionTap() async {
    if (myRidesModel.value.driverBookingDetails?.isStarted ?? false) {
      await endRideAPI();
    } else {
      await startRideAPI();
    }
    getButtonLabel();
  }

  getButtonLabel() {
    if (myRidesModel.value.driverBookingDetails?.isStarted ?? false) {
      btnText.value = Strings.endRide;
    } else {
      btnText.value = Strings.startRide;
    }
  }

  updateIndex(int index1) {
    selectedRider.value = index1;
    myRidesModel.refresh();
    getButtonLabel();
  }

  void openGoogleMaps() {
    GpUtil.openGoogleMap(
        myRidesModel.value.driverBookingDetails?.origin?.coordinates?.last ??
            0.0,
        myRidesModel.value.driverBookingDetails?.origin?.coordinates?.first ??
            0.0,
        myRidesModel
                .value.driverBookingDetails?.destination?.coordinates?.last ??
            0.0,
        myRidesModel
                .value.driverBookingDetails?.destination?.coordinates?.first ??
            0.0);
  }
}
