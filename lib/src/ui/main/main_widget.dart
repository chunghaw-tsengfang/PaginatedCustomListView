import 'package:flutter/material.dart';
import 'package:paginatedlistview/paginatedlistview.dart';
import 'package:paginatedlistview/src/ui/footer/listfooter_widget.dart';
import 'package:paginatedlistview/src/utils/callbacks.dart';

class SearchablePaginatedListView extends StatefulWidget {
  final int totalpages;
  final int currentPage;
  final String perPage;
  final List<Header> headers;
  final int sortIndex;
  final bool sortAscending;
  final List<ListRowWidget> rows;
  final int items;
  final int totalItems;
  final Color bgcolor;

  /// Callbacks
  final PageChangeCallback onPageChange;
  final ChangePerCallback onPerChangePressed;
  final SortCallback onSort;

  SearchablePaginatedListView({
    Key key,
    @required this.totalpages,
    @required this.currentPage,
    @required this.items,
    @required this.totalItems,
    @required this.headers,
    @required this.sortIndex,
    @required this.sortAscending,
    @required this.perPage,
    @required this.rows,
    this.bgcolor,
    this.onPageChange,
    this.onSort,
    this.onPerChangePressed,
  })  : assert(sortIndex >= 0, "Sort Index cannot be negative"),
        assert(sortIndex <= headers.length - 1,
            "Sort index cannot be larger than header length"),
        assert(currentPage <= totalpages,
            "Current page cannot be larger than total pages"),
        super(key: key);

  @override
  _SearchablePaginatedListViewState createState() =>
      _SearchablePaginatedListViewState();
}

class _SearchablePaginatedListViewState
    extends State<SearchablePaginatedListView> {
  _createListData() {
    if (widget.rows.length == 0) {
      return Text("No data");
    } else {
      assert(widget.headers.length == widget.rows[0].cells.length,
          "Header length not equal the Row length");
      return ListView(shrinkWrap: true, children: widget.rows);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                color: widget.bgcolor,
                // Separating header and rows for fixed header
                child: Column(children: [
                  ListHeaderWidget(
                      headers: widget.headers,
                      sortAscending: widget.sortAscending,
                      sortingIndex: widget.sortIndex,
                      onSort: widget.onSort),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: (widget.headers.length * 275.0),
                        child: _createListData(),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListFooterWidget(
                onPerChangePressed: widget.onPerChangePressed,
                onPageChanged: widget.onPageChange,
                perPage: widget.perPage,
                totalPages: widget.totalpages,
                currentPage: widget.currentPage,
              ))
        ],
      ),
    );
  }
}
