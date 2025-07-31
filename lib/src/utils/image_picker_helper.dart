import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:xchat/src/constants/colors.dart';

class ImagePickerHelper {
  final ImagePicker _picker = ImagePicker();

  /// Returns XFile (web/mobile) or Uint8List (web cropped)
  Future<XFile?> pickAndProcessImage({required ImageSource source}) async {
    final picked = await _picker.pickImage(source: source);
    if (picked == null) return null;

    if (kIsWeb) {
      return picked;
    }

    final cropped = await _cropImage(picked.path);
    if (cropped == null) return null;

    return _compressImage(cropped.path);
  }

  Future<CroppedFile?> _cropImage(String path) async {
    return await ImageCropper().cropImage(
      sourcePath: path,
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

  Future<XFile?> _compressImage(String path) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      "$path-compressed.jpg",
      minWidth: 800,
      minHeight: 600,
      quality: 75,
    );

    if (result != null) return XFile(result.path);
    return null;
  }
}
