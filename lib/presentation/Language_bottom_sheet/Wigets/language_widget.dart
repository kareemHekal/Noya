// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/presentation/Language_bottom_sheet/Wigets/coustom_circle_check_box.dart';

class LanguageSelectionItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageSelectionItem({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? ColorManager.lightSand : Colors.white,
      elevation: isSelected ? 2 : 0,
      shadowColor: isSelected ? ColorManager.black : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? ColorManager.oliveGreen : ColorManager.white60,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16, color: isSelected ? ColorManager.oliveGreen :  ColorManager.white70,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Spacer(),
              CoustomCircleCheckBox(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }
}
