import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/serializable.dart';

class ApiResponse<T> extends MapSerializable {
  ApiResponse.fromMap(super.map, {T Function(dynamic json)? fromJsonT})
    : _dataFactory = fromJsonT,
      super.fromMap();

  final T Function(dynamic json)? _dataFactory;

  bool get success => this['success'] ?? false;
  String get message => this['message'] ?? '';
  Meta? get meta => this['meta'] != null ? Meta.fromMap(this['meta']) : null;
  ErrorData? get error =>
      this['error'] != null ? ErrorData.fromMap(this['error']) : null;

  T? get data {
    final raw = this['data'];
    if (raw == null || _dataFactory == null) return null;
    return _dataFactory(raw);
  }
}

class Meta extends MapSerializable {
  Meta.fromMap(super.map) : super.fromMap();

  String get timestamp => this['timestamp'];
  String? get path => this['path'];
  int? get total => this['total'];
  int? get page => this['page'];
  int? get limit => this['limit'];
  int? get totalPages => this['total_pages'];
  String? get localTime => this['local_time'];
}

class ErrorData extends MapSerializable {
  ErrorData.fromMap(super.map) : super.fromMap();

  int get code => this['code'];
  String get details => this['details'];
}

extension ApiResponseToResult<T> on ApiResponse<T> {
  Result<T> toResult() {
    if (success && data != null) {
      final nonNullData = data as T;
      return Result.success(nonNullData, meta: meta);
    } else {
      return Result.failed(message, code: error?.code);
    }
  }
}
