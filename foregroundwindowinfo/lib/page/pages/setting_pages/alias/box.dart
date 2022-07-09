import 'package:fluent_ui/fluent_ui.dart';
import './message_box.dart';
import 'editor/editor.dart';
import '../process_page/process_widget.dart';

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
                  showEditMessageBox(
                    name: widget.name,
                    alias: widget.alias,
                    context: context,
                    nameController: widget.nameController,
                    aliasController: widget.aliasController,
                    onSubmitted: (name, alias) {
                      widget.editor.move(widget.name, name, update: false);
                      widget.editor.replace(name, alias, update: false);
                      widget.editor.update();
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
                  showCheckBox(
                    context: context,
                    onSubmitted: () {
                      widget.editor.remove(name);
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

showAddMessageBox({
  required BuildContext context,
  Function(String, String)? onSubmitted,
  TextEditingController? nameController,
  TextEditingController? aliasController,
}) {
  var submit = onSubmitted ?? (name, alias) => null;

  showAliasEditBox(
    context: context,
    onSubmitted: submit,
    nameController: nameController,
    aliasController: aliasController
  );
}

showEditMessageBox({
  required BuildContext context,
  required String name,
  String alias = "",
  Function(String, String)? onSubmitted,
  TextEditingController? nameController,
  TextEditingController? aliasController,
}) {
  var submit = onSubmitted ?? (name, alias) => null;

  showAliasEditBox(
    name : name,
    alias : alias,
    context: context,
    onSubmitted: submit,
    nameController: nameController,
    aliasController: aliasController
  );
}