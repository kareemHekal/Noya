import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/string_manager.dart';

import '../utils/colors_manager.dart' show ColorManager;

class ProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String installmentOption;
  final String description;
  final List<String> includes;
  final String imagePath;

  const ProductCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.installmentOption,
    required this.description,
    required this.includes,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with "POPULAR" tag
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: ColorManager.pistachio,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(
                AppStrings.popular, // 🔁 replaced
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            // Image
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Subtitle
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: ColorManager.white80),
                  ),
                  const SizedBox(height: 12),

                  // Price and Installment
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    installmentOption,
                    style: const TextStyle(fontSize: 14, color: ColorManager.white80),
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: ColorManager.white80),
                  ),
                  const SizedBox(height: 12),

                  // Includes
                  Text(
                    AppStrings.includes, // 🔁 replaced
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: ColorManager.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Display first 3 items
                  ...includes
                      .take(3)
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.check,
                                size: 16,
                                color: ColorManager.black,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: ColorManager.white80,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                  if (includes.length > 3)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '+${includes.length - 3} ${AppStrings.more}',
                        // 🔁 replaced
                        style: const TextStyle(
                          fontSize: 14,
                          color: ColorManager.white80,

                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.viewDetails, // 🔁 replaced
                          style: const TextStyle(color: ColorManager.black),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(

                          side: const BorderSide(color: ColorManager.black),
                        ),
                        child: Text(
                          AppStrings.customize, // 🔁 replaced
                          style: const TextStyle(color: ColorManager.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
