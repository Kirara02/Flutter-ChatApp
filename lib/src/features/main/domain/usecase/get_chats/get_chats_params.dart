import 'package:dio/dio.dart';

class GetChatsParams {
  final String? type;
  final bool includeMembers;
  final bool showEmpty;
  final CancelToken? cancelToken;

  GetChatsParams({
    this.type,
    this.includeMembers = false,
    this.showEmpty = false,
    this.cancelToken,
  });
}
