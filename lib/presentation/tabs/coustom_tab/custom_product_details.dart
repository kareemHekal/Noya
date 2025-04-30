import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/back_icon.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:noya_app/presentation/tabs/coustom_tab/view_model/categories_cubit.dart';
import 'package:shimmer/shimmer.dart';

class CustomProductDetailsPage extends StatefulWidget {
  final Product product;
  final CategoriesCubit cubit;

  const CustomProductDetailsPage({
    required this.cubit,
    super.key,
    required this.product,
  });

  @override
  State<CustomProductDetailsPage> createState() =>
      _CustomProductDetailsPageState();
}

class _CustomProductDetailsPageState extends State<CustomProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final updatedProduct = widget.cubit.getProductById(
      widget.product.productId!,
    );
    var currentQuantity = updatedProduct?.quantity ?? 1;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.imageUrl ?? "",
                width: double.infinity,
                height: 250,
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
              const Padding(padding: EdgeInsets.all(16.0), child: BackIcon()),
            ],
          ),
          Expanded(
            child: Container(
              color: ColorManager.lightSand,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.productName ?? "Product Name",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.category ?? "Category",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${widget.product.price?.toStringAsFixed(2) ?? "0.00"}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${widget.product.stock ?? 0} ${AppStrings.inStock}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppStrings.description,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.description ?? "No description available",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        if (updatedProduct != null)
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed:
                                      currentQuantity > 1
                                          ? () {
                                            setState(() {
                                              widget.cubit
                                                  .decreaseProductQuantity(
                                                    widget.product.productId!,
                                                  );
                                            });
                                          }
                                          : null,
                                ),
                                Text(
                                  currentQuantity.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      widget.cubit.increaseProductQuantity(
                                        widget.product.productId!,
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(width: 16),
                        Expanded(
                          child: MyButton(
                            label:updatedProduct == null? AppStrings.addToCart :AppStrings.removeFromCart,
                            onPressed: () {updatedProduct == null?
                              widget.cubit.addProduct(widget.product):
                              widget.cubit.removeProduct(widget.product.productId!);
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
