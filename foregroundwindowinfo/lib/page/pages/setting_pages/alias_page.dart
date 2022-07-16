import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

import './setting_sub_page.dart';
import './alias/box.dart';
import './alias/add_box.dart';
import 'alias/editor/alias_editor.dart';
import './process_page/process_page.dart';
import './alias/message_box.dart';

class AliasPage extends StatefulWidget implements SettingSubPage {
  AliasPage({
    Key? key,
    required this.aliasDictionary,
  }) : super(key: key);
  final AliasDictionary aliasDictionary;
  void Function()? navigationPop;
  var messageBoxNameController = TextEditingController();
  var messageBoxAliasController = TextEditingController();

  @override
  dispose() {
    messageBoxNameController.dispose();
    messageBoxAliasController.dispose();
  }

  @override
  get title => "별명";

  @override
  setEventPop(pop) {
    navigationPop = pop;
  }

  @override
  State<AliasPage> createState() => _AliasPageState();
}

class _AliasPageState extends State<AliasPage> {
  AliasEditor? editor;

  @override
  void initState() {
    super.initState();
    editor = AliasEditor(
      nameController: widget.messageBoxNameController,
      aliasController: widget.messageBoxAliasController,
      aliases: widget.aliasDictionary,
      onChanged: (aliasList, noAliasList) {}
    );

    editor?.update();
  }

  @override
  Widget build(BuildContext context) {
    return ProcessListPage(
        onAdd: () {
          showAliasEditBox(
              context: context,
              name: "",
              onSubmitted: (name, alias, errorMessage) {
                editor?.add(name, alias);
                editor?.save();
                return true;
              }
          );
        },
        manager: editor!
    );
  }
}