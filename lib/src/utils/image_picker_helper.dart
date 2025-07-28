import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xchat/src/constants/colors.dart';

class ImagePickerHelper {
  final ImagePicker _picker = ImagePicker();

  // Combine pick, crop, and compress in one function
  Future<File?> pickAndProcessImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return null;

    // Crop the image
    final croppedFile = await _cropImage(File(pickedFile.path));
    if (croppedFile == null) return null;

    // Compress the image
    return await _compressImage(croppedFile);
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    return await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      maxWidth: 800,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.dark,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          doneButtonTitle: 'Done',
          cancelButtonTitle: 'Cancel',
          resetAspectRatioEnabled: false,
        ),
      ],
    );
  }

  Future<File?> _compressImage(CroppedFile croppedFile) async {
    final result = await FlutterImageCompress.compressWithFile(
      croppedFile.path,
      minWidth: 800,
      minHeight: 600,
      quality: 75,
      rotate: 0,
      format: CompressFormat.jpeg,
    );

    if (result != null) {
      return File(croppedFile.path)..writeAsBytesSync(result);
    }
    return null;
  }
}
