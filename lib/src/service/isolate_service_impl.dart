import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

import '../contract/i_isolate_service.dart';

class IsolateServiceImpl implements IISolateService {
  int _isolateRunning = 0;
  static const int _blockIsolate = 5;

  @override
  Future<R> run<R>(FutureOr<R> Function() function) async {
    try {
      if (_isolateRunning > _blockIsolate) return Future.value(null);
      _isolateRunning++;
      final result = await Isolate.run<R>(function);
      _isolateRunning--;
      return result;
    } catch (e) {
      _isolateRunning--;
      rethrow;
    }
  }

  @override
  Future<T> spawn<T>(FutureOr<T> Function(SendPort sendPort) function) async {
    if (_isolateRunning > _blockIsolate) return Future.value(null);
    _isolateRunning++;
    try {
      final receivePort = ReceivePort();
      final isolate = await Isolate.spawn(
        function,
        receivePort.sendPort,
        onExit: receivePort.sendPort,
        onError: receivePort.sendPort,
      );
      final completer = Completer<T>();
      receivePort.listen((message) {
        if (message is T) {
          completer.complete(message);
        } else {
          completer.completeError(message);
        }
        receivePort.close();
        isolate.kill();
      });
      _isolateRunning--;
      return completer.future;
    } catch (e) {
      _isolateRunning--;
      rethrow;
    }
  }

  @override
  Future<T> spawnParse<T>(Function(SendPort port) call) async {
    if (_isolateRunning > _blockIsolate) return Future.value(null);
    _isolateRunning++;
    try {
      final receivePort = ReceivePort();
      final isolate = await Isolate.spawn(call, receivePort.sendPort);
      final result = await receivePort.first;
      receivePort.close();
      isolate.kill();
      _isolateRunning--;
      return result;
    } catch (e) {
      _isolateRunning--;
      rethrow;
    }
  }

  @override
  Future<T> computeParse<T>(FutureOr<T> Function(dynamic) call, dynamic response) async {
    if (_isolateRunning > _blockIsolate) return Future.value(null);
    try {
      _isolateRunning++;
      final result = await compute(call, response);
      _isolateRunning--;
      return result;
    } catch (e) {
      _isolateRunning--;
      rethrow;
    }
  }

  @override
  Future<bool> kill(Isolate isolate) async {
    try {
      if (_isolateRunning > _blockIsolate) return Future.value(false);

      isolate.kill();
      return true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> exit() async {
    try {
      if (_isolateRunning > _blockIsolate) return Future.value(false);
      Isolate.exit();
    } catch (_) {
      rethrow;
    }
  }
}
