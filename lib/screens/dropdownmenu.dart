import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class MyDropdownWidget extends StatefulWidget {
  @override
  _MyDropdownWidgetState createState() => _MyDropdownWidgetState();
}

class _MyDropdownWidgetState extends State<MyDropdownWidget> {
  String? selectedFirstDropdownValue;
  String? selectedSecondDropdownValue;
  Map<String, List<String>> secondDropdownItems = {
    'Category1': ['Item1', 'Item2', 'Item3'],
    'Category2': ['Item4', 'Item5', 'Item6'],
    // Add other categories and their respective items here
  };
  List<String>? currentSecondDropdownItems;

  @override
  Widget build(BuildContext context) {
    List<String> firstDropdownItems = [
      'Category1',
      'Category2'
    ]; // Your categories

    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select Category',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: firstDropdownItems.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              );
            }).toList(),
            value: selectedFirstDropdownValue,
            onChanged: (String? value) {
              setState(() {
                selectedFirstDropdownValue = value;
                currentSecondDropdownItems = secondDropdownItems[value];
                selectedSecondDropdownValue = null; // Reset second dropdown
              });
            },
            buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                )),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
        if (currentSecondDropdownItems != null)
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: currentSecondDropdownItems!.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                );
              }).toList(),
              value: selectedSecondDropdownValue,
              onChanged: (String? value) {
                setState(() {
                  selectedSecondDropdownValue = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  )),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
      ],
    );
  }
}
