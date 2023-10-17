import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final String value;
  final void Function(String?)? onChanged; // Update the parameter type
  final String hint;

  const CustomDropdownButton({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(20),
      isExpanded: true,
      hint: Text(hint),
      underline: Container(),
      value: value,
      items: items.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged, // Use the passed onChanged callback directly
    );
  }
}
