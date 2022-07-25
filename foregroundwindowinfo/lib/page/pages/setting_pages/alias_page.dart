import 'package:fluent_ui/fluent_ui.dart';

import '../../../fwiconfig/global_config.dart';
import './setting_sub_page.dart';
import 'alias/editor/alias_editor.dart';
import './process_page/process_page.dart';
import './alias/message/message.dart';

class AliasPage extends StatefulWidget implements SettingSubPage {
  AliasPage({ Key? key, }) : super(key: key);
  void Function()? navigationPop;
  final globalText = GlobalText();
  var messageBoxNameController = TextEditingController();
  var messageBoxAliasController = TextEditingController();

  @override
  dispose() {
    messageBoxNameController.dispose();
    messageBoxAliasController.dispose();
  }

  @override
  get title => globalText["PAGE_SETTING_ALIAS"];

  @override
  setEventPop(pop) {
    navigationPop = pop;
  }

  @override
  State<AliasPage> createState() => _AliasPageState();
}

class _AliasPageState extends State<AliasPage> {
  final config = GlobalConfig();
  AliasEditor? editor;

  get globalText => widget.globalText;

  @override
  void initState() {
    super.initState();
    editor = AliasEditor(
      nameController: widget.messageBoxNameController,
      aliasController: widget.messageBoxAliasController,
      aliases: config.aliases,
      onChanged: (aliasList, noAliasList) {}
    );

    editor?.update();
  }

  @override
  Widget build(BuildContext context) {
    return ProcessListPage(
        onAdd: () {
          showEditMessage(
              context: context,
              name: "",
              onSubmitted: (name, alias, rejectMessage) {
                if (name == "") {
                  rejectMessage.message = globalText["MESSAGE_INSERT_PROCESS"];
                  rejectMessage.position = RejectPosition.name;
                  return false;
                } else if (config.aliases.containsKey(name)) {
                  rejectMessage.message = globalText["MESSAGE_DUPLICATE_PROCESS"];
                  rejectMessage.position = RejectPosition.name;
                  return false;
                } else if (alias == "") {
                  rejectMessage.message = globalText["MESSAGE_INSERT_ALIAS"];
                  rejectMessage.position = RejectPosition.alias;
                  return false;
                } else {
                  editor?.add(name, alias);
                  editor?.save();
                  return true;
                }
              }
          );
        },
        manager: editor!
    );
  }
}