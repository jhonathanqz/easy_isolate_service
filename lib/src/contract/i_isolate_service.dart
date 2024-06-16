import 'dart:async';
import 'dart:isolate';

abstract class IISolateService {
  Future<R> run<R>(FutureOr<R> Function() function);

  Future<T> spawn<T>(FutureOr<T> Function(SendPort sendPort) function);

  Future<T> spawnParse<T>(Function(SendPort port) call);

  Future<T> computeParse<T>(FutureOr<T> Function(dynamic) call, dynamic response);

  Future<bool> kill(Isolate isolate);

  Future<bool> exit();
}
