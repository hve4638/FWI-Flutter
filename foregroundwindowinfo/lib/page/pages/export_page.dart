import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:wininfo/fwi/fwi.dart';
import 'package:wininfo/page/pages/setting_pages/alias/editor/editor.dart';
import '../../fwi/foreground_window_tracer.dart';
import '/timer/interval_event.dart';
import 'win_tracer/win_tracer_stful.dart';
import '../../fwiconfig/global_config.dart';

class ExportPage extends WinTracerStatefulWidget {
  final ForegroundWindowTracer foregroundWindowTracer;

  const ExportPage({
    Key? key,
    required onInitState,
    required this.foregroundWindowTracer
  }) : super(key: key, onInitState : onInitState);

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends WinTracerState<ExportPage> {
  final globalText = GlobalText();
  final controller = TextEditingController();
  var _date = DateTime.now();

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height : 70,
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(globalText["PAGE_EXPORT"],
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(globalText["EXPORT_YOUTUBE"],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox( height: 10 ),
              TextBox(
                controller : controller,
                minHeight: 90,
                //readOnly: true,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                cursorHeight: 50,
              ),
              const SizedBox( height: 10 ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: DatePicker(
                      selected: _date
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TimePicker(
                      selected: _date
                    ),
                  ),
                  const SizedBox(width: 10),
                  Button(
                    onPressed: () {
                      var timelineLog = widget.foregroundWindowTracer.timelineLog;
                      var date = timelineLog.firstDate;
                      if (date != null) {
                        setState(() {
                          _date = date;
                        });
                      }
                    }, child: Text(globalText["EXPORT_SET_FIRSTTIME"]),
                  ),
                  const Expanded(child: SizedBox()),
                  Button(
                    onPressed: () {
                      var timelineLog = widget.foregroundWindowTracer.timelineLog;
                      controller.text = timelineLog.exportTimeline(startTime: _date);
                    }, child: Text(globalText["EXPORT_EXPORT"]),
                  ),
                  const SizedBox(width: 10),
                  Button(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: controller.text));
                    }, child: Text(globalText["EXPORT_COPY"]),
                  )
                ],
              ),
            ],
          )
        ),
      ],
    );
  }
}


