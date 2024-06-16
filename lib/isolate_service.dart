library isolate_service;

import 'src/service/isolate_service_impl.dart';

class IsolateService {
  static IsolateServiceImpl? _isolateService;

  static IsolateServiceImpl get instance {
    _isolateService ??= IsolateServiceImpl();
    return _isolateService!;
  }
}
