import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';

import './setting_sub_page.dart';
import './ignore_process/message_box.dart';
import 'ignore_process/editor/ignore_process_editor.dart';
import './process_page/process_page.dart';

class IgnoreProcessPage extends StatefulWidget implements SettingSubPage {
  IgnoreProcessPage({
    required this.config,
    required this.ignoreProcesses,
    required this.noAliases,
    Key? key,
  }) : super(key: key);
  final FwiConfig config;
  final IgnoreProcessSet ignoreProcesses;
  final NoAliasDictionary noAliases;
  void Function()? navigationPop;
  var messageBoxNameController = TextEditingController();

  @override
  dispose() {
    messageBoxNameController.dispose();
  }

  @override
  get title => "예외프로세스";

  @override
  setEventPop(pop) {
    navigationPop = pop;
  }

  @override
  State<IgnoreProcessPage> createState() => _IgnoreProcessPageState();
}

class _IgnoreProcessPageState extends State<IgnoreProcessPage> {
  IgnoreProcessEditor? editor;

  @override
  void initState() {
    super.initState();
    editor = IgnoreProcessEditor(
      ignoreProcesses : widget.ignoreProcesses,
      noAliases : widget.noAliases,
      controller: widget.messageBoxNameController,
      onChanged : (List<Widget> boxes, List<Widget> noAlias) {},
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
            onSubmitted: (name) {
              editor?.add(name);
              editor?.save();
            }
        );
      },
      manager: editor!,
      fixType: SearchType.name,
    );
  }
}