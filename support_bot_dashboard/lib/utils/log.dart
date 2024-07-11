import 'package:logger/logger.dart';

class Log {
  static Logger logger = Logger();

  static void verbose(String message, [dynamic error]) {
    logger.v(message, error);
  }

  static void debug(String message, [dynamic error]) {
    logger.d(message, error);
  }

  static void info(String message, [dynamic error]) {
    logger.i(message, error);
  }

  static void warning(String message, [dynamic error]) {
    logger.w(message, error);
  }

  static void error(String message, [dynamic error]) {
    logger.e(message, error);
  }

  static void failure(String message, [dynamic error]) {
    logger.wtf(message, error);
  }
}
