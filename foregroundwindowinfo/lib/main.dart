import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_size/window_size.dart';

import 'dart:io';
import 'package:wininfo/fwiconfig/alias_dictionary.dart';
import 'package:wininfo/fwiconfig/fwi_config_manager.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';

import 'fwiconfig/global_config.dart';

import 'root_page.dart';
import 'docu_path.dart';

const directoryName = "Foregroundwindowinfo";

void main() async {
  var _docuPath = await getDocuPath();
  var _path = "$_docuPath\\$directoryName";
  await Directory(_path).create();
  setWindowFunctions();

  var globalText = GlobalText();
  globalText.load("korean.csv");

  var config = GlobalConfig();
  config.setAliasDictionary(await getAliasDic(_path));
  config.setIgnoreProcess(await getIgnoreProcesses(_path));
  config.setFwiConfig(await getFwiConfig(_path));

  runApp(RootPage());
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
  var config = FwiConfigManager("$directoryPath\\config.json");
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

  return ignoreProcesses;
}