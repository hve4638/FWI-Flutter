import 'dart:io';
//import 'package:path_provider/path_provider.dart';

class TraceLog {
  File ?file;

  TraceLog(name) {
    file = File("log/$name");
  }

  add(String title, String name, String date) async {
    title = title.replaceAll("\n", "");
    await file?.writeAsString("$date|$name|$title\n", mode: FileMode.append);
  }
}