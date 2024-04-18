import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

class GpImagePicker {
  static imgOpt({required BuildContext context, required Function onBack}) {
    XFile? pickedImage;
    return Get.bottomSheet(
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.kh),
              topRight: Radius.circular(30.kh),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.kw),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.kh,
                  ),
                  InkWell(
                    onTap: () async {
                      final picker = ImagePicker();
                      pickedImage = await picker.pickImage(source: ImageSource.gallery);
                      Get.back();
                      XFile? xfile = await compressImage(File(pickedImage!.path));
                      onBack(xfile);
                    },
                    child: Text(
                      "Choose From Library",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () async {
                      final picker = ImagePicker();

                      pickedImage = await picker.pickImage(source: ImageSource.camera);
                      Get.back();
                      XFile? xfile = await compressImage(File(pickedImage!.path));
                      onBack(xfile);
                    },
                    child: Text(
                      "Take Photo",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          )),
      isDismissible: true,
    );
  }

  static Future<XFile?> compressImage(File originalImage) async {
    final targetPath = originalImage.path;
    final directory = originalImage.parent; // Get the parent directory of the original image
    final fileName = 'compressed_${originalImage.uri.pathSegments.last}'; // Create a new filename
    final compressedPath = '${directory.path}/$fileName.jpg'; // Ensure it ends with .jpg

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      targetPath,
      compressedPath,
      quality: 50,
    );

    if (compressedImage != null) {
      return XFile(compressedImage.path);
    } else {
      // Compression failed, handle the error
      return null;
    }
  }
}
