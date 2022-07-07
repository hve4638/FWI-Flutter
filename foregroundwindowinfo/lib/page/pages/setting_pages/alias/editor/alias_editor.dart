import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

import '../add_box.dart';
import '../box.dart';
import '../../widget_map/widget_map.dart';
import './editor.dart';
import '../../process_page/process_list_manager.dart';

class AliasEditor implements Editor, ProcessListManager {
  final aliasBoxes = WidgetMap();
  final noAliasBoxes = WidgetMap();
  final TextEditingController nameController;
  final TextEditingController aliasController;
  Function(List<Widget>, List<Widget>) onChanged;
  final AliasDictionary aliases;

  AliasEditor({
    required this.aliases,
    required this.nameController,
    required this.aliasController,
    required this.onChanged,
  }) {
    aliases.forEach((name, alias) {
      _addAtWidget(name, alias, noAliasFlag : false);
    });
    for(var key in aliases.noAlias.toList()) {
      _addWidgetAdNoAliases(key);
    }
  }

  @override
  setOnChanged(Function(List<Widget> p1, List<Widget> p2) onChanged) {
    this.onChanged = onChanged;
  }

  @override
  add(String name, String alias, { bool update = true, bool? noAliasFlag }) {
    if (aliases.noAlias.contains(name)) {
      aliases.noAlias.remove(name);
      noAliasFlag ??= true;
    }

    aliases[name] = alias;
    _addAtWidget(name, alias, noAliasFlag: noAliasFlag ?? false);

    if (update) this.update();
  }

  _addAtWidget(String name, String alias, { bool noAliasFlag = false }) {
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
    var alias = _getAlias(from);
    remove(from, update: false);
    add(to, alias, update: false);

    if (update) this.update();
  }

  _getAlias(String name) {
    return aliasBoxes[name].alias;
  }

  @override
  replace(String name, String alias, { bool update = true }) {
    var noAliasFlag = _hasNoAliasFlag(name);
    remove(name, update: false);
    add(name, alias, update: false, noAliasFlag: noAliasFlag);

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

  addAtNoAliases(String name, { bool update = false }) {
    aliases.noAlias.add(name);
    _addWidgetAdNoAliases(name);
  }

  _addWidgetAdNoAliases(String name) {
    noAliasBoxes[name] = AliasAddBox(
      name: name,
      editor: this,
      nameController: nameController,
      aliasController: aliasController,
    );
  }

  removeAtNoAliases(String name, { bool update = false }) {
    aliases.noAlias.remove(name);
  }

  @override
  save() {
    aliases.save();
  }

  @override
  update() {
    onChanged(aliasBoxes.widgets, noAliasBoxes.widgets);
  }
}










