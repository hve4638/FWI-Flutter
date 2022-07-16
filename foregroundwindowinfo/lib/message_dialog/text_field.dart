import 'package:fluent_ui/fluent_ui.dart';

class DialogTextField extends StatefulWidget {
  DialogTextField({
    Key? key,
    this.errorMessage = "",
    this.controller,
    this.onChanged,
    this.placeholder,
    this.highlightColor,
    this.readOnly = false,
    this.textStyle
  }) : super(key: key);
  TextEditingController? controller;
  final Function(String)? onChanged;
  String errorMessage;
  String? placeholder;
  Color? highlightColor;
  TextStyle? textStyle;
  bool readOnly;

  @override
  State<DialogTextField> createState() => _DialogTextFieldState();
}

class _DialogTextFieldState extends State<DialogTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBox(
          controller: widget.controller,
          placeholder: widget.placeholder,
          onChanged: widget.onChanged,
          highlightColor: widget.highlightColor,
          readOnly: widget.readOnly,
        ),
        Container(
          padding : const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Text(widget.errorMessage,
            style: widget.textStyle,
          ),
        ),
      ],
    );
  }
}