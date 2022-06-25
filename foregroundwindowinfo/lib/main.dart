import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';
import 'root_page.dart';
import 'package:window_size/window_size.dart';
import 'fwiconfig/fwi_config_manager.dart';
import 'dart:io';
import 'docu_path.dart';

void main() async {
  var config = await getFwiConfig();
  var alias = await getAliasDic();
  setWindowFunctions();

  runApp(RootPage(
    config : config,
    aliasDictionary : alias,
  ));
}

Future<FwiConfigManager> getFwiConfig() async {
  const directoryName = "Foregroundwindowinfo";
  var docuPath = await getDocuPath();

  await Directory("$docuPath\\$directoryName").create();
  var config = FwiConfigManager("$docuPath\\$directoryName\\config.ini");
  await config.load();

  return config;
}

getAliasDic() async {
  const directoryName = "Foregroundwindowinfo";
  var docuPath = await getDocuPath();

  await Directory("$docuPath\\$directoryName").create();
  var alias = AliasDictionary("$docuPath\\$directoryName\\alias.json");
  await alias.load();

  return alias;
}

Future setWindowFunctions() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('ForegroundWindowInfo');
    setWindowMinSize(const Size(700, 500));
    setWindowMaxSize(Size.infinite);
  }
}
