import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/page/pages/setting_pages/process_page/process_list_manager.dart';

class ProcessListPage extends StatefulWidget {
  ProcessListPage({
    Key? key,
    required this.onAdd,
    required this.manager,
  }) : super(key: key);
  final ProcessListManager manager;
  final void Function() onAdd;

  @override
  State<ProcessListPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessListPage> {
  bool _showNoAlias = false;
  var _processList = <Widget>[];

  get divisionLine {
    return Container(
      padding : const EdgeInsets.all(5.0),
      child : const Divider(
        style: DividerThemeData(
          thickness: 1.0,
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();

    widget.manager.setOnChanged(update);
  }

  update(List<Widget> aliases, List<Widget> noAliases) {
      List<Widget>? ls;

      if (_showNoAlias && noAliases.isNotEmpty) {
        ls = [
          ...noAliases,
          divisionLine,
          ...aliases,
        ];
      } else {
        ls = [...aliases];
      }

    setState(() {
      _processList = ls!;
    });
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
                            onPressed : widget.onAdd
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

                            //widget.onChanged();
                          },
                        )
                    ),
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
                children: _processList,
              ),
            ),
          ),
        ]
    );
  }
}
