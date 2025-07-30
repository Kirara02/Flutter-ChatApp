import 'package:dio/dio.dart';

class GetRoomByIdParams {
  final int roomId;
  final CancelToken? cancelToken;

  GetRoomByIdParams({required this.roomId, this.cancelToken});
}
