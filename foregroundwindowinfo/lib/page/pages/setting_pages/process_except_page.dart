import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import './setting_sub_page.dart';
import '../win_tracer/win_tracer_stful.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import './alias_page.dart';
import './setting_widgets.dart';
import 'setting_navigator.dart';

class ProcessExceptPage extends StatefulWidget implements SettingSubPage {
  ProcessExceptPage({Key? key}) : super(key: key);
  void Function()? navigationPop;

  @override
  get title => "예외프로세스 설정";

  @override
  setEventPop(pop) {
    navigationPop = pop;
  }

  @override
  State<ProcessExceptPage> createState() => _ProcessExceptPageState();
}

class _ProcessExceptPageState extends State<ProcessExceptPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //color: Colors.blue,
          height : 60,
        ),
        Expanded(
          child : Container(
            padding: const EdgeInsets.all(25),
            //color: Colors.red,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0x10020202),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  padding : const EdgeInsets.fromLTRB(15, 1, 5, 1),
                  child: Row(
                    children : [
                      Expanded(
                        child: Text("Chrome.exe"),
                      ),
                      Container(
                        width: 350,
                        child: TextBox(
                          placeholder: "alias",
                          onSubmitted: (text) {
                            print("submit");
                          },
                          highlightColor: const Color(0x00000000),
                          decoration: const BoxDecoration(
                            color : Color(0x00000000),
                            border: Border.fromBorderSide(
                                BorderSide(
                                  style: BorderStyle.none,
                                ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox( width : 10 ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child : Icon(FluentIcons.remove,
                            size: 18,
                          ),
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ]
    );
  }
}


aliasBox() {
  return Container(
    decoration: BoxDecoration(
      color: Color(0x10020202),
      borderRadius: BorderRadius.circular(6.0),
    ),
    padding : const EdgeInsets.fromLTRB(15, 1, 5, 1),
    child: Row(
        children : [
          Expanded(
            child: Text("Chrome.exe"),
          ),
          Container(
            width: 350,
            child: TextBox(
              placeholder: "alias",
              onSubmitted: (text) {
                print("submit");
              },
              highlightColor: const Color(0x00000000),
              decoration: const BoxDecoration(
                color : Color(0x00000000),
                border: Border.fromBorderSide(
                  BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox( width : 10 ),
          Container(
            padding: EdgeInsets.all(5),
            child : Icon(FluentIcons.remove,
              size: 18,
            ),
          ),
        ]
    ),
  );
}