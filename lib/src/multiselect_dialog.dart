import 'package:flutter/material.dart';

class MultiSelectDialog extends StatefulWidget {
  final String title;
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onChanged;

  const MultiSelectDialog({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
  });

  @override
  MultiSelectDialogState createState() => MultiSelectDialogState();
}

class MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> localSelectedItems;
  late TextEditingController searchController;
  bool selectAll = false;
  List<String> temporaryItems = [];

  @override
  void initState() {
    super.initState();
    localSelectedItems = List.from(widget.selectedItems);
    searchController = TextEditingController();
    temporaryItems = List.from(widget.items);
    selectAll = localSelectedItems.length == temporaryItems.length;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(widget.title),
          const SizedBox(height: 8.0),
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              _filterItems(value);
            },
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              _toggleSelectAll();
            },
            child: Text(selectAll ? 'Unselect All' : 'Select All'),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: temporaryItems.map((item) {
            return CheckboxListTile(
              title: item == "true"
                  ? const Text("Yes")
                  : item == "false"
                      ? const Text("No")
                      : Text(item),
              value: localSelectedItems.contains(item),
              onChanged: (bool? value) {
                _updateStateInDialog(value, item);
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onChanged(localSelectedItems);
            Navigator.of(context).pop();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  void _updateStateInDialog(bool? value, String item) {
    setState(() {
      if (value != null) {
        if (value) {
          localSelectedItems.add(item);
        } else {
          localSelectedItems.remove(item);
        }
      }
      selectAll = localSelectedItems.length == temporaryItems.length;
    });
  }

  void _filterItems(String query) {
    setState(() {
      temporaryItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
      selectAll = localSelectedItems.length == temporaryItems.length;
    });
  }

  void _toggleSelectAll() {
    setState(() {
      if (selectAll) {
        localSelectedItems = [];
      } else {
        localSelectedItems = List.from(temporaryItems);
      }
      selectAll = !selectAll;
    });
  }
}
