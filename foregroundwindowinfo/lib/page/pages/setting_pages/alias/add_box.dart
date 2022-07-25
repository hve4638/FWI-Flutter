import 'package:fluent_ui/fluent_ui.dart';
import '../process_page/process_widget.dart';
import './editor/editor.dart';

import './message/message.dart';

class AliasAddBox extends StatefulWidget implements ProcessWidget {
  String _name = "";
  final Editor editor;
  final TextEditingController nameController;
  final TextEditingController aliasController;

  @override
  get name => _name;
  @override
  get alias => "";

  AliasAddBox({
    Key? key,
    required String name,
    required this.editor,
    required this.nameController,
    required this.aliasController,
  }) : super(key: key) {
    _name = name;
  }

  @override
  State<AliasAddBox> createState() => _AliasBoxState();
}

class _AliasBoxState extends State<AliasAddBox> {
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
                child : const Icon(FluentIcons.add,
                  size: 18,
                ),
                onPressed: () {
                  showEditMessage(
                    name : widget.name,
                    context: context,
                    nameController: widget.nameController,
                    aliasController: widget.aliasController,
                    nameReadonly: true,
                    onSubmitted: (name, alias, reject) {
                      if (alias.isEmpty) {
                        reject.message = "별명을 입력해야 합니다";
                        reject.position = RejectPosition.alias;
                        return false;
                      } else {
                        widget.editor.add(name, alias);
                        return true;
                      }
                    },
                  );
                },
              ),
            ),
          ]
      ),
    );
  }
}