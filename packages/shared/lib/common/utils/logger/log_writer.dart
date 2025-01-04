import 'package:shared/core/architecture/domain/entity/failure.dart';
import 'package:surf_logger/surf_logger.dart' as surf_logger;

import 'i_log_writer.dart';

/// {@template log_writer.class}
/// Implementation of [ILogWriter].
/// {@endtemplate}
final class LogWriter implements ILogWriter {
  final surf_logger.LogWriter _logWriter;

  /// {@macro log_writer.class}
  const LogWriter(this._logWriter);

  @override
  void log(String message) {
    _logWriter.log(message);
  }

  @override
  void exception(Object exception, [StackTrace? stackTrace]) {
    _logWriter.e(exception, stackTrace);
  }

  @override
  void failure(Failure failure) {
    _logWriter.e(failure.original ?? failure, failure.trace);
  }
}
