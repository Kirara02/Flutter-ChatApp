import 'package:dio/dio.dart';

class CreateRoomParams {
  final String name;
  final List<int> userIds;
  final CancelToken? cancelToken;

  CreateRoomParams({
    required this.name,
    required this.userIds,
    this.cancelToken,
  });
}
