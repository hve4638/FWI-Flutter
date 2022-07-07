import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

import './setting_sub_page.dart';
import './alias/alias_info.dart';
import './alias/box.dart';
import './alias/add_box.dart';
import 'alias/editor/alias_editor.dart';

class AliasPage extends StatefulWidget implements SettingSubPage {
  AliasPage({
    Key? key,
    required this.aliasDictionary,
  }) : super(key: key);
  final AliasDictionary aliasDictionary;
  void Function()? navigationPop;
  var messageBoxNameController = TextEditingController();
  var messageBoxAliasController = TextEditingController();

  @override
  dispose() {
    messageBoxNameController.dispose();
    messageBoxAliasController.dispose();
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
  AliasEditor? aliasEditor;
  var _aliasWidgetList = <Widget>[];
  final aliasDict = <String, AliasInfo>{};
  bool _showNoAlias = false;

  @override
  void initState() {
    super.initState();
    aliasEditor = AliasEditor(
      nameController: widget.messageBoxNameController,
      aliasController: widget.messageBoxAliasController,
      aliases: widget.aliasDictionary,
      onChanged: (aliasList, noAliasList) {
        List<Widget>? ls;

        if (_showNoAlias) {
          ls = [
            ...noAliasList,
            Container(
              padding : const EdgeInsets.all(5.0),
              child : const Divider(
                style: DividerThemeData(
                  thickness: 1.0,
                ),
              ),
            ),
            ...aliasList
          ];
        } else {
          ls = [...aliasList];
        }

        setState(() {
          _aliasWidgetList = ls!;
        });
      }
    );

    aliasEditor?.update();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            height : 40,
            margin : const EdgeInsets.fromLTRB(25, 5, 25, 5),
            padding : const EdgeInsets.all(3),
            child: Row(
              children: [
                Container(
                  //color: Colors.blue,
                  width : 50,
                  height : 40,
                  padding : const EdgeInsets.all(3),
                  child: Button(
                    child : const Icon(FluentIcons.add),
                    onPressed : () {
                      showAddMessageBox(
                        context: context,
                        onSubmitted : (name, alias) {
                          aliasEditor?.add(name, alias);
                        },
                        nameController: widget.messageBoxNameController,
                        aliasController: widget.messageBoxAliasController
                      );
                    }
                  )
                ),
                const SizedBox( width: 10 ),
                Container(
                    padding : const EdgeInsets.all(3),
                    child: ToggleButton(
                      child: const Text("별명이 지정되지 않은 프로세스 표시"),
                      checked: _showNoAlias,
                      onChanged: (value) {
                        setState(() {
                          _showNoAlias = value;
                        });

                        aliasEditor?.update();
                      },

                    )
                ),
                /*
                const SizedBox( width: 2 ),
                const Text("별명이 지정되지 않은 프로세스 표시",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )*/
              ]
            )
          ),
          Container(
            height : 80,
            margin : const EdgeInsets.fromLTRB(25, 5, 25, 5),
            padding : const EdgeInsets.all(3),
            child : Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("프로세스 검색",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox( height: 5,),
                    SizedBox(
                      width : 250,
                      child: TextBox(
                        onChanged: (text) {
                          print("changed : $text");
                        },
                        placeholder: "검색",
                        suffix : Container(
                          padding: EdgeInsets.all(2),
                          child : const Icon(FluentIcons.search),
                        ),
                      ),
                    ),
                  ]
                ),
                const SizedBox( width : 20 ),
                DropDownButton(
                  title: const Text("검색 기준"),
                  items: [
                    DropDownButtonItem(
                        title : const Text("프로세스명"),
                        leading: const Icon(FluentIcons.align_justify),
                        onTap: () {

                        }
                    ),
                    DropDownButtonItem(
                        title : const Text("별명"),
                        leading: const Icon(FluentIcons.favorite_star),
                        onTap: () {

                        }
                    ),
                  ]
                )
              ],
            )
          ),
          Expanded(
            child : Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 25),
              child: ListView(
                children: _aliasWidgetList,
              ),
            ),
          ),
        ]
    );
  }
}