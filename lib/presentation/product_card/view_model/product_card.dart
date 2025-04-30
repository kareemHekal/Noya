import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/di/di.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:noya_app/presentation/package_details/view_model/pakage_details_cubit.dart';
import 'package:noya_app/presentation/product_card/view_model/cubit/product_card_intent.dart';
import 'package:noya_app/presentation/product_details.dart';
import 'package:shimmer/shimmer.dart';
import 'cubit/product_card_cubit.dart';

class ProductCard extends StatelessWidget {
  final num? productId;
  final num? quantity;
  final PackageDetailsCubit packageDetailsCubit;

  const ProductCard({
    required this.packageDetailsCubit,
    required this.productId,
    required this.quantity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              getIt<ProductByIdCubit>()
                ..doIntent(GetProductCardIntent(productId: productId)),
      child: BlocListener<ProductByIdCubit, ProductCardState>(
        listener: (context, state) {
          if (state is GetProductCardErrorState) {
            toastMessage(
              message: state.message ?? "Something went wrong",
              tybeMessage: TybeMessage.negative,
            );
          }
        },
        child: BlocBuilder<ProductByIdCubit, ProductCardState>(
          builder: (context, state) {
            if (state is GetProductCardLoadingState) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }

            if (state is GetProductCardStateSuccessState &&
                state.product != null) {
              final product = state.product!;
              final updatedProduct = Product(
                categoryId: product.categoryId,
                stock: product.stock,
                productId: productId,
                category: product.category,
                productName: product.productName,
                description: product.description,
                imageUrl: product.imageUrl,
                price: product.price,
                quantity: quantity,
              );
              packageDetailsCubit.addProductIfNotExists(updatedProduct);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => ProductDetailsPage(
                            packageDetailsCubit: packageDetailsCubit,
                            product: updatedProduct,
                          ),
                    ),
                  );
                },
                child: Card(
                  color: ColorManager.lightSand,
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
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
                      ),
                      // Product Info
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
                                    "${product.price?.toStringAsFixed(2) ?? '0.00'} EGP",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: ColorManager.mutedSageGreen,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    " ${AppStrings.quantity} ${product.quantity.toString()}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: ColorManager.oliveGreen,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Default or Error State
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
