import 'package:test/test.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';
import 'package:wininfo/docu_path.dart';
import 'dart:io';

void main() {
  test('Load', () async {
    var path = await getTestFilePath();
    writeFile(path, "apple\napplication\n");

    var ips = IgnoreProcessSet(path);
    await ips.load();

    expect(true, ips.contains("apple"));
    expect(true, ips.contains("application"));
    expect(false, ips.contains("banana"));
  });

  test('Load Length', () async {
    var path = await getTestFilePath();
    writeFile(path, "apple\napplication\n");

    var ips = IgnoreProcessSet(path);
    await ips.load();

    expect(2, ips.length);
  });

  test('Save', () async{
    var path = await getTestFilePath();

    var ips = IgnoreProcessSet(path);
    ips.add("apple");
    ips.add("banana");
    await ips.save();

    expect("apple\nbanana\n", await readFile(path));
  });
}

getTestFilePath() async {
  var dPath = await getDocuPath();
  return "$dPath/Foregroundwindowinfo/testips";
}

writeFile(String filename, String content) async {
  var file = File(filename);
  await file.writeAsString(content);
}

readFile(String filename) async {
  var file = File(filename);
  return await file.readAsString();
}