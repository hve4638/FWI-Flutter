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

  test('date interval',() {
    var st = DateTime.parse("2012-02-27 13:10:00");

    printDateInterval(st, DateTime.parse("2012-02-27 13:18:35"));
    printDateInterval(st, DateTime.parse("2012-02-27 13:28:30"));
  });
}

printDateInterval(DateTime source, DateTime other) {
  var dif = other.difference(source);

  print("source: $source");
  print("other : $other");
  print("> ${dif.inHours}:${dif.inMinutes % 60}:${dif.inSeconds % 60}");
}