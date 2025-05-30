import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/di/di.dart';
import 'package:noya_app/core/resuable_comp/custom_tab_bar_widget.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/core/utils/text_style_manager.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:noya_app/presentation/check_out_page/view/check_out_page.dart';
import 'package:noya_app/presentation/tabs/coustom_tab/widgets/custom_product_widget.dart';
import 'package:noya_app/presentation/tabs/coustom_tab/widgets/shimmer_widget.dart';
import 'package:noya_app/presentation/tabs/coustom_tab/view_model/categories_cubit.dart';

class CoustomOrder extends StatefulWidget {
  List<Product>? products;
  num? bundlePrice;

  CoustomOrder({this.bundlePrice, this.products, super.key});

  @override
  State<CoustomOrder> createState() => _CoustomOrderState();
}

class _CoustomOrderState extends State<CoustomOrder>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<CategoriesCubit>()..getCategories(widget.products ?? []),
      child: BlocListener<CategoriesCubit, CategoriesStates>(
        listener: (context, state) {
          if (state is GetCategoriesErrorState) {
            toastMessage(
              message: state.message.toString(),
              tybeMessage: TybeMessage.negative,
            );
          }

          if (state is GetCategoriesSuccessState) {
            _tabController = TabController(
              length: state.categories.length,
              vsync: this,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: Text(
              AppStrings.builYourOwnPackage,
              style: AppTextStyle.medium20,
            ),
          ),
          body: BlocBuilder<CategoriesCubit, CategoriesStates>(
            builder: (context, state) {
              final cubit = CategoriesCubit.get(context);
              if (state is GetCategoriesSuccessState ||
                  state is CategoriesUpdatedState) {
                final selectedCategory =
                    state is GetCategoriesSuccessState
                        ? state.categories[cubit.selectedIndex]
                        : cubit.categories[cubit.selectedIndex];
                final products = selectedCategory.products ?? [];

                if (products.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        AppStrings.noProductsAvailable,
                        style: const TextStyle(color: ColorManager.oliveGreen),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${cubit.itemsCount} ${AppStrings.itemsSelected}",
                                  style: AppTextStyle.regular16,
                                ),
                                Text(
                                  "${AppStrings.total}: ${cubit.total}",
                                  style: AppTextStyle.regular25,
                                ),
                              ],
                            ),
                            const Spacer(),
                            MyButton(
                              label: AppStrings.checkOut,
                              onPressed: (cubit.itemsCount == 0 ||
                                  (widget.bundlePrice != null &&
                                      cubit.total < widget.bundlePrice!))
                                  ? null
                                  : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckOutPage(
                                      checkOutProducts: cubit.selectedProducts,
                                    ),
                                  ),
                                );
                              },

                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTabBar(
                          tabs:
                              cubit.categories
                                  .map((c) => c.categoryName ?? '')
                                  .toList(),
                          onTabChanged: (int index) {
                            _tabController.animateTo(index);
                            setState(() {
                              cubit.selectedIndex = index;
                            });
                          },
                          selectedIndex: cubit.selectedIndex,
                          controller: _tabController,
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: GridView.builder(
                            itemCount: products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 2 / 4,
                                ),
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return CustomProductWidget(
                                categoriesCubit: cubit,
                                isSelected: cubit.isProductSelected(
                                  product.productId,
                                ),
                                product: product,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }

              return shimmerLoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}
