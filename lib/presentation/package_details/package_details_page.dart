import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/resuable_comp/back_icon.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/data/models/bundle_response.dart';
import 'package:shimmer/shimmer.dart';
import '../product_card/product_card.dart';
import 'view_model/pakage_details_cubit.dart';

class PackageDetailsPage extends StatelessWidget {
  final PackageDetailsCubit packageDetailsCubit;
  final BundleResponse bundle;

  const PackageDetailsPage({required this.packageDetailsCubit, required this.bundle, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                if (bundle.imageUrl != null)
                  Container(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: bundle.imageUrl ?? "",
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                    ),
                  ),
                // Name and price above image
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BackIcon(),
                        const Spacer(),
                        Text(
                          bundle.name ?? "No Name",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.oliveGreen,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${bundle.price ?? 0} EGP",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.oliveGreen,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Product list
          bundle.bundleItems?.isNotEmpty == true
              ? Expanded(
                flex: 3,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: bundle.bundleItems!.length,
                  itemBuilder: (context, index) {
                    final item = bundle.bundleItems![index];
                    return ProductCard(
                      packageDetailsCubit: packageDetailsCubit,
                        quantity: item.quantity,productId: item.productId);
                  },
                ),
              )
              : Center(
                child: Text(
                  AppStrings.noProducts,
                  style: const TextStyle(color: ColorManager.oliveGreen, fontSize: 20),
                ),
              ),

          // Buttons at the bottom
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Customize"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MyButton(label: AppStrings.checkOut, onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
