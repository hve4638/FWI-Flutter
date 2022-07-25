import '../json_io.dart';

class AliasDictionary with JsonIO {
  final _noCaseData = <String, dynamic>{};
  final _data = <String, dynamic>{};
  final _noAliases = NoAliasDictionary();
  final String filename;

  NoAliasDictionary get noAlias => _noAliases;

  AliasDictionary(this.filename);

  String? operator[](String name) {
    if (containsKey(name)) {
      return _data[name];
    } else {
      return null;
    }
  }

  String? getAliasIfExistsOrAddNoAliases(String name) {
    if (containsKey(name)) {
      return _data[name];
    } else {
      _noAliases.add(name);

      return null;
    }
  }

  operator[]=(String name, String alias) {
    add(name, alias);
  }

  bool containsKey(String name) {
    return _noCaseData.containsKey(name.toLowerCase());
  }

  toList() {
    var list = <KeyValueTuple>[];
    for (final String key in _data.keys) {
      list.add( KeyValueTuple(key, _data[key] as String) );
    }

    return list;
  }

  add(String name, String alias) {
    print("$name $alias");
    _noCaseData[name.toLowerCase()] = alias;
    _data[name] = alias;

    if (_noAliases.contains(name)) _noAliases.remove(name);
  }

  remove(String name) {
    _noCaseData.remove(name.toLowerCase());
    _data.remove(name);
  }

  clear() {
    _noCaseData.clear();
    _data.clear();
  }

  save() {
    print("save!");
    saveJson(filename, contents: _data);
  }

  load() {
    print("load!");
    var _map = loadJson(filename);

    if (_map != null) {
      _map.forEach((name, alias) {
        add(name, alias);
      });
    }
  }

  forEach(Function(String, dynamic) callback) {
    return _data.forEach(callback);
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