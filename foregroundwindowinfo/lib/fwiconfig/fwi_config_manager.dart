import 'dart:io';
import "package:ini/ini.dart";
import "fwi_config.dart";
import "fwi_config_readonly.dart";

class FwiConfigManager implements FwiConfig {
  FwiConfigManager(name) {
    _fileName = name;
  }

  String _fileName = "";
  int _traceUpdateTime = 500;
  int _timelineUpdateTime = 1000;
  int _rankUpdateTime = 1000;

  @override
  int get traceUpdateTime => _traceUpdateTime;
  @override
  int get timelineUpdateTime => _timelineUpdateTime;
  @override
  int get rankUpdateTime => _rankUpdateTime;

  @override
  set traceUpdateTime(int value) {
    _traceUpdateTime = value;
  }
  @override
  set timelineUpdateTime(int value) {
    _timelineUpdateTime = value;
  }
  @override
  set rankUpdateTime(int value) {
    _rankUpdateTime = value;
  }

  @override
  FwiConfigReadonly get readonly {
    return FwiConfigReadonly(this);
  }

  @override
  save() async {
    var config = makeConfig();

    var file = await _getFile();
    file.writeAsString(config.toString());
  }

  Config makeConfig() {
    var config = Config();

    config.addSection("updatetime");
    config.set("updatetime", "trace", "$_traceUpdateTime");
    config.set("updatetime", "timeline", "$_timelineUpdateTime");
    config.set("updatetime", "rank", "$_rankUpdateTime");

    return config;
  }

  @override
  load() async {
    var file = await _getFile();

    if (file.existsSync()) {
      var lines = await file.readAsLines();
      var config = Config.fromStrings(lines);
      loadOption(config);
    }
  }

  Future<File> _getFile() async {
    return File(_fileName);
  }

  loadOption(Config ?config) {
    int getUpdateTime(option, int def) {
      var value = _getOption(config, "updatetime", option);

      return int.tryParse("$value") ?? -1;
    }

    _traceUpdateTime = getUpdateTime("trace", 200);
    _timelineUpdateTime = getUpdateTime("timeline", 1000);
    _rankUpdateTime = getUpdateTime("rank", 1);
  }

  String? _getOption(Config? config, String section, String option) {
    if (config != null && config.hasOption(section, option)) {
      return config.get(section, option);
    } else {
      return null;
    }
  }
}




