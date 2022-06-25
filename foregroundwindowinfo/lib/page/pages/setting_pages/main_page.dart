import 'package:fluent_ui/fluent_ui.dart';
import '../win_tracer/win_tracer_stful.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import './alias_page.dart';
import './process_except_page.dart';
import './setting_widgets.dart';
import 'setting_navigator.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

class MainPage extends WinTracerStatefulWidget {
  const MainPage({
    Key? key,
    required onInitState,
    required this.config,
    required this.aliasDictionary
  }) : super(key: key, onInitState : onInitState);
  final FwiConfig config;
  final AliasDictionary aliasDictionary;

  @override
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends WinTracerState<MainPage> {
  var controllerList = <String, TextEditingController>{};

  @override
  void initState() {
    super.initState();
    addController("traceUpdateTime", widget.config.traceUpdateTime);
    addController("timelineUpdateTime", widget.config.timelineUpdateTime);
    addController("rankUpdateTime", widget.config.rankUpdateTime);
  }

  addController(String name, int value) {
    var controller = TextEditingController();
    controller.text = value.toString();

    controllerList[name] = controller;

    return controller;
  }

  getController(name) {
    return controllerList[name];
  }

  disposeController() {
    controllerList.forEach((_, controller) {
      controller.dispose();
    });
    controllerList.clear();
  }

  @override
  dispose() {
    super.dispose();

    disposeController();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          title("갱신 주기"),
          inputBox("추적 주기",
              placeholder: "1000",
              suffix: "ms",
              iconData : FluentIcons.clock,
              controller : getController("traceUpdateTime"),
              onSubmitted: (text) {
                var value = int.tryParse(text);
                if (value == null) return;

                widget.config.traceUpdateTime = value;
                widget.config.save();
              }
          ),
          inputBox("타임라인 갱신 주기",
              placeholder: "1",
              suffix: "ms",
              iconData : FluentIcons.trackers,
              controller : getController("timelineUpdateTime"),
              onSubmitted: (text) {
                var value = int.tryParse(text);
                if (value == null) return;

                widget.config.timelineUpdateTime = value;
                widget.config.save();
              }
          ),
          inputBox("랭크 갱신 주기",
              placeholder: "1000",
              suffix: "ms",
              iconData : FluentIcons.list,
              controller : getController("rankUpdateTime"),
              onSubmitted: (text) {
                var value = int.tryParse(text);
                if (value == null) return;

                widget.config.rankUpdateTime = value;
                widget.config.save();
              }
          ),
          const SizedBox( height: 15 ),
          title("별명"),
          buttonBox("별명",
              iconData : FluentIcons.trackers,
              onPressed : () {
                SettingNavigatorWidget.navigator(context).push(AliasPage(
                  aliasDictionary : widget.aliasDictionary
                ));
              }
          ),
          buttonBox("예외 프로세스",
              iconData : FluentIcons.trackers,
              onPressed : () {
                SettingNavigatorWidget.navigator(context).push(ProcessExceptPage());
              }
          ),
          buttonBox("test",
              iconData : FluentIcons.trackers,
              onPressed : () {
                var nav = SettingNavigatorWidget.navigator(context);

                widget.aliasDictionary.toList();
                widget.aliasDictionary.save();
              }
          ),
        ]
    );
  }
}
