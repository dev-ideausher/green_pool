import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../modules/home/controllers/home_controller.dart';
import '../services/colors.dart';

class ImageUtil {
  static Future<XFile?> squareCropCompressImage(
      {required CropAspectRatio cropAspectRatio,
      required ImageSource imageSource}) async {
    XFile? pickImage = await ImagePicker().pickImage(source: imageSource);
    print("IMAGE PICKED");

    if (pickImage == null) return null;

    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickImage.path,
        aspectRatio: cropAspectRatio,
        compressQuality: 90,
        compressFormat: ImageCompressFormat.jpg);

    if (croppedFile == null) return null;

    print("IMAGE CROPPED");

    final originalImage = File(croppedFile!.path);
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
      showMySnackbar(
          msg:
              "We couldn't save the image. Please try again or choose another image.");
      return null;
    }
  }

  static Future<XFile?> cropCompressImage(
      {required ImageSource imageSource}) async {
    XFile? pickImage = await ImagePicker().pickImage(source: imageSource);
    print("IMAGE PICKED");

    if (pickImage == null) return null;

    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickImage.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Get.find<HomeController>().isPinkModeOn.value
                ? ColorUtil.kSecondaryPinkMode
                : ColorUtil.kSecondary07,
            toolbarWidgetColor: Get.find<HomeController>().isPinkModeOn.value
                ? ColorUtil.kPrimary2PinkMode
                : ColorUtil.kSecondary01,
            activeControlsWidgetColor:
                Get.find<HomeController>().isPinkModeOn.value
                    ? ColorUtil.kPrimary3PinkMode
                    : ColorUtil.kSecondary03,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio3x2,
            ],
          ),
          IOSUiSettings(
            title: '',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio3x2,
            ],
          ),
        ],
        compressQuality: 90,
        compressFormat: ImageCompressFormat.jpg);

    if (croppedFile == null) return null;

    print("IMAGE CROPPED");

    final originalImage = File(croppedFile!.path);
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
      showMySnackbar(
          msg:
              "We couldn't save the image. Please try again or choose another image.");
      return null;
    }
  }

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
}
