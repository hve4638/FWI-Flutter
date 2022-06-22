import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'root_page.dart';
import 'package:window_size/window_size.dart';
import 'fwiconfig/fwi_config_manager.dart';
import 'dart:io';
import 'docu_path.dart';

void main() async {
  var config = await getFwiConfig();
  setWindowFunctions();

  runApp(RootPage(config : config));
}

Future<FwiConfigManager> getFwiConfig() async {
  const directoryName = "Foregroundwindowinfo";
  var docuPath = await getDocuPath();

  await Directory("$docuPath\\$directoryName").create();
  var config = FwiConfigManager("$docuPath\\$directoryName\\config.ini");
  await config.load();

  return config;
}

Future setWindowFunctions() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('ForegroundWindowInfo');
    setWindowMinSize(const Size(700, 500));
    setWindowMaxSize(Size.infinite);
  }
}

