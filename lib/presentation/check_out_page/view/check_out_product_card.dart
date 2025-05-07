import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:shimmer/shimmer.dart';

class CheckOutProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onDelete;

  const CheckOutProductCard({
    super.key,
    required this.product,
    required this.onPlus,
    required this.onMinus,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    num quantity = product.quantity ?? 1;

    return Card(
      color: ColorManager.softBeige,
      elevation: 5,
      shadowColor: ColorManager.oliveGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl ?? "",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(color: Colors.white),
                    ),
                errorWidget:
                    (context, url, error) => const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Delete
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.productName ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            color: ColorManager.white80,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          onDelete();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Price
                  Text(
                    "${product.price ?? 0} EGP",
                    style: const TextStyle(
                      fontSize: 16,
                      color: ColorManager.oliveGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Quantity Controls
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorManager.white60,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed:
                              quantity > 1
                                  ? () {
                                    onMinus();
                                    quantity--;
                                  }
                                  : null,
                          icon: const Icon(Icons.remove),
                          visualDensity: VisualDensity.compact,
                          color: ColorManager.oliveGreen,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: ColorManager.oliveGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorManager.white60,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            onPlus();
                            quantity++;
                          },
                          icon: const Icon(Icons.add),
                          visualDensity: VisualDensity.compact,
                          color: ColorManager.oliveGreen,

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
