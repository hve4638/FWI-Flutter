import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/page/pages/setting_pages/process_page/process_list_manager.dart';
import 'package:wininfo/page/pages/setting_pages/process_page/process_widget.dart';
import 'package:wininfo/page/pages/setting_pages/process_page/search_dropdown/search_dropdown_item.dart';
import '../../../../fwiconfig/global_config.dart';
import './process_filter.dart';
import './search_enum.dart';
import 'search_dropdown/search_dropdown.dart';

export './process_filter.dart';
export './search_enum.dart';

class ProcessListPage extends StatefulWidget {
  const ProcessListPage({
    Key? key,
    required this.onAdd,
    required this.manager,
    this.fixType,
  }) : super(key: key);
  final ProcessListManager manager;
  final void Function() onAdd;
  final SearchType? fixType;

  @override
  State<ProcessListPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessListPage> {
  final globalText = GlobalText();
  bool _showNoAlias = false;
  String _searchText = "";
  SearchType _searchType = SearchType.name;
  bool _regexSearch = false;
  bool _matchCase = false;
  final _searchWidgets = <Widget>[];
  var _processList = <Widget>[];

  @override
  initState() {
    super.initState();

    widget.manager.setOnChanged(update);
    widget.manager.resetNoAliasList();
    widget.manager.resetProcessList();
    widget.manager.update();

    _initSearchWidget();
  }

  _initSearchWidget() {
    if (widget.fixType == null) {
      _searchWidgets.add(const SizedBox( width : 20 ));
      _searchWidgets.add(_makeDropdown());
    } else {
      _searchType = widget.fixType!;
    }
  }

  Widget _makeDropdown() {
    var searcher = SearchDropDown(
      onChanged: (SearchType type) {
        setState(() {
          _searchType = type;
        });
        widget.manager.update(save: false);
      },
      items : [
        SearchDropDownItem(
          title: globalText["SEARCH_TYPE_PROCESS"],
          icon: FluentIcons.align_justify,
          value: SearchType.name,
        ),
        SearchDropDownItem(
          title: globalText["SEARCH_TYPE_ALIAS"],
          icon: FluentIcons.favorite_star,
          value: SearchType.alias,
        ),
      ]
    );

    return searcher;
  }

  update(List<ProcessWidget> aliases, List<ProcessWidget> noAliases) {
    List<Widget>? ls;

    if (_showNoAlias && noAliases.isNotEmpty) {
      ls = [
        ...search(noAliases),
        divisionLine,
        ...search(aliases),
      ];
    } else {
      ls = [...search(aliases)];
    }

    setState(() {
      _processList = ls!;
    });
  }

  search(List<ProcessWidget> widgets) {
    if (_searchText.isEmpty) {
      return widgets;
    } else {
      var filter = ProcessFilter(
        list : widgets,
        search : _searchText,
        searchMode: _regexSearch ? SearchMode.regex : SearchMode.plain,
        type: _searchType,
      );

      var result = <Widget>[];
      for(var w in filter) {
        result.add(w);
      }
      return result;
    }
  }

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
                          child: Text(globalText["BUTTON_SHOW_PROCESS_WITHOUT_ALIAS"]),
                          checked: _showNoAlias,
                          onChanged: (value) {
                            setState(() {
                              _showNoAlias = value;
                            });

                            if (value) {
                              widget.manager.resetNoAliasList();
                            }
                            widget.manager.update();
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
                        Text(globalText["SEARCH_PROCESS"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox( height: 5,),
                        SizedBox(
                          width : 250,
                          child: TextBox(
                            onChanged: (text) {
                              _searchText = text;
                              widget.manager.update(save:false);
                            },
                            placeholder: globalText["SEARCH_PLACEHOLDER"],
                            suffix : Container(
                              padding: const EdgeInsets.all(2),
                              child : const Icon(FluentIcons.search),
                            ),
                          ),
                        ),
                      ]
                  ),
                  ..._searchWidgets,
                  const SizedBox(width:10),
                  ToggleButton(
                    child: const Text("A",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    checked: _matchCase,
                    onChanged: (value) {
                      setState(() {
                        _matchCase = value;
                      });
                      widget.manager.update(save: false);
                    },
                  ),
                  const SizedBox(width:10),
                  ToggleButton(
                    child: const Text(".*",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    checked: _regexSearch,
                    onChanged: (value) {
                      setState(() {
                        _regexSearch = value;
                      });
                      widget.manager.update(save: false);
                    },
                  ),
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
