import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';

import './setting_sub_page.dart';
import './ignore_process/message_box.dart';
import 'ignore_process/editor/ignore_process_editor.dart';

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
  var _ignoreProcessBoxes = <Widget>[];
  bool _showNoAlias = false;
  IgnoreProcessEditor? editor;

  @override
  void initState() {
    super.initState();
    editor = IgnoreProcessEditor(
      ignoreProcesses : widget.ignoreProcesses,
      noAliases : widget.noAliases,
      controller: widget.messageBoxNameController,
      onChanged : (List<Widget> boxes, List<Widget> noAlias) {
        List<Widget>? ignoreProcessBoxes;

        if (_showNoAlias) {
          ignoreProcessBoxes = [
            ...noAlias,
            Container(
              padding : const EdgeInsets.all(5.0),
              child : const Divider(
                style: DividerThemeData(
                  thickness: 1.0,
                ),
              ),
            ),
            ...boxes,
          ];
        } else {
          ignoreProcessBoxes = [...boxes];
        }

        setState(() {
          _ignoreProcessBoxes = ignoreProcessBoxes!;
        });
      },
    );

    editor?.update();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
              height : 40,
              margin : const EdgeInsets.fromLTRB(25, 5, 25, 5),
              padding : const EdgeInsets.all(3),
              child: Row(
                  children: [
                    Container(
                        padding : const EdgeInsets.all(3),
                        child: FilledButton(
                            child : const Icon(FluentIcons.add),
                            onPressed : () {
                              showEditMessage(
                                  context: context,
                                  name: "",
                                  onSubmitted: (name) {
                                    editor?.add(name);
                                    editor?.save();
                                  }
                              );
                            }
                        )
                    ),
                    Container(
                      padding : const EdgeInsets.all(3),
                      child: Checkbox(
                          checked: _showNoAlias,
                          onChanged: (value) {
                            setState(() {
                              _showNoAlias = value ?? false;
                            });

                            editor?.update();
                          }
                      )
                    ),
                  ]
              )
          ),
          Expanded(
            child : Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 25),
              //color: Colors.red,
              child: ListView(
                children: _ignoreProcessBoxes,
              ),
            ),
          ),
        ]
    );
  }
}