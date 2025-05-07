import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/provider.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/resuable_comp/back_icon.dart';
import '../package_details/view_model/pakage_details_cubit.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final PackageDetailsCubit packageDetailsCubit;

  const ProductDetailsPage({
    required this.packageDetailsCubit,
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  num quantity = 1;

  @override
  void initState() {
    super.initState();
    quantity = widget.product.quantity ?? 1;
    print(quantity);
  }

  @override
  Widget build(BuildContext context) {
    final updatedProduct = widget.packageDetailsCubit.getProductById(
      widget.product.productId!,
    );

    final currentQuantity = updatedProduct?.quantity ?? quantity;
    var dataProvider = Provider.of<DataProvider>(context);

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
              color:
                  dataProvider.isDarkMode
                      ? ColorManager.deepCharcoalWithGreenHint
                      : ColorManager.lightSand,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
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
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            !dataProvider.isDarkMode
                                ? ColorManager.deepCharcoalWithGreenHint
                                : ColorManager.lightSand,
                      ),
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
                            color:
                                !dataProvider.isDarkMode
                                    ? ColorManager.deepCharcoalWithGreenHint
                                    : ColorManager.lightSand,
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
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            !dataProvider.isDarkMode
                                ? ColorManager.deepCharcoalWithGreenHint
                                : ColorManager.lightSand,
                      ),
                    ),
                    const Spacer(),

                    // Add to cart section
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Card(
                            color: ColorManager.mutedSageGreen,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 30,
                                    color: ColorManager.lightSand,
                                  ),
                                  onPressed:
                                      currentQuantity > 1
                                          ? () {
                                            setState(() {
                                              widget.packageDetailsCubit
                                                  .decreaseProductQuantity(
                                                    widget.product.productId!,
                                                  );
                                            });
                                          }
                                          : null,
                                ),
                                Text(
                                  currentQuantity.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: ColorManager.oliveGreen,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    size: 30,
                                    color: ColorManager.lightSand,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.packageDetailsCubit
                                          .increaseProductQuantity(
                                            widget.product.productId!,
                                          );
                                    });
                                    print(widget.packageDetailsCubit.products);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
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
