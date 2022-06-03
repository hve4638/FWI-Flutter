import 'package:wininfo/tracelog.dart';

import '/timer/intervalevent.dart';
import '/timer/timerevent.dart';
import 'foregroundwindowinfo.dart';
import 'windowinfo.dart';
import '/tracelog.dart';

class ForegroundWindowTracer {
  final _info = ForegroundWindowInfo();
  final save = TraceLog("test.txt");
  var tracer = IntervalEvent();
  var counter = TimerEvent();
  var _isRunning = false;
  dynamic _appPointer;

  start() {
    _appPointer = WindowInfoLazy().pointer;

    counter.start(500, (timer) {
      _info.time = timer.getTime();
    });
    tracer.start(500, () async {
      var winfo = WindowInfoLazy();
      var _isForeground = _appPointer == winfo.pointer;
      var _isChanged = _info.name != winfo.name;

      if (!_isForeground) {
        _info.name = winfo.name;
        _info.title = winfo.title;
        _info.path = winfo.path;

        if (_isChanged) {
          save.add(_info.title, _info.name, _info.time);
        }
      }

      winfo.dispose();
    });

    _isRunning = true;
  }

  stop() {
    counter.stop();
    tracer.stop();

    _isRunning = false;
  }

  isRunning() => _isRunning;
  info() => _info;
}

