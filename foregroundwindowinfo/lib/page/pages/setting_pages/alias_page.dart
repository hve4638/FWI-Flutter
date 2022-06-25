import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import './setting_sub_page.dart';
import '../win_tracer/win_tracer_stful.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import './alias_page.dart';
import './setting_widgets.dart';
import 'setting_navigator.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

class AliasPage extends StatefulWidget implements SettingSubPage {
  AliasPage({
    Key? key,
    required this.aliasDictionary
  }) : super(key: key);
  final AliasDictionary aliasDictionary;
  void Function()? navigationPop;

  dispose() {
    print("Dispose Alias Page");
  }

  @override
  get title => "별명";

  @override
  setEventPop(pop) {
    navigationPop = pop;
  }

  @override
  State<AliasPage> createState() => _AliasPageState();
}

class _AliasPageState extends State<AliasPage> {
  var _aliasList = <Widget>[];

  @override
  void initState() {
    super.initState();

    var aliasList = <Widget>[];
    var list = widget.aliasDictionary.toList();
    for(var item in list) {
      aliasList.add( aliasBox(item.key, item.value) );
    }

    _aliasList = aliasList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            color: Colors.blue,
            height : 40,
            margin : EdgeInsets.fromLTRB(25, 5, 25, 5),
            padding : EdgeInsets.all(3),
            child: Row(
              children: [
                Container(
                  //color: Colors.yellow,
                  padding : EdgeInsets.all(3),
                  child: Icon(FluentIcons.add,)
                )

              ]
            )
          ),
          Expanded(
            child : Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 25),
              //color: Colors.red,
              child: ListView(
                children: _aliasList,
              ),
            ),
          ),
        ]
    );
  }
}


aliasBox(processName, alias) {
  return Container(
    padding : const EdgeInsets.fromLTRB(15, 1, 5, 1),
    margin : const EdgeInsets.all(1),
    decoration: BoxDecoration(
      color: Color(0x10020202),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
        children : [
          Expanded(
            child: Text(processName),
          ),
          Container(
            width: 300,
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