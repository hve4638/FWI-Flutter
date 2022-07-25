import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';
import 'package:wininfo/fwiconfig/alias_dictionary.dart';

import '/fwiconfig/global_config.dart';
import '../../process_page/process_list_manager.dart';
import '../../process_page/process_widget.dart';
import '../../widget_map/widget_map.dart';
import '../box.dart';
import '../add_box.dart';
import './editor.dart';


class IgnoreProcessEditor implements Editor, ProcessListManager {
  final config = GlobalConfig();

  final boxes = WidgetMap<ProcessWidget>();
  final noAliasBoxes = WidgetMap<ProcessWidget>();
  final TextEditingController controller;
  Function(List<ProcessWidget>, List<ProcessWidget>) onChanged;

  IgnoreProcessEditor({
    required this.controller,
    required this.onChanged,
  });

  @override
  add(String name, { bool update = true, bool? noAliasFlag }) {
    if (config.aliases.noAlias.contains(name)) {
      removeAtNoAliases(name, update: false);
      noAliasFlag ??= true;
    }
    config.ignoreProcesses.add(name);
    _addWidget(name, noAliasFlag: noAliasFlag ?? false);

    if (update) this.update();
  }

  _addWidget(String name, { noAliasFlag = false }) {
    boxes[name] = IgnoreProcessBox(name,
      controller : controller,
      editor : this,
      noAliasFlag : noAliasFlag,
    );
  }

  @override
  move(String from, String to, { bool update = true }) {
    remove(from, update: false);
    add(to, update: false);

    if (update) this.update();
  }

  @override
  remove(String name, { bool update = true }) {
    config.ignoreProcesses.remove(name);
    boxes.remove(name);

    if (update) this.update();
  }

  @override
  save() {
    config.ignoreProcesses.save();
  }

  addAtNoAliases(String name, { bool update = true }) {
    config.aliases.noAlias.add(name);
    _addWidgetAtNoAlias(name);

    if (update) this.update();
  }

  _addWidgetAtNoAlias(String name) {
    noAliasBoxes[name] = IgnoreProcessAddBox(
      name: name,
      editor : this,
    );
  }

  removeAtNoAliases(String name, { bool update = true }) {
    config.aliases.noAlias.remove(name);
    noAliasBoxes.remove(name);

    if (update) this.update();
  }

  @override
  update({ bool save = true }) {
    onChanged(boxes.widgets, noAliasBoxes.widgets);

    if (save) this.save();
  }

  @override
  resetNoAliasList() {
    noAliasBoxes.clear();

    for(var key in config.aliases.noAlias.toList()) {
      _addWidgetAtNoAlias(key);
    }
  }

  @override
  resetProcessList() {
    boxes.clear();

    for(var key in config.ignoreProcesses.toList()) {
      _addWidget(key);
    }
  }

  @override
  setOnChanged(Function(List<ProcessWidget> p1, List<ProcessWidget> p2) onChanged) {
    this.onChanged = onChanged;
  }
}










