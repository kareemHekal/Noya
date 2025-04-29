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
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 3,
          color: Colors.white,
          shadowColor: ColorManager.white70,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color:ColorManager.white70),
            borderRadius: BorderRadius.circular(15), // Rounded corners
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
                    color: Colors.black,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
