import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_size/window_size.dart';

import 'dart:io';
import 'package:wininfo/fwiconfig/alias_dic.dart';
import 'package:wininfo/fwiconfig/fwi_config_manager.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';

import 'root_page.dart';
import 'docu_path.dart';

const directoryName = "Foregroundwindowinfo";

void main() async {
  var _docuPath = await getDocuPath();
  var _path = "$_docuPath\\$directoryName";
  await Directory(_path).create();
  setWindowFunctions();

  runApp(RootPage(
    config : await getFwiConfig(_path),
    aliasDictionary : await getAliasDic(_path),
    ignoreProcesses : await getIgnoreProcesses(_path)
  ));
}

Future setWindowFunctions() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('ForegroundWindowInfo');
    setWindowMinSize(const Size(700, 500));
    setWindowMaxSize(Size.infinite);
  }
}

Future<FwiConfigManager> getFwiConfig(String directoryPath) async {
  var config = FwiConfigManager("$directoryPath\\config.ini");
  await config.load();

  return config;
}

Future<AliasDictionary> getAliasDic(String directoryPath) async {
  var alias = AliasDictionary("$directoryPath\\alias.json");
  await alias.load();

  return alias;
}

Future<IgnoreProcessSet> getIgnoreProcesses(String directoryPath) async {
  var ignoreProcesses = IgnoreProcessSet("$directoryPath\\ignoreprocess");
  await ignoreProcesses.load();
  //print("${ignoreProcesses.toList()}");

  return ignoreProcesses;
}