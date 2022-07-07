import 'dart:io';

class IgnoreProcessSet {
  final _set = <String>{};
  final String filename;

  IgnoreProcessSet(this.filename);

  add(String name) {
    return _set.add(name);
  }

  remove(String name) {
    return _set.remove(name);
  }

  contains(String name) {
    return _set.contains(name);
  }

  get length => _set.length;

  toList() {
    var sorted = _set.toList();
    sorted.sort();

    return sorted;
  }

  save() async {
    var file = File(filename);

    var result = "";
    var lines = toList();
    for(var name in lines) {
      result += name + "\n";
    }

    file.writeAsString(result);
  }

  load() async {
    var file = File(filename);

    _set.clear();
    if (file.existsSync()) {
      var lines = await file.readAsLines();
      for(var name in lines) {
        _set.add(name);
      }
    }
  }
}