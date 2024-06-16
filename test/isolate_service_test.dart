import 'package:flutter_test/flutter_test.dart';

import 'package:easy_isolate_service/isolate_service.dart';

void main() {
  test('adds one to input values', () {
    IsolateService.instance.spawn((sendPort) => null);
  });
}
