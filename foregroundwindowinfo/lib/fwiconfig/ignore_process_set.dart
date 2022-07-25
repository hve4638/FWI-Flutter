import 'dart:io';

class IgnoreProcessSet {
  final _caseData = <String>{};
  final _data = <String>{};
  final String filename;

  IgnoreProcessSet(this.filename);

  add(String name) {
    _caseData.add(name.toLowerCase());
    return _data.add(name);
  }

  remove(String name) {
    _caseData.remove(name.toLowerCase());
    return _data.remove(name);
  }

  contains(String name, { bool matchCase = false }) {
    if (matchCase) {
      return _data.contains(name);
    } else {
      return _caseData.contains(name.toLowerCase());
    }
  }

  clear() {
    _caseData.clear();
    _data.clear();
  }

  get length => _data.length;

  toList() {
    var sorted = _data.toList();
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

    clear();
    if (file.existsSync()) {
      var lines = await file.readAsLines();
      for(var name in lines) {
        add(name);
      }
    }
  }
}

