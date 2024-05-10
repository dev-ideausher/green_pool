import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/data/chat_arg.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/live_location_model.dart';
import '../../../data/my_rides_model.dart';
import '../../../res/strings.dart';
import '../../../services/dio/endpoints.dart';
import '../../home/controllers/home_controller.dart';

class RiderStartRideMapController extends GetxController {
  final double latitude = Get.find<HomeController>().latitude.value;
  final double longitude = Get.find<HomeController>().longitude.value;
  late GoogleMapController mapController;
  final Set<Marker> markers = <Marker>{}.obs;
  final RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  final Rx<MyRidesModelData> myRidesModel = MyRidesModelData().obs;
  final RxDouble currentLat = 0.0.obs;
  final RxDouble currentLong = 0.0.obs;

  final RxDouble destinationLat = 0.0.obs;
  final RxDouble destinationLong = 0.0.obs;
  final RxBool isLoad = true.obs;
  final RxBool isArrival = false.obs;
  final RxString arrivalTime = "N/A".obs;
  final RxBool isPickUp = false.obs;

  @override
  void onInit() {
    super.onInit();
    myRidesModel.value = Get.arguments;
    isArrival.value = myRidesModel.value.confirmDriverDetails?.first
            ?.driverPostsDetails?.first?.isStarted ??
        false;
    if (myRidesModel
            .value.confirmDriverDetails?.first?.pickUpStatus?.isPickUp ??
        false) {
      isArrival.value = false;
      isPickUp.value = true;
      destinationLat.value =
          myRidesModel.value.destination?.coordinates?.last ?? 0.0;
      destinationLong.value =
          myRidesModel.value.destination?.coordinates?.first ?? 0.0;
    } else {
      destinationLat.value =
          myRidesModel.value.origin?.coordinates?.last ?? 0.0;
      destinationLong.value =
          myRidesModel.value.origin?.coordinates?.first ?? 0.0;
    }
    isLoad.value = false;
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 270.0,
        // target: LatLng(destinationLat.value, destinationLong.value),
        target: LatLng(latitude, longitude),
        tilt: 30.0,
        zoom: 17.0,
      ),
    ));
    polylineCoordinates.refresh();
    onChangeLocation();
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

  StreamSubscription<Position>? driversPositionStream;

  void onChangeLocation() {
    FirebaseDatabase.instance
        .ref()
        .child('locations')
        .child(myRidesModel.value.confirmDriverDetails?.first
                ?.driverPostsDetails?.first?.driverId ??
            "")
        .onValue
        .listen((event) async {
      var data = event.snapshot.value;
      if (data is Map) {
        final liveLocation =
            LiveLocationModel.fromMap(Map<String, dynamic>.from(data));
        currentLat.value = liveLocation.latitude ?? 0.0;
        currentLong.value = liveLocation.longitude ?? 0.0;
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                bearing: 270.0,
                target: LatLng(currentLat.value, currentLong.value),
                tilt: 30.0,
                zoom: 17.0)));
        if (isArrival.value) {
          getArrivalTime(currentLat.value, currentLong.value,
              destinationLat.value, destinationLong.value);
        }
      }
      drawPolyline();
    }, onError: (Object error) {
      debugPrint("Error: $error");
    });
  }

  drawPolyline() async {
    try {
      markers.clear();

      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
          Endpoints.googleApiKey,
          PointLatLng(currentLat.value, currentLong.value),
          PointLatLng(destinationLat.value, destinationLong.value),
          travelMode: TravelMode.driving);
      if (result.points.isNotEmpty) {
        polylineCoordinates.assignAll(result.points
            .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
            .toList());
        addMarker(polylineCoordinates.first, /*sourceMark!,*/ 0.0);
        addMarker(polylineCoordinates.last, /*destinationMark!,*/ 0.0);
        mapController.animateCamera(CameraUpdate.newLatLngBounds(
            GpUtil.boundsFromLatLngList(polylineCoordinates), 70));
      }
    } catch (e) {
      debugPrint('Error in drawPolyline: $e');
    }
  }

  void addMarker(LatLng position, double d) {
    markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        icon: BitmapDescriptor.defaultMarker,
        rotation: 0));
  }

  void getArrivalTime(double latitude, double longitude, double destinationLat,
      double destinationLong) async {
    try {
      final response = await APIManager.getArrivalTime(
          origin: ("$latitude,$longitude"),
          destination: ("$latitude,$longitude"));
      final data = response.data;
      final routes = data['routes'] as List<dynamic>;
      if (routes.isNotEmpty) {
        final route = routes[0];
        final legs = route['legs'] as List<dynamic>;
        if (legs.isNotEmpty) {
          final leg = legs[0];
          final duration = leg['duration'] as Map<String, dynamic>;
          final durationText = duration['text'] as String;
          arrivalTime.value = durationText;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String getMsg() {
    if (isArrival.value) {
      return arrivalTime.value.contains("1 min")
          ? Strings.yourRideIsArrived
          : "${Strings.yourRideIsArrivingIn} ${arrivalTime.value}.";
    } else {
      if (isLessThanFiveMinutes(arrivalTime.value)) {
        return Strings.youAreAboutToReachYourDestination;
      } else {
        return Strings.youWillReachYourDestinationIn + arrivalTime.value;
      }
    }
  }

  bool isLessThanFiveMinutes(String minutesString) {
    try {
      int minutes = int.parse(minutesString.split(' ')[0]);
      return minutes < 5;
    } catch (e) {
      // Handle parsing errors, invalid format, etc.
      print('Error parsing minutes: $e');
      return false;
    }
  }

  callToDriver() async {
    final url = Uri.parse(
        'tel:${myRidesModel.value.confirmDriverDetails?.first?.driverPostsDetails?.first?.driverDetails?.first?.phone}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  chatWithDriver() async {
    try {
      final res = await APIManager.getChatRoomId(
          receiverId: myRidesModel.value.confirmDriverDetails?.first
                  ?.driverPostsDetails?.first?.driverId ??
              "",
          ridePostId: myRidesModel.value.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["chatChannelId"] ?? "",
              rideId: myRidesModel.value.Id ?? "",
              id: myRidesModel.value.confirmDriverDetails?.first
                  ?.driverPostsDetails?.first?.driverId,
              name: myRidesModel.value.confirmDriverDetails?.first
                  ?.driverPostsDetails?.first?.driverDetails?.first?.fullName,
              image: myRidesModel
                  .value
                  .confirmDriverDetails
                  ?.first
                  ?.driverPostsDetails
                  ?.first
                  ?.driverDetails
                  ?.first
                  ?.profilePic
                  ?.url));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              rideId: myRidesModel.value.Id ?? "",
              id: myRidesModel.value.confirmDriverDetails?.first
                  ?.driverPostsDetails?.first?.driverId,
              name: myRidesModel.value.confirmDriverDetails?.first
                  ?.driverPostsDetails?.first?.driverDetails?.first?.fullName,
              image: myRidesModel
                  .value
                  .confirmDriverDetails
                  ?.first
                  ?.driverPostsDetails
                  ?.first
                  ?.driverDetails
                  ?.first
                  ?.profilePic
                  ?.url));
      debugPrint(e.toString());
    }
  }

  List<String> emergencyContacts = [
    'contact1@example.com',
    'contact2@example.com'
  ]; // Add your emergency contacts here
  bool isSOSActive = false;

  void startSOS() {
    isSOSActive = true;
    print('SOS activated!');

    Timer(Duration(seconds: 10), () {
      if (isSOSActive) {
        sendSOSMessage();
      }
    });
  }

  void cancelSOS() {
    isSOSActive = false;
    print('SOS canceled.');
  }

  void sendSOSMessage() {
    print('Sending SOS message to emergency contacts: $emergencyContacts');
    // Code to send SOS message to emergency contacts
  }
}
