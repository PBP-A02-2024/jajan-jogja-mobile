import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jajan_jogja_mobile/nabeel/models/search.dart';
import 'package:intl/intl.dart';

class SearchHistoryDropdown extends StatefulWidget {
  final List<Search> searchList;
  final TextEditingController searchController;
  final Function(Search) onSelected;
  final Function(Search) onEdit;
  final Function(Search) onDelete;

  const SearchHistoryDropdown({
    Key? key,
    required this.searchList,
    required this.searchController,
    required this.onSelected,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  _SearchHistoryDropdownState createState() => _SearchHistoryDropdownState();
}

class _SearchHistoryDropdownState extends State<SearchHistoryDropdown> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<Search> _filteredSearchList = [];
  bool _isOverlayVisible = false;

  void _showOverlay() {
    if (_isOverlayVisible) return; // Prevent showing multiple overlays
    setState(() {
      _filteredSearchList = widget.searchList;
    });
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOverlayVisible = true;
    });
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOverlayVisible = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5), // Adjust the offset to create a gap
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 200, // Set the maximum height for the search history list
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: _filteredSearchList.map((Search search) {
                  String formattedDate = DateFormat('dd/MM/yyyy, HH:mm:ss').format(search.fields.createdAt);
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(search.fields.content, style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)),
                        ),
                        SizedBox(width: 8),
                        Text(
                          formattedDate,
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedPencilEdit02,
                            color: Colors.orange,
                            size: 24.0,
                          ),
                          onPressed: () {
                            widget.onEdit(search);
                            _hideOverlay();
                          },
                        ),
                        IconButton(
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedDelete02,
                            color: Colors.red,
                            size: 24.0,
                          ),
                          onPressed: () {
                            widget.onDelete(search);
                            _hideOverlay();
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      widget.searchController.text = search.fields.content;
                      widget.onSelected(search);
                      _hideOverlay();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _filterSearchList(String query) {
    setState(() {
      _filteredSearchList = widget.searchList
          .where((search) => search.fields.content.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 20),
              controller: widget.searchController,
              decoration: InputDecoration(
                hintText: 'Search resto...',
                hintStyle: TextStyle(color: Color(0xFF7A7A7A), fontSize: 20),
                prefixIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  color: Color(0xFF7A7A7A),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: _isOverlayVisible
                    ? IconButton(
                        icon: Icon(Icons.close, color: Color(0xFF7A7A7A)),
                        onPressed: () {
                          widget.searchController.clear();
                          setState(() {
                            _filteredSearchList = [];
                          });
                          _hideOverlay();
                        },
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 2),
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              onTap: _showOverlay,
              onChanged: (value) {
                if (value.isEmpty) {
                  _hideOverlay();
                } else {
                  _filterSearchList(value);
                  _showOverlay();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}