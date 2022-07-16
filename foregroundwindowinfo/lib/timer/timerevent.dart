import 'dart:async';

class TimerEvent {
  Timer? timer;
  bool _isRunning = false;
  int _interval = 1000;
  final Map _currentTime = {
    "hour" : 0,
    "min" : 0,
    "sec" : 0,
    "ms" : 0,
  };
  int get _hour => _currentTime["hour"];
  int get _min => _currentTime["min"];
  int get _sec => _currentTime["sec"];
  int get _ms => _currentTime["ms"];
  set _hour(int num) { _currentTime["hour"] = num; }
  set _min(int num) { _currentTime["min"] = num; }
  set _sec(int num) { _currentTime["sec"] = num; }
  set _ms(int num) { _currentTime["ms"] = num; }
  var interval = 1000;

  start(int interval, Function? callback) {
    _interval = interval;
    Function call = callback ?? (){};

    timer = Timer.periodic(Duration(milliseconds: _interval), (timer) {
      _currentTime["ms"] += _interval;
      _updatetime();

      call(this);
    });
    _isRunning = true;
  }

  void _updatetime() {
    if (_ms >= 1000) {
      _sec += _ms ~/ 1000;
      _ms = _ms % 1000;
    }
    if (_sec >= 60) {
      _min += _sec ~/ 60;
      _sec = _sec % 60;
    }
    if (_min >= 60) {
      _hour += _min ~/ 60;
      _min = _min % 60;
    }
  }

  stop() {
    timer?.cancel();
    _isRunning = false;
  }

  Map currentTime() {
    return Map.unmodifiable(_currentTime);
  }

  String getTimeFormat() {
    var _hour = _timeToString(_currentTime["hour"]);
    var _min = _timeToString(_currentTime["min"]);
    var _sec = _timeToString(_currentTime["sec"]);

    return "$_hour:$_min:$_sec";
  }

  String _timeToString(int num) {
    return (num >= 10) ? num.toString() : "0"+num.toString();
  }

  bool isRunning() {
    return _isRunning;
  }

  @Deprecated("use getTimeFormat")
  String getTime() {
    return getTimeFormat();
  }
}
