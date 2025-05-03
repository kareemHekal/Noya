import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';

class AlsoAvaliable extends StatelessWidget {
  final String label;
  final String description;
  final VoidCallback? onPressed;

  AlsoAvaliable({
    required this.onPressed,
    required this.label,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 5,
          color: ColorManager.lightSand,
          shadowColor: ColorManager.offWhite,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ColorManager.oliveGreen),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.oliveGreen,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorManager.mutedSageGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
