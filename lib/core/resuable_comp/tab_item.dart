import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';

class TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;

  const TabItem({
    required this.label,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? ColorManager.oliveGreen : ColorManager.lightSand,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? ColorManager.oliveGreen : ColorManager.lightSand,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? ColorManager.lightSand : ColorManager.oliveGreen,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}