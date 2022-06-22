import '../lib/fwiconfig/fwi_config.dart';
import 'package:test/test.dart';

void main() {
  test('testSave', () { return 0;
    var setting = FwiConfig("testsave.ini");

    setting.traceTime = 1234;
    setting.save();
  });

  test('testLoad', () async {
    var setting = FwiConfig("testsave.ini");

    await setting.load();
    print("#${setting.traceTime}");
    print("#${setting.timelineUpdateTime}");
    print("#${setting.rankUpdateTime}");
  });
}