import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

import '../contract/i_isolate_service.dart';

class IsolateServiceImpl implements IISolateService {
  @override
  Future<R> run<R>(FutureOr<R> Function() function) async {
    try {
      final result = await Isolate.run<R>(function);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<T> spawn<T>(FutureOr<T> Function(SendPort sendPort) function) async {
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
    return completer.future;
  }

  @override
  Future<T> spawnParse<T>(Function(SendPort port) call) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(call, receivePort.sendPort);
    final result = await receivePort.first;
    receivePort.close();
    isolate.kill();
    return result;
  }

  @override
  Future<T> computeParse<T>(FutureOr<T> Function(dynamic) call, dynamic response) async {
    return await compute(call, response);
  }

  @override
  Future<bool> kill(Isolate isolate) async {
    try {
      isolate.kill();
      return true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> exit() async {
    try {
      Isolate.exit();
    } catch (_) {
      rethrow;
    }
  }
}
