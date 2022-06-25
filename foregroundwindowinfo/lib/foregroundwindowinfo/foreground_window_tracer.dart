import 'package:wininfo/foregroundwindowinfo/trace_logger.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import '/timer/intervalevent.dart';
import '/timer/timerevent.dart';
import 'foreground_window_info.dart';
import 'windowinfo/windowinfo.dart';
import 'trace_logger.dart';
import 'package:wininfo/fwiconfig/fwi_config_readonly.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

class ForegroundWindowTracer {
  ForegroundWindowTracer({
    required this.config,
    required this.aliasDictionary
  });
  final FwiConfigReadonly config;
  final AliasDictionary aliasDictionary;
  final _info = ForegroundWindowInfo();
  final logger = TraceLogger("test.txt");
  String _time = "00:00:00";
  var tracer = IntervalEvent();
  var counter = TimerEvent();
  var _lastChanged = DateTime.now();
  dynamic _appPointer;
  DateTime get lastChanged => _lastChanged;
  String get time => _time;

  testPush() {
    var _t = ForegroundWindowInfo();
    for(var i=0; i<10000; i++) {
      _t.set(
        title: "test",
        name: "Count: $i",
        time: "00:00",
        date: DateTime.now(),
      );
      logger.add(_t);
    }
  }

  start() {
    logger.start();
    _appPointer = WindowInfoLazy().pointer;

    counter.start(200, (timer) {
      _time = timer.getTime();
    });

    _info.isRunning = true;

    tracer.start(config.traceUpdateTime, () async {
      var winfo = WindowInfoLazy();
      var _isForeground = _appPointer == winfo.pointer;
      var _isChanged = _info.actualName != winfo.name;

      if (winfo.name == "unknown") {

      } else if (!_isForeground) {
        _info.set(
          title: winfo.title,
          name: winfo.name,
          time: _time,
          alias: aliasDictionary[winfo.name],
          date: DateTime.now(),
        );

        if (_isChanged) {
          _lastChanged = DateTime.now();
          logger.add(_info);
        }
      }
      else {
        _info.set( time: _time );
      }

      winfo.dispose();
    });
  }

  stop() {
    logger.stop();
    counter.stop();
    tracer.stop();

    _info.isRunning = false;
  }

  isRunning() => _info.isRunning;
  info() => _info;
}

