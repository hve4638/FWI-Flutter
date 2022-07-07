import 'package:wininfo/foregroundwindowinfo/trace_logger.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import '/timer/intervalevent.dart';
import '/timer/timerevent.dart';
import 'foreground_window_info.dart';
import 'windowinfo/windowinfo.dart';
import 'trace_logger.dart';
import 'package:wininfo/fwiconfig/fwi_config_readonly.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';

class ForegroundWindowTracer {
  ForegroundWindowTracer({
    required this.config,
    required this.aliasDictionary,
    required this.ignoreProcesses,
  });
  final FwiConfigReadonly config;
  final AliasDictionary aliasDictionary;
  final IgnoreProcessSet ignoreProcesses;
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

    tracer.start(config.traceUpdateTime, _trace);
  }

  _trace() async {
    var wInfo = WindowInfoLazy();

    if (_isIgnoreProcess(wInfo)) {
      _info.setTime( time: _time );
    } else {
      _info.set(
        title: wInfo.title,
        name: wInfo.name,
        time: _time,
        alias: aliasDictionary[wInfo.name],
        date: DateTime.now(),
      );

      var _isChanged = _info.actualName != wInfo.name;
      if (_isChanged) {
        _lastChanged = DateTime.now();
        logger.add(_info);
      }
    }

    wInfo.dispose();
  }

  _isIgnoreProcess(windowInfo) {
    var _isUnknown = windowInfo.name == "unknown";
    var _isForeground = _appPointer == windowInfo.pointer;
    var _isIgnore = ignoreProcesses.contains(windowInfo.name);

    return _isUnknown || _isForeground || _isIgnore;
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

