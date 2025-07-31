import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileParams {
  final String? name;
  final String? email;
  final XFile? profileImage;
  final CancelToken? cancelToken;

  UpdateProfileParams({
    this.name,
    this.email,
    this.cancelToken,
    this.profileImage,
  });
}
