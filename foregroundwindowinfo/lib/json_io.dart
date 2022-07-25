import 'dart:convert';
import 'dart:io';

mixin JsonIO {
  saveJson(String filename, {
    required Map<String, dynamic> contents,
  }) {
    var file = File(filename);
    var jsonString = jsonEncode(contents);

    file.writeAsStringSync(jsonString);
  }

  Map<String, dynamic>? loadJson(String filename) {
    var file = File(filename);

    if (file.existsSync()) {
      var jsonString = file.readAsStringSync();

      return _tryGetJsonDecode(jsonString);
    }

    return null;
  }

  Map<String, dynamic>? _tryGetJsonDecode(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } on FormatException {
      return null;
    }
  }
}