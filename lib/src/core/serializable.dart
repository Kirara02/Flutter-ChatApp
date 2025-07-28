import 'dart:convert';

abstract class Serializable {

  const Serializable();

  Map<String, dynamic> toMap();

  @override
  String toString() => jsonEncode(toMap(),);

  String toStringPretty() => const JsonEncoder.withIndent('\t',)
      .convert(toMap(),);
}

abstract class MapSerializable extends Serializable {
  const MapSerializable.fromMap(Map<String, dynamic> data)
      : _internal = data;

  final Map<String, dynamic> _internal;

  @override
  Map<String, dynamic> toMap() => Map.of(_internal);

  dynamic operator [](String key) {
    final data = _internal[key];
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is List) return List.of(data);
    return data;
  }

  T getNested<T>(String key, T Function(Map<String, dynamic>) parser) {
    final value = _internal[key];
    if (value == null) {
      throw Exception('Missing key: $key');
    }
    if (value is Map<String, dynamic>) return parser(value);
    if (value is Map) return parser(Map<String, dynamic>.from(value));
    throw Exception('Invalid nested map for key: $key');
  }

  List<T> getNestedList<T>(
    String key,
    T Function(Map<String, dynamic>) parser,
  ) {
    final value = _internal[key];
    if (value == null || value is! List) return <T>[];

    return value.map((e) {
      if (e is Map<String, dynamic>) return parser(e);
      if (e is Map) return parser(Map<String, dynamic>.from(e));
      throw Exception('Invalid item in list at key: $key');
    }).toList();
  }
}
