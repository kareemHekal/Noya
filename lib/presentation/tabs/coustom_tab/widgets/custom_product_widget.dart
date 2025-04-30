import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:shimmer/shimmer.dart';

class CustomProductWidget extends StatelessWidget {
  Product product;
  bool isSelected;

  CustomProductWidget({
    required this.isSelected,
    required this.product,
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: isSelected
          ? ColorManager.mutedSageGreen
          : ColorManager.lightSand,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isSelected
              ? ColorManager.mutedSageGreen
              : ColorManager.lightSand,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl ?? "",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(color: Colors.white),
                    ),
                    errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error, color: Colors.red)),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            product.productName ?? "No Name",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: ColorManager.oliveGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${product.description}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: ColorManager.mutedSageGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                "${product.price?.toStringAsFixed(2) ?? '0.00'} EGP",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: ColorManager.mutedSageGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? ColorManager.mutedSageGreen
                                        : ColorManager.oliveGreen,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  color: isSelected
                                      ? ColorManager.mutedSageGreen
                                      : ColorManager.oliveGreen,
                                ),
                                child: Icon(
                                  color: Colors.white,
                                  isSelected ? Icons.done_outlined : Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Overlay when selected
          if (isSelected)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.oliveGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle,
                    size: 48,
                    color: ColorManager.oliveGreen,
                  ),
                ),
              ),
            ),
        ],
      ),

    );
  }
}
