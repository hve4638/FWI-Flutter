import 'dart:io';
import 'package:test/test.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  test('testRead', () async {
    var lpath = _asyncLocalPath;

    print("a");
    Future.wait([lpath]);
    print("b");
    return 0;
    var path = "$lpath\\abc.ini";
    var file = File(path);

    print("read $path");
    var ls = await file.readAsLines();
    for(var i in ls) {
      print("> $i");
    }
  });
}

Future<String> get _asyncLocalPath async {
  final directory = await getApplicationDocumentsDirectory();
  print("c");
  return directory.path;
}