import 'package:flutter/foundation.dart';

void printIfDebug(dynamic data) {
  if (kDebugMode) {
    print(data);
  }
}
