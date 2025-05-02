import 'package:flutter/material.dart';

class FeatureChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Function(bool) onSelected;

  const FeatureChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      backgroundColor: Colors.grey.shade100,
      labelStyle: TextStyle(
        color: selected ? Theme.of(context).primaryColor : Colors.grey.shade800,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: selected ? Theme.of(context).primaryColor : Colors.grey.shade300,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      visualDensity: VisualDensity.compact,
    );
  }
}