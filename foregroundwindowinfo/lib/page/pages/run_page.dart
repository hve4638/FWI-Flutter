import 'package:fluent_ui/fluent_ui.dart';
import '/fwi/fwi.dart';
import '../../fwiconfig/global_config.dart';
import '/timer/interval_event.dart';
import 'win_tracer/win_tracer_stful.dart';

class RunPage extends WinTracerStatefulWidget {
  const RunPage({
    Key? key,
    required onInitState,
    required this.foregroundWindowInfo,
    required this.onToggle,
  }) : super(key: key, onInitState : onInitState);
  final FWIReadOnly foregroundWindowInfo;
  final Function onToggle;

  @override
  State<RunPage> createState() => RunPageState();
}

class RunPageState extends WinTracerState<RunPage> {
  final globalText = GlobalText();
  var info = FWI();
  var event = IntervalEvent();
  var buttonText = "";
  var buttonColor = Colors.green;

  @override
  onEnable() {
    event.start(100, () {
      setState(() {
        info.copy(widget.foregroundWindowInfo);
      });
    });
  }

  @override
  onDisable() {
    event.stop();
  }

  @override
  void initState() {
    super.initState();
    info.copy(widget.foregroundWindowInfo);
    updateButton();
  }

  toggle() {
    widget.onToggle();
    updateButton();
  }

  updateButton() {
    if (widget.foregroundWindowInfo.isRunning) {
      setState(() {
        buttonText = globalText["TRACE_STOP"];
        buttonColor = Colors.red;
      });
    }
    else {
      setState(() {
        buttonText = globalText["TRACE_START"];
        buttonColor = Colors.green;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color : Colors.white,
      child : Column(
        children : [
          Expanded(
            child: Center(
              child: Text(
                  info.time,
                style : const TextStyle(
                  fontSize : 32,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
          ),
          Expanded(
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children : [
                    Text(info.name,
                      style : const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontSize : 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(13.0),
                        child: Text(info.title,
                          style : const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                            fontSize : 18,
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
          ),
          Expanded(
            child: Center(
              child: Button(
                onPressed: toggle,
                child : Text(buttonText),
              )
            ),
          ),
        ]
      )
    );
  }
}
