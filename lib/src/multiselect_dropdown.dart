import 'package:flutter/material.dart';
import 'package:multiselect_dropdown/src/multiselect_dialog.dart';
import 'package:multiselect_dropdown/src/primary_text_field.dart';

class MultiSelectDropDown extends StatefulWidget {
  final String title;
  final List<String> items;
  final Function(String?) onChanged;
  final String? value;
  final String hint;
  final Color? primaryColor;
  final IconData? suffixIcon;
  final String separator;
  final InputDecoration? decoration;

  const MultiSelectDropDown({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    required this.value,
    this.hint = '',
    this.primaryColor,
    this.suffixIcon,
    this.separator = ",,,",
    this.decoration,
  });

  @override
  MultiSelectDropDownState createState() => MultiSelectDropDownState();
}

class MultiSelectDropDownState extends State<MultiSelectDropDown> {
  List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedItems = widget.value!.split(widget.separator);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final title = widget.title;
    final hint = widget.hint;
    final controller = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PrimaryTextField(
            width: width,
            title: title,
            hint: hint,
            primaryColor: widget.primaryColor,
            showSuffixIcon: true,
            isDisabled: true,
            decoration: widget.decoration,
            onTap: () {
              _showMultiSelectDialog(context);
            },
            suffixIcon: widget.suffixIcon ?? Icons.arrow_drop_down,
            controller: controller),
        if (selectedItems.isNotEmpty)
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            // if selected items contains every item in items, show "All"
            children: selectedItems.length == widget.items.length
                ? [
                    Chip(
                      label: const Text('All'),
                      onDeleted: () {
                        setState(() {
                          selectedItems = [];
                          widget.onChanged(selectedItems.join(",,,"));
                        });
                      },
                    ),
                  ]
                : selectedItems.map((item) {
                    return Chip(
                      label: Text(item),
                      onDeleted: () {
                        setState(() {
                          selectedItems.remove(item);
                          widget
                              .onChanged(selectedItems.join(widget.separator));
                        });
                      },
                    );
                  }).toList(),
          ),
      ],
    );
  }

  void _updateState(bool? value, String item) {
    setState(() {
      if (value != null) {
        if (value) {
          selectedItems.add(item);
        } else {
          selectedItems.remove(item);
        }
      }
      widget.onChanged(selectedItems.join(widget.separator));
    });
  }

  void _showMultiSelectDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          title: widget.title,
          items: widget.items,
          selectedItems: List.from(selectedItems),
          onChanged: (List<String> newItems) {
            setState(() {
              selectedItems = newItems;
              widget.onChanged(selectedItems.join(widget.separator));
            });
          },
        );
      },
    );
  }
}
