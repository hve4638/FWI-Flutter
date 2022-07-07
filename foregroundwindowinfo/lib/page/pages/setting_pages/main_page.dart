import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';
import 'package:wininfo/fwiconfig/config_container.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';

import '../win_tracer/win_tracer_stful.dart';

import './alias_page.dart';
import './ignore_process_page.dart';
import './setting_widgets.dart';
import './setting_sub_page.dart';
import './setting_navigator.dart';

class MainPage extends StatefulWidget implements SettingSubPage {
  MainPage({
    Key? key,
    required this.config,
    required this.aliasDictionary,
  }) : super(key: key);
  void Function()? navigationPop;
  final FwiConfig config;
  final AliasDictionary aliasDictionary;

  @override
  get title => "설정";

  @override
  State<MainPage> createState() => _MainPageState();

  @override
  dispose() {
    print("dispose Main Page");
  }

  @override
  setEventPop(pop) {
    navigationPop = pop;
  }
}

class _MainPageState extends State<MainPage> {
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
                  aliasDictionary : widget.aliasDictionary,
                ));
              }
          ),
          buttonBox("예외 프로세스",
              iconData : FluentIcons.trackers,
              onPressed : () {
                var configContainer = ConfigContainer.of(context)!;
                var ignoreProcesses = configContainer.ignoreProcesses;
                var noAliases = configContainer.noAliases;

                SettingNavigatorWidget.navigator(context).push(
                  IgnoreProcessPage(
                    config: widget.config,
                    noAliases: noAliases,
                    ignoreProcesses: ignoreProcesses,
                  )
                );
              }
          ),
          buttonBox("test",
              iconData : FluentIcons.trackers,
              onPressed : () {
                print(ConfigContainer.of(context)?.text);
              }
          ),
        ]
    );
  }
}
