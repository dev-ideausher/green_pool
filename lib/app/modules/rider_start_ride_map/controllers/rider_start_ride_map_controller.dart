import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/data/chat_arg.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/image_constant.dart';
import '../../../data/booking_detail_model.dart';
import '../../../data/live_location_model.dart';
import '../../../data/my_rides_model.dart';
import '../../../res/strings.dart';
import '../../../services/dio/endpoints.dart';
import '../views/sos_dialog.dart';

class RiderStartRideMapController extends GetxController {
  late GoogleMapController mapController;
  final Set<Marker> markers = <Marker>{}.obs;
  final RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  final Rx<BookingDetailModelData> bookingDetail = BookingDetailModelData().obs;

  final RxDouble currentLat = Endpoints.canadaLat.obs;
  final RxDouble currentLong = Endpoints.canadaLong.obs;

  final RxDouble destinationLat = Endpoints.canadaLat.obs;
  final RxDouble destinationLong = Endpoints.canadaLong.obs;
  final RxBool isLoad = true.obs;
  final RxString arrivalTime = "N/A".obs;
  Rx<BookingDetailModelDataDriverBookingDetailsRiderBookingDetails>
      riderBookingDetail =
      BookingDetailModelDataDriverBookingDetailsRiderBookingDetails().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final MyRidesModelData myRidesModel = Get.arguments;
    currentLat.value = myRidesModel.origin!.coordinates!.last ?? 0.0;
    currentLong.value = myRidesModel.origin!.coordinates!.first ?? 0.0;
    destinationLat.value = myRidesModel.destination?.coordinates?.last ?? 0.0;
    destinationLong.value = myRidesModel.destination?.coordinates?.first ?? 0.0;
    await myRidesDetailsAPI(
        myRidesModel.confirmDriverDetails!.firstOrNull?.driverRideId ?? "");
    await drawPolyline();
    isLoad.value = false;
  }

  myRidesDetailsAPI(String rideId) async {
    try {
      final response = await APIManager.getMyRidesDetails(rideId: rideId);
      bookingDetail.value = BookingDetailModel.fromJson(response.data).data!;
      final String? firebaseUid = Get.find<GetStorageService>().getFirebaseUid;
      final driverBookingDetails = bookingDetail.value.driverBookingDetails;
      if (driverBookingDetails != null && firebaseUid != null) {
        riderBookingDetail.value = driverBookingDetails.riderBookingDetails!
            .firstWhere((element) => (element.riderDetails?.firebaseUid ?? "")
                .contains(firebaseUid));
        if (riderBookingDetail.value.isStarted ?? false) {
          getArrivalTime(
              bookingDetail
                      .value.driverBookingDetails?.origin?.coordinates?.last ??
                  0.0,
              bookingDetail.value.driverBookingDetails?.origin?.coordinates?.first ??
                  0.0,
              bookingDetail.value.driverBookingDetails?.destination?.coordinates
                      ?.last ??
                  0.0,
              bookingDetail.value.driverBookingDetails?.destination?.coordinates
                      ?.first ??
                  0.0);
        } else {
          getArrivalTime(
              currentLat.value,
              currentLong.value,
              bookingDetail.value.driverBookingDetails?.destination?.coordinates
                      ?.last ??
                  0.0,
              bookingDetail.value.driverBookingDetails?.destination?.coordinates
                      ?.first ??
                  0.0);
        }
      }
    } catch (e) {
      debugPrint("myrides details api error: $e");
    }
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    onChangeLocation();
    polylineCoordinates.refresh();
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
        .child(bookingDetail.value.driverId ?? "")
        .onValue
        .listen((event) async {
      var data = event.snapshot.value;
      if (data is Map) {
        final liveLocation =
            LiveLocationModel.fromMap(Map<String, dynamic>.from(data));
        final heading = liveLocation.heading;
        currentLat.value = liveLocation.latitude ?? 0.0;
        currentLong.value = liveLocation.longitude ?? 0.0;
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                bearing: 270.0,
                target: LatLng(currentLat.value, currentLong.value),
                tilt: 30.0,
                zoom: 17.0)));
        if (riderBookingDetail.value.isStarted ?? false) {
          destinationLat.value = bookingDetail
                  .value.driverBookingDetails?.destination?.coordinates?.last ??
              0.0;
          destinationLong.value = bookingDetail.value.driverBookingDetails
                  ?.destination?.coordinates?.first ??
              0.0;

          getArrivalTime(
              currentLat.value,
              currentLong.value,
              bookingDetail.value.driverBookingDetails?.destination?.coordinates
                      ?.last ??
                  0.0,
              bookingDetail.value.driverBookingDetails?.destination?.coordinates
                      ?.first ??
                  0.0);
        } else {
          destinationLat.value = bookingDetail
                  .value.driverBookingDetails?.origin?.coordinates?.last ??
              0.0;
          destinationLong.value = bookingDetail
                  .value.driverBookingDetails?.origin?.coordinates?.first ??
              0.0;
          getArrivalTime(
              currentLat.value,
              currentLong.value,
              bookingDetail
                      .value.driverBookingDetails?.origin?.coordinates?.last ??
                  0.0,
              bookingDetail
                      .value.driverBookingDetails?.origin?.coordinates?.first ??
                  0.0);
        }
        markers.clear();
        addMarkers(
            LatLng(
                bookingDetail.value.driverBookingDetails?.origin?.coordinates
                        ?.lastOrNull ??
                    0.0,
                bookingDetail.value.driverBookingDetails?.origin?.coordinates
                        ?.firstOrNull ??
                    0.0),
            "",
            "Origin",
            0.0);
        addMarkers(
            LatLng(
                bookingDetail.value.driverBookingDetails?.destination
                        ?.coordinates?.lastOrNull ??
                    0.0,
                bookingDetail.value.driverBookingDetails?.destination
                        ?.coordinates?.firstOrNull ??
                    0.0),
            "",
            "Destination",
            0.0);
        addMarkers(LatLng(currentLat.value, currentLong.value),
            ImageConstant.pngCarPointer, "", heading);
      }
    }, onError: (Object error) {
      debugPrint("Error: $error");
    });
  }

  drawPolyline() async {
    try {
      markers.clear();

      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
          googleApiKey: Endpoints.googleApiKey,
          request: PolylineRequest(
              origin: PointLatLng(currentLat.value, currentLong.value),
              destination:
                  PointLatLng(destinationLat.value, destinationLong.value),
              mode: TravelMode.driving));
      if (result.points.isNotEmpty) {
        polylineCoordinates.assignAll(result.points
            .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
            .toList());
        // addVehicleMarker(
        //     polylineCoordinates.first,
        //     bookingDetail
        //             .value.driverDetails?.vehicleDetails?.vehiclePic?.url ??
        //         "");

        addMarkers(
            LatLng(
                bookingDetail.value.driverBookingDetails?.origin?.coordinates
                        ?.lastOrNull ??
                    0.0,
                bookingDetail.value.driverBookingDetails?.origin?.coordinates
                        ?.firstOrNull ??
                    0.0),
            "",
            "Origin",
            0.0);
        addMarkers(
            LatLng(
                bookingDetail.value.driverBookingDetails?.origin?.coordinates
                        ?.lastOrNull ??
                    0.0,
                bookingDetail.value.driverBookingDetails?.origin?.coordinates
                        ?.firstOrNull ??
                    0.0),
            ImageConstant.pngCarPointer,
            "",
            0.0);
        addMarkers(
            LatLng(
                bookingDetail.value.driverBookingDetails?.destination
                        ?.coordinates?.lastOrNull ??
                    0.0,
                bookingDetail.value.driverBookingDetails?.destination
                        ?.coordinates?.firstOrNull ??
                    0.0),
            "",
            "Destination",
            0.0);

        mapController.animateCamera(CameraUpdate.newLatLngBounds(
            GpUtil.boundsFromLatLngList(polylineCoordinates), 70));
      }
    } catch (e) {
      debugPrint('Error in drawPolyline: $e');
    }
  }

  Future<void> addVehicleMarker(LatLng position, String url) async {
    final bytes = await GpUtil.getMarkerIconFromUrl(
        bookingDetail.value.driverDetails?.vehicleDetails?.vehiclePic?.url ??
            "");
    markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        icon: url.isEmpty ? BitmapDescriptor.defaultMarker : bytes,
        rotation: 0));
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
      anchor: const Offset(0.5, 0),
      icon: image == ""
          ? BitmapDescriptor.defaultMarker
          : await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(200.kw, 200.kh)), image),
    ));
  }

  void getArrivalTime(double latitude, double longitude, double originLat,
      double originLong) async {
    try {
      final response = await APIManager.getArrivalTime(
          origin: ("$originLat,$originLong"),
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
    if ((riderBookingDetail.value.isStarted ?? false) == false) {
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
    final url =
        Uri.parse('tel:${bookingDetail.value.driverDetails?.phone ?? ""}');
    await launchUrl(url);
  }

  chatWithDriver() async {
    try {
      final res = await APIManager.getChatRoomId(
          receiverId: bookingDetail.value.driverDetails?.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: bookingDetail.value.driverDetails?.Id,
              name: bookingDetail.value.driverDetails?.fullName,
              image: bookingDetail.value.driverDetails?.profilePic?.url));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: "",
              deleteUpdateTime: "",
              id: bookingDetail.value.driverDetails?.Id,
              name: bookingDetail.value.driverDetails?.fullName,
              image: bookingDetail.value.driverDetails?.profilePic?.url));
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

  sos() {
    Get.dialog(useSafeArea: true, const SosDialog());
  }

  void openGoogleMaps() {
    GpUtil.openGoogleMap(destinationLat.value, destinationLong.value);
  }
}
