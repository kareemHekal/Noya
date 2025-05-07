import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';

class ProfileCard extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ProfileCard({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 3,
        shadowColor: Colors.black,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ColorManager.oliveGreen,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: ColorManager.oliveGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
