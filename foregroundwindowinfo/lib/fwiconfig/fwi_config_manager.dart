import 'package:wininfo/json_io.dart';

class FwiConfigManager with JsonIO {
  final Map<String, String> _data = {};

  String _fileName = "";

  FwiConfigManager(name) {
    _fileName = name;
  }

  int get traceUpdateDuration => _dataTryParseInt("traceUpdateDuration") ?? 500;
  int get timelineUpdateDuration => _dataTryParseInt("timelineUpdateDuration") ?? 1000;
  int get rankUpdateDuration => _dataTryParseInt("rankUpdateDuration") ?? 1000;
  int get timelineWriteDuration => _dataTryParseInt("timelineWriteDuration") ?? 1;

  _dataTryParseInt(String key) {
    var value = _data[key];
    if (value == null) {
      return null;
    } else {
      return int.tryParse(value);
    }
  }

  set traceUpdateDuration(int value) => _data["traceUpdateDuration"] = value.toString();
  set timelineUpdateDuration(int value) => _data["timelineUpdateDuration"] = value.toString();
  set rankUpdateDuration(int value) => _data["rankUpdateDuration"] = value.toString();
  set timelineWriteDuration(int value) => _data["timelineWriteDuration"] = value.toString();

  save() {
    print("save?");
    saveJson(_fileName, contents: _data);
  }

  load() {
    var _map = loadJson(_fileName);

    if (_map != null) {
      _data.clear();

      _map.forEach((key, value) {
        _data[key] = value;
      });
    }
  }
}




