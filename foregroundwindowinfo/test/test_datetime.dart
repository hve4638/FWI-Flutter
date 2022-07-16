import 'package:test/test.dart';

void main() {
  test('testIntervalSecond', () {
    var index = 0;
    var last = DateTime.now();

    while(index < 5) {
      var now = DateTime.now();

      if (last.second != now.second || last.minute != now.minute) {
        last = now;
        index++;
      }
    }
  }, timeout: const Timeout(Duration(seconds: 10)));
}