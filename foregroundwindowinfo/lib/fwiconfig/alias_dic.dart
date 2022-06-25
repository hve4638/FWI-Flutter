import 'dart:convert';
import 'dart:io';

class AliasDictionary {
  Map<String, dynamic> map = {};
  final String filename;
  AliasDictionary(this.filename);

  String? operator[](String processName) {
    var alias = map[processName];

    return map[processName];
  }

  operator[]=(String processName, String alias) {
    map[processName] = alias;
  }

  toList() {
    var list = <KeyValueTuple>[];
    for (final String key in map.keys) {
      list.add( KeyValueTuple(key, map[key] as String) );
    }

    return list;
  }

  remove(String processName) {
    map.remove(processName);
  }

  save() async {
    var file = File(filename);
    var jsonString = jsonEncode(map);

    file.writeAsString(jsonString);
  }

  load() async {
    var file = File(filename);

    if (file.existsSync()) {
      var jsonString = await file.readAsString();
      map = jsonDecode(jsonString);
    }
  }
}

class KeyValueTuple {
  KeyValueTuple([this.key="", this.value=""]);
  String key;
  String value;
}