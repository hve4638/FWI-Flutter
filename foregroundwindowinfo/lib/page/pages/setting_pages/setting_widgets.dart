import 'package:fluent_ui/fluent_ui.dart';

const double globalFontSize = 16;
const double globalTitleFontSize = 32;

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
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child : Text(name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: globalFontSize,
                  ),
                )
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
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(
            width : 15,
          ),
        ]
    ),
  );
}

inputBoxWithDescription(String name, {
  required String placeholder,
  required String description,
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
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : [
                      Text(name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: globalFontSize,
                        ),
                      ),
                      const SizedBox( height:2 ),
                      Text(" $description",
                        style: const TextStyle(
                          color: Color(0xFF5B5B5B),
                          fontSize: globalFontSize-3,
                        ),
                      ),
                    ]
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
