/// Logger utility for consistent logging across the app
import 'package:logger/logger.dart';
import '../../config/environment_config.dart';

final logger = AppLogger();

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();

  late Logger _logger;

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
      ),
      level: EnvironmentConfig.isDev ? Level.debug : Level.info,
    );
  }

  Logger get instance => _logger;

  void debug(String message) {
    _logger.d(message);
  }

  void info(String message) {
    _logger.i(message);
  }

  void warning(String message) {
    _logger.w(message);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void verbose(String message) {
    _logger.v(message);
  }

  void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error: error, stackTrace: stackTrace);
  }
}
