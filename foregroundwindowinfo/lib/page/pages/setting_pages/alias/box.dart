import 'package:fluent_ui/fluent_ui.dart';

import 'package:wininfo/fwiconfig/config_container.dart';

import '../process_page/process_widget.dart';
import './editor/editor.dart';
import './message/message.dart';

class AliasBox extends StatefulWidget implements ProcessWidget {
  String _name = "";
  String _alias = "";
  final Editor editor;
  final TextEditingController nameController;
  final TextEditingController aliasController;
  final bool noAliasFlag;

  @override
  get name => _name;
  @override
  get alias => _alias;

  AliasBox({
    Key? key,
    required String name,
    required String alias,
    required this.editor,
    required this.nameController,
    required this.aliasController,
    required this.noAliasFlag
  }) : super(key: key) {
    _name = name;
    _alias = alias;
  }

  @override
  State<AliasBox> createState() => _AliasBoxState();
}

class _AliasBoxState extends State<AliasBox> {
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String alias = widget.alias;

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
              child: Text(name),
            ),
            Expanded(
              child: Text(alias),
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
                    name: widget.name,
                    alias: widget.alias,
                    context: context,
                    nameController: widget.nameController,
                    aliasController: widget.aliasController,
                    onSubmitted: (name, alias, rejectMessage) {
                      var aliases = ConfigContainer.aliases(context)!;

                      if (name.isEmpty) {
                        rejectMessage.message = "이름을 입력해야 합니다";
                        rejectMessage.position = RejectPosition.name;
                        return false;
                      } else if (name != widget.name && aliases[name] != null) {
                        rejectMessage.message = "이미 존재하는 이름입니다";
                        rejectMessage.position = RejectPosition.name;
                        return false;
                      } else if (alias.isEmpty) {
                        rejectMessage.message = "별명을 입력해야 합니다";
                        rejectMessage.position = RejectPosition.alias;
                        return false;
                      } else {
                        widget.editor.move(widget.name, name, update: false);
                        widget.editor.replace(name, alias, update: false);
                        widget.editor.update();
                        return true;
                      }
                    }
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
                  showDeleteMessage(
                    context: context,
                    onSubmitted: () {
                      widget.editor.remove(name);
                      return true;
                    }
                  );
                },
              ),
            ),
          ]
      ),
    );
  }
}