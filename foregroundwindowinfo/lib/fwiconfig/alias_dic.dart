import 'dart:convert';
import 'dart:io';

class AliasDictionary {
  Map<String, dynamic> map = {};
  final _noAliases = NoAliasDictionary();
  final String filename;
  NoAliasDictionary get noAlias {
    return _noAliases;
  }
  AliasDictionary(this.filename);

  String? operator[](String name) {
    if (map.containsKey(name)) {
      return map[name];
    } else {
      _noAliases.add(name);

      return null;
    }
  }

  operator[]=(String name, String alias) {
    map[name] = alias;

    if (_noAliases.contains(name)) {
      _noAliases.remove(name);
    }
  }

  toList() {
    var list = <KeyValueTuple>[];
    for (final String key in map.keys) {
      list.add( KeyValueTuple(key, map[key] as String) );
    }

    return list;
  }

  remove(String name) {
    map.remove(name);
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

  forEach(Function(String, dynamic) callback) {
    return map.forEach(callback);
  }
}

class NoAliasDictionary {
  final Set<String> _noAlias = {};
  NoAliasDictionary();

  get raw => _noAlias;

  bool add(name) {
    return _noAlias.add(name);
  }

  remove(String name) {
    _noAlias.remove(name);
  }

  bool contains(name) {
    return _noAlias.contains(name);
  }

  toList() {
    var lines = _noAlias.toList();
    lines.sort();

    var list = <String>[];
    for (var key in lines) {
      list.add(key);
    }

    return list;
  }

  forEach(Function(String) callback) {
    return _noAlias.forEach(callback);
  }
}

class KeyValueTuple {
  KeyValueTuple([this.key="", this.value=""]);
  String key;
  String value;
}