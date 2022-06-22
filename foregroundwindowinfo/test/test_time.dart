import 'package:test/test.dart';

void main() {
  test('test', () {
    var sec = 60 * 10;


    for(var i = 0; i < 60; i++) {
      for(var j = 0; j < 60; j++) {
        for(var k = 0; k < 60; k++) {
          expectSeconds(i, j, k);
        }
      }
    }
  });
}

expectSeconds(hours, minutes, seconds) {
  var sec = hours*3600 + minutes*60 + seconds;

  expect(hours, sec ~/ 3600);
  expect(minutes, sec % 3600 ~/ 60);
  expect(seconds, sec % 60);
}