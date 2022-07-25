import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dictionary.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';

import '../../../fwiconfig/global_config.dart';
import '../win_tracer/win_tracer_stful.dart';

import 'package:wininfo/controllers.dart';

import './alias_page.dart';
import './ignore_process_page.dart';
import './setting_widgets.dart';
import './setting_sub_page.dart';
import './setting_navigator.dart';

class MainPage extends StatefulWidget implements SettingSubPage {
  MainPage({ Key? key, }) : super(key: key);
  void Function()? navigationPop;

  @override
  get title => "설정";

  @override
  State<MainPage> createState() => _MainPageState();

  @override
  dispose() {

  }

  @override
  setEventPop(pop) {
    navigationPop = pop;
  }
}

class _MainPageState extends State<MainPage> {
  final globalText = GlobalText();
  final config = GlobalConfig();
  var controllers = TextEditingControllers();

  @override
  void initState() {
    super.initState();
    controllers["traceUpdateTime"].text = config.fwiConfig.traceUpdateDuration.toString();
    controllers["timelineUpdateTime"].text = config.fwiConfig.timelineUpdateDuration.toString();
    controllers["rankUpdateTime"].text = config.fwiConfig.rankUpdateDuration.toString();
    controllers["timelineWriteDuration"].text = config.fwiConfig.timelineWriteDuration.toString();
  }

  @override
  dispose() {
    super.dispose();

    controllers.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          title(globalText["TITLE_UPDATE_TIME"]),
          inputBox(globalText["UPDATE_TIME_TRACE"],
              placeholder: "1000",
              suffix: "ms",
              iconData : FluentIcons.clock,
              controller : controllers["traceUpdateTime"],
              onSubmitted: (text) {
                var value = int.tryParse(text);
                if (value == null) return;

                config.fwiConfig.traceUpdateDuration = value;
                config.fwiConfig.save();
              }
          ),
          inputBox(globalText["UPDATE_TIME_TIMELINE"],
              placeholder: "1000",
              suffix: "ms",
              iconData : FluentIcons.trackers,
              controller : controllers["timelineUpdateTime"],
              onSubmitted: (text) {
                var value = int.tryParse(text);
                if (value == null) return;

                config.fwiConfig.timelineUpdateDuration = value;
                config.fwiConfig.save();
              }
          ),
          inputBox(globalText["UPDATE_TIME_RANK"],
              placeholder: "1000",
              suffix: "ms",
              iconData : FluentIcons.list,
              controller : controllers["rankUpdateTime"],
              onSubmitted: (text) {
                var value = int.tryParse(text);
                if (value == null) return;

                config.fwiConfig.rankUpdateDuration = value;
                config.fwiConfig.save();
              }
          ),
          const SizedBox( height: 15 ),
          title(globalText["TITLE_TIMELINE"]),
          inputBoxWithDescription(globalText["TIMELINE_WRITE_TIME"],
              description : globalText["DESCRIPTION_TIMELINE_WRITE_TIME"],
              placeholder: "1",
              suffix: "분",
              iconData : FluentIcons.list,
              controller : controllers["timelineWriteDuration"],
              onSubmitted: (text) {
                var value = int.tryParse(text);
                if (value == null) return;

                config.fwiConfig.timelineWriteDuration = value;
                config.fwiConfig.save();
              }
          ),
          const SizedBox( height: 15 ),
          title(globalText["TITLE_ALIAS"]),
          buttonBox(globalText["PAGE_SETTING_ALIAS"],
            iconData : FluentIcons.trackers,
            onPressed : () {
              SettingNavigatorWidget.navigator(context).push(
                  AliasPage()
              );
            }
          ),
          buttonBox(globalText["PAGE_SETTING_IGNORE_PROCESS"],
            iconData : FluentIcons.trackers,
            onPressed : () {
              var configContainer = config.fwiConfig;
              var ignoreProcesses = config.ignoreProcesses;
              var noAliases = config.aliases.noAlias;

              SettingNavigatorWidget.navigator(context).push(
                IgnoreProcessPage()
              );
            }
          ),
          const SizedBox( height: 30 ),
        ]
    );
  }
}
