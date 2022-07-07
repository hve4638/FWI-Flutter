import 'package:fluent_ui/fluent_ui.dart';

class IgnoreProcessAddBox extends StatefulWidget {
  const IgnoreProcessAddBox({
    Key? key,
    required this.name,
    required this.editor,
  }) : super(key: key);
  final String name;
  final dynamic editor;

  @override
  State<IgnoreProcessAddBox> createState() => _IgnoreProcessAddBoxState();
}

class _IgnoreProcessAddBoxState extends State<IgnoreProcessAddBox> {
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
            Container(
              padding: const EdgeInsets.all(5),
              child : Button(
                child : const Icon(FluentIcons.add,
                  size: 18,
                ),
                onPressed: () {
                  widget.editor.add(widget.name, noAliasFlag: true);
                  widget.editor?.save();
                },
              ),
            ),
          ]
      ),
    );
  }
}