import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paginatedlistview/src/utils/Callbacks.dart';

class SearchableHeader extends StatefulWidget {
  /// Label
  final String label;
  final String keyName;
  final SearchCallback filterSearch;

  SearchableHeader(
      {Key key,
      @required this.label,
      @required this.filterSearch,
      @required this.keyName})
      : super(key: key);

  @override
  _SearchableHeaderState createState() => _SearchableHeaderState();
}

class _SearchableHeaderState extends State<SearchableHeader> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        widget.filterSearch(widget.keyName, value);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.label,
      ),
    );
  }
}
