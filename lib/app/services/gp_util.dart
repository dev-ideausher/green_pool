import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class GpUtil {
  static Future<XFile?> compressImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    final originalImage = File(pickedFile!.path);
    final targetPath = originalImage.path;
    final directory = originalImage.parent; // Get the parent directory of the original image
    final fileName = 'compressed_${originalImage.uri.pathSegments.last}'; // Create a new filename
    final compressedPath = '${directory.path}/$fileName'; // Ensure it ends with .jpg
    final compressedImage = await FlutterImageCompress.compressAndGetFile(targetPath, compressedPath, quality: 10);
    if (compressedImage != null) {
      return XFile(compressedImage.path);
    } else {
      // Compression failed, handle the error
      return null;
    }
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


}
