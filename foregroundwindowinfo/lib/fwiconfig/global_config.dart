import 'dart:convert';
import 'dart:io';
import './alias_dic.dart';
import './fwi_config_manager.dart';
import './ignore_process_set.dart';

class GlobalConfig {
  GlobalConfig._constructor();

  static final _inst = GlobalConfig._constructor();

  Map<String, dynamic> _data = {};

  factory GlobalConfig() {
    return _inst;
  }

  AliasDictionary? _aliasDictionary;
  IgnoreProcessSet? _ignoreProcessSet;
  FwiConfigManager? _fwiConfigManager;

  setAliasDictionary(AliasDictionary aliasDictionary) {
    _aliasDictionary = aliasDictionary;
  }

  setIgnoreProcess(IgnoreProcessSet ignoreProcess) {
    _ignoreProcessSet = ignoreProcess;
  }

  setFwiConfig(FwiConfigManager fwiConfig) {
    _fwiConfigManager = fwiConfig;
  }

  get aliases => _aliasDictionary!;
  get ignoreProcesses => _ignoreProcessSet!;
  get fwiConfig => _fwiConfigManager!;

  save(String filename) async {
    var file = File(filename);
    var jsonString = jsonEncode(_data);

    file.writeAsString(jsonString);
  }

  load(String filename) async {
    var file = File(filename);

    if (file.existsSync()) {
      var jsonString = await file.readAsString();

      var _map = _tryGetJsonDecode(jsonString);
      if (_map != null) {
        _data = _map;
      }
    }
  }

  _tryGetJsonDecode(String jsonString) {
    try {
      return jsonDecode(jsonString);
    }
    on FormatException {
      return null;
    }
  }
}