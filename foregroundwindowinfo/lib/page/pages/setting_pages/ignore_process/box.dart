import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/page/pages/setting_pages/process_page/process_widget.dart';
import '../../../../fwiconfig/global_config.dart';
import './message/message.dart';

class IgnoreProcessBox extends StatefulWidget implements ProcessWidget {
  String _name = "";
  final bool noAliasFlag;
  final TextEditingController controller;
  final dynamic editor;

  @override
  get name => _name;
  @override
  get alias => "";

  IgnoreProcessBox(String name, {
    Key? key,
    required this.controller,
    required this.editor,
    this.noAliasFlag = false,
  }) : super(key: key) {
    _name = name;
  }

  @override
  State<IgnoreProcessBox> createState() => _IgnoreProcessBoxState();
}

class _IgnoreProcessBoxState extends State<IgnoreProcessBox> {
  final globalText = GlobalText();
  final config = GlobalConfig();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding : const EdgeInsets.fromLTRB(15, 1, 5, 1),
      margin : const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: const Color(0x10020202),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
          children : [
            Expanded(
              child: Text(widget.name),
            ),
            const SizedBox( width : 10 ),
            Container(
              padding: const EdgeInsets.all(5),
              child : Button(
                child : const Icon(FluentIcons.edit,
                  size: 18,
                ),
                onPressed: () {
                  showEditMessage(
                    context: context,
                    name: widget.name,
                    controller: widget.controller,
                    onSubmitted: (name, reject) {
                      if (name.isEmpty) {
                        reject.message = globalText["MESSAGE_INSERT_PROCESS"];
                        return false;
                      } else if (name != widget.name && config.ignoreProcesses.contains(name)) {
                        reject.message = globalText["MESSAGE_DUPLICATE_PROCESS"];
                        return false;
                      } else {
                        setState(() {
                          widget.editor.add(name);
                          widget.editor.save();
                        });
                        return true;
                      }
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child : Button(
                child : const Icon(FluentIcons.remove,
                  size: 18,
                ),
                onPressed: () {
                  if (widget.noAliasFlag) {
                    widget.editor.addAtNoAliases(widget.name, update: false);
                  }
                  widget.editor.remove(widget.name);
                  widget.editor.save();
                },
              ),
            ),
          ]
      ),
    );
  }
}