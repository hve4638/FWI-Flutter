//import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'rootpage.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';

void main() async {
  setWindowFunctions();

  runApp(const RootPage());
}

Future setWindowFunctions() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Demo');
    setWindowMinSize(const Size(700, 500));
    setWindowMaxSize(Size.infinite);
  }
}
