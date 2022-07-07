import 'package:fluent_ui/fluent_ui.dart';
import './alias_info.dart';
import './alias_message.dart';
import 'editor/editor.dart';

class AliasAddBox extends StatefulWidget {
  const AliasAddBox({
    Key? key,
    required this.name,
    required this.editor,
    required this.nameController,
    required this.aliasController,
  }) : super(key: key);
  final String name;
  final Editor editor;
  final TextEditingController nameController;
  final TextEditingController aliasController;

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
                  _showAddMessageBox(
                    onSubmitted: (name, alias) {
                      widget.editor.add(name, alias);
                    },
                    name : widget.name,
                    context: context,
                    nameController: widget.nameController,
                    aliasController: widget.aliasController,
                  );
                },
              ),
            ),
          ]
      ),
    );
  }
}

_showAddMessageBox({
  required BuildContext context,
  required String name,
  Function(String, String)? onSubmitted,
  TextEditingController? nameController,
  TextEditingController? aliasController,
}) {
  var submit = onSubmitted ?? (name, alias) => null;

  showAliasEditBox(
    context: context,
    name: name,
    onSubmitted: submit,
    nameController: nameController,
    aliasController: aliasController,
    nameReadonly: true,
  );
}