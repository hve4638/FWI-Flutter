import 'dart:convert';
import 'package:csv/csv.dart';
import 'dart:io';

import './alias_dictionary.dart';
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

  AliasDictionary get aliases => _aliasDictionary!;
  IgnoreProcessSet get ignoreProcesses => _ignoreProcessSet!;
  FwiConfigManager get fwiConfig => _fwiConfigManager!;

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

class GlobalText {
  GlobalText._constructor();

  static final _inst = GlobalText._constructor();

  factory GlobalText() {
    return _inst;
  }

  final _dict = <String, String>{};

  load(String filename) async {
    var input = File('./language/$filename').openRead();
    var column = await input.transform(utf8.decoder).transform(const CsvToListConverter()).toList();

    _dict.clear();
    for(var row in column) {
      if (row.length < 2) {
        continue;
      } else if (row[0] == "") {
        continue;
      } else {
        _dict[row[0]] = row[1];
      }
    }
  }

  String operator[](String key) {
    return _dict[key] ?? key;
  }
}






