import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _log('CREATE', bloc.runtimeType);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log('CHANGE', bloc.runtimeType, change: change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log('ERROR', bloc.runtimeType, error: error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _log('CLOSE', bloc.runtimeType);
  }

  // Private method for logging with improved details
  void _log(String event, Type blocType, {Object? error, Change? change}) {
    if (kDebugMode) {
      final blocName =
          blocType.toString().split('.').last; // Simplify the type name

      final logBuffer = StringBuffer()..write('[$event] [$blocName]');

      if (error != null) {
        logBuffer.write(' - Error: ${_formatError(error)}');
      }

      if (change != null) {
        logBuffer.write(' - Change: $change');
      }

      print(logBuffer.toString());
    }
  }

  // Format error object to be more user-friendly
  String _formatError(Object error) {
    if (error is Error) {
      return error.toString(); // For general Dart errors
    } else if (error is Exception) {
      return error.toString(); // For exceptions
    } else {
      return 'Unexpected error type: ${error.runtimeType}';
    }
  }
}
