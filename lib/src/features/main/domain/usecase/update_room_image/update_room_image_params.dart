import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UpdateRoomImageParams {
  final int roomId;
  final XFile file;
  final CancelToken? cancelToken;

  UpdateRoomImageParams({
    required this.roomId,
    required this.file,
    this.cancelToken,
  });
}

