import 'package:fluent_ui/fluent_ui.dart';
import '../search_enum.dart';
import './search_dropdown_item.dart';

class SearchDropDown extends StatefulWidget {
  final List<SearchDropDownItem<SearchType>> items;
  final void Function(SearchType) onChanged;

  const SearchDropDown({
    Key? key,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  State<SearchDropDown> createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown> {
  var _icon = FluentIcons.align_justify;
  var _title = "검색 기준";
  final items = <MenuFlyoutItem>[];

  @override
  void initState() {
    super.initState();
    for(var item in widget.items) {
      _add(item);
    }

    _title = widget.items[0].title;
  }

  _add(SearchDropDownItem<SearchType> item) {
    var dropDownItem = DropDownButtonItem(
        title : Text(item.title),
        leading: Icon(item.icon),
        onTap: () {
          setState(() {
            _icon = item.icon;
            _title = item.title;
          });

          widget.onChanged(item.value);
        }
    );

    items.add(dropDownItem);
  }

  @override
  Widget build(BuildContext context) {
    return DropDownButton(
      title: Row(
          children: [
            Icon(_icon),
            const SizedBox(width: 10),
            Text(_title),
          ]
      ),
      items: items,
    );
  }
}