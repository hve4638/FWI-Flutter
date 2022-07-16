import 'package:test/test.dart';
import '../../lib/foregroundwindowinfo/log/timeline_log.dart';
import '../../lib/foregroundwindowinfo/foreground_window_info.dart';
/*
void main() {
  test('TraceWidgetList.toList', () { // 어떤 테스트를 할지 설명하고,안에 있는 테스트를 실행합니다.
    LogList wlist = LogList();

    for(var i=0; i<8; i++) {
      wListAddInfo(wlist, "$i");
    }

    dynamic _res = wlist.toList(0, 3);
    expectInfoArray(_res, [0, 1, 2]);

    _res = wlist.toList(2, 5);
    expectInfoArray(_res, [2, 3, 4, 5, 6]);

    _res = wlist.toList(4, 10);
    expectInfoArray(_res, [4, 5, 6, 7]);
  });
}

wListAddInfo(wlist, title) {
  var _info = ForegroundWindowInfo();
  _info.title = title;
  wlist.add(_info);
}

expectInfoArray(List infoArray, List stringArray) {
  var expected = infoArray;
  var actual = stringArray;
  expect(expected.length, actual.length);

  for(var i=0; i<actual.length; i++) {
    expect(expected[i].title, "${actual[i]}");
  }
}*/