import 'dart:io';
import 'dart:async';

class CrashReporter {
  CrashReporter._constructor();

  static final _inst = CrashReporter._constructor();

  factory CrashReporter() {
    return _inst;
  }

  String path = ".";
  String fileName = "error_log.txt";

  get currentTime {
    var date = DateTime.now();

    return "[${date.month}/${date.day} ${date.hour}:${date.minute}:${date.second}]";
  }

  setPath(String path) {
    this.path = path;
  }

  setFileName(String fileName) {
    this.fileName = fileName;
  }

  write([String contents=""]) {
    var file = File("$path/$fileName");
    file.writeAsStringSync(contents, mode: FileMode.append);
  }

  writeLine([String contents=""]) {
    write("$contents\n");
  }

  writeException(Exception exception) {
    write("$currentTime ");
    write(exception.toString());
    writeLine();
  }

  handler({
    required void Function() run
  }) {
    runZoned<Future<void>>(
      () async { run(); },
      onError: (dynamic error, StackTrace stackTrace) {
        writeLine("Exception!");
        writeLine(error.toString());
      }
    );
  }
}