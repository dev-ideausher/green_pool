import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/directions.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

import 'dio/endpoints.dart';

class GpUtil {
  static Future<XFile?> compressImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    final originalImage = File(pickedFile!.path);
    final targetPath = originalImage.path;
    final directory =
        originalImage.parent; // Get the parent directory of the original image
    final fileName =
        'compressed_${originalImage.uri.pathSegments.last}'; // Create a new filename
    final compressedPath =
        '${directory.path}/$fileName'; // Ensure it ends with .jpg
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        targetPath, compressedPath,
        quality: 10);
    if (compressedImage != null) {
      return XFile(compressedImage.path);
    } else {
      // Compression failed, handle the error
      return null;
    }
  }

  static Future<List<XFile>?> compressImages(ImageSource imageSource) async {
    final pickedFiles = await ImagePicker()
        .pickMultiImage(); // pickMultiImage for multiple images
    if (pickedFiles == null || pickedFiles.isEmpty) {
      return null;
    }

    List<XFile> compressedImages = [];

    for (var pickedFile in pickedFiles) {
      final originalImage = File(pickedFile.path);
      final targetPath = originalImage.path;
      final directory = originalImage
          .parent; // Get the parent directory of the original image
      final fileName =
          'compressed_${originalImage.uri.pathSegments.last}'; // Create a new filename
      final compressedPath =
          '${directory.path}/$fileName'; // Ensure it ends with .jpg

      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        targetPath,
        compressedPath,
        quality: 10,
      );

      if (compressedImage != null) {
        compressedImages.add(XFile(compressedImage.path));
      } else {
        // Handle the case where compression fails for one image
        print('Compression failed for ${pickedFile.path}');
      }
    }

    return compressedImages.isNotEmpty ? compressedImages : null;
  }

  static Future<String> calculateDistance({
    required double startLat,
    required double startLong,
    required double endLat,
    required double endLong,
  }) async {
    GoogleMapsDirections directions =
        GoogleMapsDirections(apiKey: Endpoints.googleApiKey);
    DirectionsResponse response = await directions.directionsWithLocation(
      Location(lat: startLat, lng: startLong),
      Location(lat: endLat, lng: endLong),
      travelMode: TravelMode.driving,
    );

    if (response.isOkay) {
      final distanceInMeters = response.routes.first.legs.first.distance;
      // Convert distance from meters to kilometers
      //final distanceInKilometers = distanceInMeters / 1000.0;
      return distanceInMeters.text.toString();
    } else {
      return "0"; // Return a double value for consistency
    }
  }

  static Future<num> calculateDistanceInInt({
    required double startLat,
    required double startLong,
    required double endLat,
    required double endLong,
  }) async {
    final directions = GoogleMapsDirections(apiKey: Endpoints.googleApiKey);
    final response = await directions.directionsWithLocation(
      Location(lat: startLat, lng: startLong),
      Location(lat: endLat, lng: endLong),
      travelMode: TravelMode.driving,
    );

    if (response.isOkay) {
      final distanceInMeters = response.routes.first.legs.first.distance.value;
      // Convert distance from meters to kilometers
      final distanceInKilometers = distanceInMeters / 1000.0;
      return distanceInKilometers;
    } else {
      return 0; // Return 0 if the response is not okay
    }
  }

  /* static double calculateDistance({
    required double startLat,
    required double startLong,
    required double endLat,
    required double endLong,
  }) {
    const double earthRadius = 6371.0; // Radius of the Earth in kilometers

    double toRadians(double degree) {
      return degree * (pi / 180.0);
    }

    double lat1 = toRadians(startLat);
    double lon1 = toRadians(startLong);
    double lat2 = toRadians(endLat);
    double lon2 = toRadians(endLong);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    return distance;
  }*/

  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLong = double.infinity;
    double maxLong = -double.infinity;

    for (LatLng latLng in list) {
      if (latLng.latitude < minLat) minLat = latLng.latitude;
      if (latLng.latitude > maxLat) maxLat = latLng.latitude;
      if (latLng.longitude < minLong) minLong = latLng.longitude;
      if (latLng.longitude > maxLong) maxLong = latLng.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLong),
      northeast: LatLng(maxLat, maxLong),
    );
  }

  static void moveCamera(GoogleMapController mapController, LatLng target) {
    if (!isPositionInsideBounds(target)) {
      mapController.moveCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: const LatLng(41.675537, -141.001873), // Canada
            northeast: const LatLng(83.110626, -52.619403), //  Canada
          ),
          0));
    }
  }

  static bool isPositionInsideBounds(LatLng position) {
    return position.latitude >= 41.675537 &&
        position.latitude <= 83.110626 &&
        position.longitude >= -141.001873 &&
        position.longitude <= -52.619403;
  }

  static Future<Uint8List> getMarker(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static String getAgoTime(String? dateTimeString) {
    if (dateTimeString == null) {
      return '';
    } else {
      DateTime dateTime = DateTime.parse(dateTimeString);
      DateTime now = DateTime.now();

      Duration difference = now.difference(dateTime);

      if (now.year == dateTime.year &&
          now.month == dateTime.month &&
          now.day == dateTime.day) {
        // If the date is today
        if (difference.inHours > 0) {
          return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
        } else if (difference.inMinutes > 0) {
          return "${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago";
        } else {
          return "just now";
        }
      } else {
        // Otherwise, show date in 'dd MMM yyyy' format
        return DateFormat('dd MMM yyyy').format(dateTime);
      }
    }
  }

  static String formatTime(DateTime timestamp) {
    final localTime = timestamp.toLocal(); // Convert to local time zone

    return DateFormat.jm().format(localTime);
  }

  static String formatDate(DateTime timestamp) {
    final localTimestamp = timestamp.toLocal(); // Convert to local time zone

    return DateFormat('dd MMM yyyy').format(localTimestamp);
  }

  static String formatDateddMMMyyyy(String timestamp) {
    if (timestamp.isEmpty) {
      return "";
    }

    try {
      DateTime utcDateTime = DateTime.parse(timestamp);
      DateTime localDateTime = utcDateTime.toLocal();
      String formattedLocalDateTime =
          DateFormat('dd MMM yyyy').format(localDateTime);

      return formattedLocalDateTime;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  static bool isToday(DateTime timestamp) {
    final dateToCheck = timestamp.toLocal();
    DateTime now = DateTime.now();
    return dateToCheck.year == now.year &&
        dateToCheck.month == now.month &&
        dateToCheck.day == now.day;
  }

  static String getDateFormat(String time) {
    var outputDate = "";
    if (time != "") {
      try {
        var combinedDateUtc = convertCombinedUtcToLocal(time);
        outputDate =
            formatDate(DateTime.parse(combinedDateUtc.split("T").first))
                .toString();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return outputDate;
  }

  static String getTime(var mnow) {
    var outputDate = "";
    if (mnow != null) {
      try {
        var datetime = DateTime.parse(mnow);
        var localDate = datetime.toLocal();

        var outputFormat = DateFormat('HH:mm');
        outputDate = outputFormat.format(localDate);
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return outputDate;
  }

  static Future<BitmapDescriptor> getMarkerIconFromUrl(String url) async {
    final Dio dio = Dio();
    final Response response =
        await dio.get(url, options: Options(responseType: ResponseType.bytes));
    if (response.statusCode != 200) {
      throw Exception('Failed to load image');
    }
    final Uint8List bytes = Uint8List.fromList(response.data);
    final ui.Codec codec = await ui.instantiateImageCodec(bytes,
        targetWidth: 100, targetHeight: 100);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint();
    final double size = 66.0;

    // Draw a circle and clip the image to this circle
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2, paint);
    paint.isAntiAlias = true;
    canvas.clipPath(Path()..addOval(Rect.fromLTWH(0, 0, size, size)));
    canvas.drawImage(image, Offset(0, 0), paint);

    final ui.Image circularImage = await pictureRecorder
        .endRecording()
        .toImage(size.toInt(), size.toInt());
    final ByteData? byteData =
        await circularImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  static Future<void> openGoogleMap(double pickupLat, double pickupLng,
      double destinationLat, double destinationLng) async {
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$pickupLat,$pickupLng&destination=$destinationLat,$destinationLng';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  static String convertCombinedToGmt(String combinedDateTime) {
    if (combinedDateTime.isEmpty) {
      return "";
    }

    try {
      var inputFormat = DateFormat("yyyy-MM-dd'T'hh:mm a");
      var localDateTime = inputFormat.parse(combinedDateTime);
      var gmtDateTime = localDateTime.toUtc();

      // var outputFormat = DateFormat('yyyy-MM-ddTHH:mm');
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

      return outputFormat.format(gmtDateTime);
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  static String convertCombinedUtcToLocal(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return "";
    }

    try {
      var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm");

      var utcDateTime = inputFormat.parseUtc(utcTimeString);
      var localDateTime = utcDateTime.toLocal();

      var outputFormat = DateFormat("yyyy-MM-dd'T'hh:mm a");

      return outputFormat.format(localDateTime);
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  static String convertLocalTimeToGmt(String localTimeString) {
    if (localTimeString.isEmpty) {
      return "";
    }

    try {
      // Parse the local time string to a DateTime object
      var localDateTime = DateFormat('HH:mm').parse(localTimeString);

      // Convert the local DateTime to UTC
      var gmtDateTime = localDateTime.toUtc();

      // Format the GMT DateTime object to a string
      var outputFormat = DateFormat('HH:mm');
      return outputFormat.format(gmtDateTime);
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  static String convertUtcToLocal(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return "";
    }

    try {
      // Parse the UTC time string to a DateTime object
      var utcDateTime =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parseUtc(utcTimeString);

      // Convert the UTC DateTime to local time
      var localDateTime = utcDateTime.toLocal();

      // Format the local DateTime object to a string
      var outputFormat = DateFormat('hh:mm a');
      return outputFormat.format(localDateTime);
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  static bool isAfterCurrentTime(String inputTime) {
    // Parse the input time
    DateFormat inputFormat = DateFormat('h:mm a');
    DateTime inputDateTime = inputFormat.parse(inputTime);

    // Get the current local time
    DateTime now = DateTime.now();

    // Compare only the hour and minute
    if (inputDateTime.hour > now.hour) {
      return true;
    } else if (inputDateTime.hour == now.hour &&
        inputDateTime.minute >= now.minute) {
      return true;
    }
    return false;
  }

  /*static bool checkSixMonthsDuration(String prevCancellationDate) {
    DateTime prevDateUtc = DateTime.parse(prevCancellationDate);

    DateTime prevDateLocal = prevDateUtc.toLocal();

    DateTime currentDate = DateTime.now();

    DateTime sixMonthsAgo = DateTime(
      currentDate.year,
      currentDate.month - 6,
      currentDate.day,
      currentDate.hour,
      currentDate.minute,
      currentDate.second,
      currentDate.millisecond,
      currentDate.microsecond,
    );
    return prevDateLocal.isAfter(sixMonthsAgo);
  }*/
  static bool checkSixMonthsDuration(String prevCancellationDate) {
    DateTime prevDateUtc = DateTime.parse(prevCancellationDate);

    DateTime prevDateLocal = prevDateUtc.toLocal();

    DateTime currentDate = DateTime.now();

    // Calculate six months ago
    DateTime sixMonthsAgo = DateTime(
      currentDate.year,
      currentDate.month - 6,
      currentDate.day,
      currentDate.hour,
      currentDate.minute,
      currentDate.second,
      currentDate.millisecond,
      currentDate.microsecond,
    );

    // Handle the case where month subtraction leads to a negative or zero month
    if (sixMonthsAgo.month <= 0) {
      sixMonthsAgo = DateTime(
        currentDate.year - 1,
        sixMonthsAgo.month + 12,
        currentDate.day,
        currentDate.hour,
        currentDate.minute,
        currentDate.second,
        currentDate.millisecond,
        currentDate.microsecond,
      );
    }

    return prevDateLocal.isAfter(sixMonthsAgo);
  }
}
