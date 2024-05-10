import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

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

  static double calculateDistance({
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

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    return distance;
  }

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
}
