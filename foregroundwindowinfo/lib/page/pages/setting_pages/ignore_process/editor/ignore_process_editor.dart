import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

import '../box.dart';
import '../add_box.dart';
import '../../widget_map/widget_map.dart';
import './editor.dart';

class IgnoreProcessEditor {
  final boxes = WidgetMap();
  final noAliasBoxes = WidgetMap();
  final TextEditingController controller;
  final Function(List<Widget>, List<Widget>) onChanged;
  final IgnoreProcessSet ignoreProcesses;
  final NoAliasDictionary noAliases;

  IgnoreProcessEditor({
    required this.ignoreProcesses,
    required this.noAliases,
    required this.controller,
    required this.onChanged,
  }) {
    for(var key in ignoreProcesses.toList()) {
      add(key, update: false);
    }
    for(var key in noAliases.toList()) {
      addFromNoAliases(key, update: false);
    }
  }

  add(String name, { bool update = true, bool noAliasFlag = false }) {
    ignoreProcesses.add(name);
    boxes[name] = IgnoreProcessBox(name,
      controller : controller,
      editor : this,
      noAliasFlag : noAliasFlag,
    );
    removeFromNoAliases(name, update: false);

    if (update) this.update();
  }

  move(String from, String to, { bool update = true }) {
    remove(from, update: false);
    add(to, update: false);

    if (update) this.update();
  }

  remove(String name, { bool update = true }) {
    ignoreProcesses.remove(name);
    boxes.remove(name);

    if (update) this.update();
  }

  save() {
    ignoreProcesses.save();
  }

  addFromNoAliases(String name, { bool update = true }) {
    noAliases.add(name);
    noAliasBoxes[name] = IgnoreProcessAddBox(
      name: name,
      editor : this,
    );

    if (update) this.update();
  }

  removeFromNoAliases(String name, { bool update = true }) {
    noAliases.remove(name);
    noAliasBoxes.remove(name);

    if (update) this.update();
  }

  update() {
    onChanged(boxes.widgets, noAliasBoxes.widgets);
  }
}










