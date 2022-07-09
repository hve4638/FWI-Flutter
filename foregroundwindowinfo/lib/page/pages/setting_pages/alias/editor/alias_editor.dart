import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

import '../../widget_map/widget_map.dart';
import '../../process_page/process_list_manager.dart';
import '../../process_page/process_widget.dart';

import '../add_box.dart';
import '../box.dart';
import './editor.dart';

class AliasEditor implements Editor, ProcessListManager {
  final aliasBoxes = WidgetMap<ProcessWidget>();
  final noAliasBoxes = WidgetMap<ProcessWidget>();
  final TextEditingController nameController;
  final TextEditingController aliasController;
  Function(List<ProcessWidget>, List<ProcessWidget>) onChanged;
  final AliasDictionary aliases;

  AliasEditor({
    required this.aliases,
    required this.nameController,
    required this.aliasController,
    required this.onChanged,
  });

  @override
  add(String name, String alias, { bool update = true, bool? noAliasFlag }) {
    if (aliases.noAlias.contains(name)) {
      removeAtNoAliases(name);
      noAliasFlag ??= true;
    }
    aliases[name] = alias;
    _addWidget(name, alias, noAliasFlag: noAliasFlag ?? false);

    if (update) this.update();
  }

  _addWidget(String name, String alias, { bool noAliasFlag = false }) {
    aliasBoxes[name] = AliasBox(
      name : name,
      alias : alias,
      aliasController: aliasController,
      nameController: nameController,
      editor: this,
      noAliasFlag : noAliasFlag,
    );
  }

  @override
  move(String from, String to, { bool update = true }) {
    var alias = aliasBoxes[from].alias;
    remove(from, update: false);
    add(to, alias, update: false);

    if (update) this.update();
  }

  @override
  replace(String name, String alias, { bool update = true }) {
    if (aliasBoxes[name].noAliasFlag) {
      addAtNoAliases(name, update: false);
    }
    remove(name, update: false);
    add(name, alias, update: false);

    if (update) this.update();
  }

  _hasNoAliasFlag(String name) {
    return aliasBoxes[name].noAliasFlag;
  }

  @override
  remove(String name, { bool update = true }) {
    var noAliasFlag = _hasNoAliasFlag(name);
    if (noAliasFlag) {
      addAtNoAliases(name);
    }

    aliases.remove(name);
    aliasBoxes.remove(name);

    if (update) this.update();
  }

  addAtNoAliases(String name, { bool update = true }) {
    aliases.noAlias.add(name);
    _addWidgetAtNoAliases(name);
  }

  _addWidgetAtNoAliases(String name) {
    noAliasBoxes[name] = AliasAddBox(
      name: name,
      editor: this,
      nameController: nameController,
      aliasController: aliasController,
    );
  }

  removeAtNoAliases(String name, { bool update = false }) {
    aliases.noAlias.remove(name);
    noAliasBoxes.remove(name);
  }

  @override
  save() {
    aliases.save();
  }

  @override
  update({ bool save = true }) {
    onChanged(aliasBoxes.widgets, noAliasBoxes.widgets);

    if (save) this.save();
  }

  @override
  setOnChanged(Function(List<ProcessWidget> p1, List<ProcessWidget> p2) onChanged) {
    this.onChanged = onChanged;
  }

  @override
  resetProcessList() {
    aliasBoxes.clear();
    aliases.forEach((name, alias) {
      _addWidget(name, alias, noAliasFlag : false);
    });
  }

  @override
  resetNoAliasList() {
    noAliasBoxes.clear();
    for(var key in aliases.noAlias.toList()) {
      _addWidgetAtNoAliases(key);
    }
  }
}










