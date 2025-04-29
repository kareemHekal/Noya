import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/core/utils/text_style_manager.dart';
import 'package:noya_app/data/models/bundle_response.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/colors_manager.dart' show ColorManager;

class ProductCard extends StatelessWidget {
  BundleResponse bundleResponse;

  ProductCard({Key? key, required this.bundleResponse}) : super(key: key);

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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: ColorManager.oliveGreen,
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
              child: CachedNetworkImage(
                imageUrl: bundleResponse.imageUrl ?? "",
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        color: Colors.white,
                      ),
                    ),
                errorWidget:
                    (context, url, error) => const Center(
                      child: Icon(Icons.error, color: Colors.red),
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
                    bundleResponse.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Price and Installment
                  Text(
                    bundleResponse.price.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
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

                  Text("${bundleResponse.bundleItems?.length} ${AppStrings.items}",style: AppTextStyle.medium14,),

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
                          backgroundColor: ColorManager.lightSand,
                          side: const BorderSide(
                            color: ColorManager.oliveGreen,
                          ),
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
