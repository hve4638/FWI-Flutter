import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dictionary.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';

import '../../../fwiconfig/global_config.dart';
import './setting_sub_page.dart';
import 'ignore_process/editor/ignore_process_editor.dart';
import './process_page/process_page.dart';
import './ignore_process/message/message.dart';

class IgnoreProcessPage extends StatefulWidget implements SettingSubPage {
  IgnoreProcessPage({ Key? key, }) : super(key: key);
  void Function()? navigationPop;
  final globalText = GlobalText();

  @override
  get title => globalText["PAGE_SETTING_IGNORE_PROCESS"];

  @override
  setEventPop(pop) {
    navigationPop = pop;
  }

  @override
  State<IgnoreProcessPage> createState() => _IgnoreProcessPageState();

  @override
  dispose() {

  }
}

class _IgnoreProcessPageState extends State<IgnoreProcessPage> {
  final config = GlobalConfig();
  final textEditingController = TextEditingController();
  IgnoreProcessEditor? editor;

  get globalText => widget.globalText;

  @override
  void initState() {
    super.initState();
    editor = IgnoreProcessEditor(
      controller: textEditingController,
      onChanged : (List<Widget> boxes, List<Widget> noAlias) {},
    );

    editor?.update();
  }

  @override
  void dispose() {
    super.dispose();

    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProcessListPage(
      onAdd: () {
        showEditMessage(
            context: context,
            onSubmitted: (name, reject) {
              if (name.isEmpty) {
                reject.message = globalText["MESSAGE_INSERT_PROCESS"];
                return false;
              } else if (config.ignoreProcesses.contains(name)) {
                reject.message = globalText["MESSAGE_DUPLICATE_PROCESS"];
                return false;
              } else {
                editor?.add(name);
                editor?.save();

                return true;
              }
            }
        );
      },
      manager: editor!,
      fixType: SearchType.name,
    );
  }
}









