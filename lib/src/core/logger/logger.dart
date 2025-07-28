import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as l;

class AppLogger {
  static final l.Logger _logger = l.Logger(
    printer: l.PrettyPrinter(
      errorMethodCount: 30,
      printEmojis: false,
      colors: false, // Disable colors for better logcat readability
      lineLength: 120,
      dateTimeFormat: l.DateTimeFormat.none,
    ),
    output: _MyConsoleOutput(),
  );

  const AppLogger._();

  static l.Logger get instance => _logger;
}

l.Logger get logger => AppLogger.instance;

class _MyConsoleOutput extends l.ConsoleOutput {
  @override
  void output(l.OutputEvent event) {
    for (var line in event.lines) {
      debugPrint(line);
    }
  }
}

extension LogExtension on Object {
  void logI() => logger.i(toString());
  void logE([Object? error, StackTrace? stackTrace]) =>
      logger.e(toString(), error: error, stackTrace: stackTrace);
}
