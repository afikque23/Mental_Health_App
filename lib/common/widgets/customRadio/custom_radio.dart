import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final String label;
  final int groupValue; // Change to int
  final int value; // Change to int
  final ValueChanged<int> onChanged;

  const CustomRadio({
    super.key,
    required this.label,
    required this.groupValue,
    required this.onChanged,
    required this.value, // Use int value here
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = groupValue == value;

    return GestureDetector(
      onTap: () => onChanged(value), // Pass int value instead of string
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        width: 240,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.grey,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16.0),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.teal : Colors.grey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
