import 'package:fluent_ui/fluent_ui.dart';

const double globalFontSize = 16;
const double globalTitleFontSize = 32;

class SettingContainer extends StatefulWidget {
  SettingContainer(this.name, {
    Key? key,
    required this.body,
  }) : super(key: key) {
  }
  final Widget body;
  final String name;

  static SettingContainerState? of(BuildContext context) =>
      context.findAncestorStateOfType<SettingContainerState>();

  @override
  State<SettingContainer> createState() => SettingContainerState();
}

class SettingContainerState extends State<SettingContainer> {
  @override
  Widget build(BuildContext context) {
    var w = SettingContainer.of(context);
    print("??? $w");

    return Column(
      children: [
        Container(
          height : 80,
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(widget.name,
                  style: TextStyle(
                    fontSize : globalTitleFontSize,
                  ),
                ),
                style: ButtonStyle(
                  foregroundColor: ButtonState.all(Colors.black),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: widget.body,
        )
      ],
    );
  }
}



buttonBox(String name, {
  required IconData iconData,
  required Function() onPressed,
}) {
  return OptionContainer(
      padding : const EdgeInsets.all(0),
      color : const Color(0x00000000),
      child : FilledButton(
          onPressed: onPressed,
          style : ButtonStyle(
            padding: ButtonState.all(EdgeInsets.zero),
            backgroundColor: ButtonState.resolveWith(
                    (state) {
                  if (state.contains(ButtonStates.pressing)) {
                    return const Color(0xB09E9E9E);
                  } else if (state.contains(ButtonStates.hovering)) {
                    return const Color(0x409E9E9E);
                  } else {
                    return const Color(0x809E9E9E);
                  }
                }
            ),
            shadowColor: ButtonState.all(Color(0)),
          ),
          child : Container(
            padding : const EdgeInsets.all(20),
            child : Row(
                children : [
                  SizedBox(
                      width: 55,
                      child: Center(
                        child: Icon(iconData,
                          color: Colors.black,
                          size: 24,
                        ),
                      )
                  ),
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child : Text(name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: globalFontSize,
                          ),
                        ),
                      )
                  ),
                  const SizedBox(
                      width: 55,
                      child: Center(
                          child: Text(">",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )
                      )
                  ),
                ]
            ),
          )
      )
  );
}

title(String name) {
  return Container(
      margin : const EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children : [
            Text(name,
              style : TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: globalFontSize,
              ),
            )
          ]
      )
  );
}

inputBox(String name, {
  required String placeholder,
  String suffix = "",
  IconData? iconData,
  TextEditingController? controller,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
}) {
  var h = 90;
  var marginInt = 4;
  onChanged ??= (_) {};
  onSubmitted ??= (_) {};

  return OptionContainer(
    child: Row(
        children : [
          SizedBox(
              width: 55,
              child: Center(
                child: Icon(iconData ?? FluentIcons.list),
              )
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child : Text(name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: globalFontSize,
                  ),
                ),
              )
          ),
          SizedBox(
            width : 90,
            child : TextBox(
              controller: controller,
              placeholder: placeholder,
              suffix: Text(suffix),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          ),
          const SizedBox(
            width : 15,
          ),
        ]
    ),
  );
}

class OptionContainer extends Container {
  OptionContainer({
    Key? key,
    Widget? child,
    double width = double.infinity,
    double height = 90.0,
    Color color = const Color(0x809E9E9E),
    EdgeInsetsGeometry padding = const EdgeInsets.all(20),
    EdgeInsetsGeometry margin = const EdgeInsets.fromLTRB(15, 3, 15, 3),
  }) : super(
      key: key,
      child : child,
      width : width,
      height : height,
      padding : padding,
      margin : margin,
      decoration : BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: color,
      )
  );
}
