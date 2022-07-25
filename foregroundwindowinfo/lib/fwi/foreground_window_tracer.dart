import 'package:fluent_ui/fluent_ui.dart';

import '../fwiconfig/global_config.dart';
import '/fwi/trace_logger.dart';
import '/timer/interval_event.dart';
import '/timer/timerevent.dart';
import '/fwiconfig/alias_dictionary.dart';
import '/fwiconfig/ignore_process_set.dart';

import 'fwi/fwi.dart';
import 'windowinfo/windowinfo.dart';
import './fwi_logger.dart';

import './log/rank_log.dart';
import './log/timeline_log.dart';

class ForegroundWindowTracer {
  static const timerUpdateTime = 100;

  final config = GlobalConfig();
  final rankLog = RankLog();
  final timelineLog = TimelineLog();

  final tracer = IntervalEvent();
  final counter = TimerEvent();
  final _info = FWI();

  var _lastChanged = DateTime.now();
  dynamic _appPointer;
  String _time = "00:00:00";

  Function(FWI info)? onChanged;
  FwiLogger? logger;

  ForegroundWindowTracer({
    this.onChanged,
  }) {
    logger = FwiLogger("test.txt",
      getCurrentTimeFormat : counter.getTimeFormat,
      foregroundWindowInfo: _info,
      timelineLog : timelineLog,
      rankLog : rankLog,
    );
  }

  List<Widget> Function() get getRankList => rankLog.toList;

  List<Widget> Function([int?, int?]) get getTimelineList => timelineLog.toList;

  DateTime get lastChanged => _lastChanged;

  String get time => _time;

  testPush() {
    var _t = FWI();
    for(var i=0; i<10; i++) {
      _t.set(
        title: "test",
        name: "Count: $i",
        time: "00:00",
        date: DateTime.now(),
      );
      logger?.add(_t);
    }
    return;
  }

  start() {
    _info.isRunning = true;
    _appPointer = WindowInfoLazy().pointer;

    logger?.start();
    tracer.start(config.fwiConfig.traceUpdateDuration, _trace);
    counter.start(timerUpdateTime, (timer) { _time = timer.getTimeFormat(); });

    if (timelineLog.firstDate == null) {
      timelineLog.setFirstDate(DateTime.now());
    }
  }

  _trace() async {
    var wInfo = WindowInfoLazy();

    if (_isIgnoreProcess(wInfo)) {
      _info.setTime( time: _time );
    } else {
      var _isChanged = _info.actualName != wInfo.name;
      _info.set(
        title: wInfo.title,
        name: wInfo.name,
        time: _time,
        alias: config.aliases.getAliasIfExistsOrAddNoAliases(wInfo.name),
        date: DateTime.now(),
      );

      if (_isChanged) {
        _lastChanged = DateTime.now();
        logger?.add(_info);

        if (onChanged != null) onChanged!(_info);
      }
    }

    wInfo.dispose();
  }

  _isIgnoreProcess(windowInfo) {
    var _isUnknown = windowInfo.name == "unknown";
    var _isForeground = _appPointer == windowInfo.pointer;
    var _isIgnore = config.ignoreProcesses.contains(windowInfo.name);

    return _isUnknown || _isForeground || _isIgnore;
  }

  stop() {
    _info.isRunning = false;
    _appPointer = null;

    logger?.stop();
    counter.stop();
    tracer.stop();
  }

  isRunning() => _info.isRunning;
  info() => _info;
}

