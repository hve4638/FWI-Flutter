import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwi/fwi.dart';
import 'win_tracer/win_tracer_stful.dart';

class AboutPage extends WinTracerStatefulWidget {
  const AboutPage({
    Key? key,
    required onInitState,
  }) : super(key: key, onInitState : onInitState);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends WinTracerState<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text("ForegroundWindowInfo",
            style: TextStyle(
              fontSize : 22,
              fontWeight: FontWeight.bold
            ),
          ),

        ],
      ),
    );
  }
}


