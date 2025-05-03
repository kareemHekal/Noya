// ignore: unused_import
import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/routes_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/core/utils/text_style_manager.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:noya_app/presentation/check_out_page/view_model/check_out_cubit.dart';
import '../../payment/payment_page.dart';
import 'check_out_product_card.dart';

class CheckOutPage extends StatelessWidget {
  List<Product> checkOutProducts;

  CheckOutPage({required this.checkOutProducts, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteManager.mainScreen);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(AppStrings.checkOut),
      ),
      body: BlocProvider(
        create: (context) => CheckOutCubit()..init(checkOutProducts),
        child: BlocBuilder<CheckOutCubit, CheckOutStates>(
          builder: (context, state) {
            final cubit = CheckOutCubit.get(context);
            final products = cubit.checkOutProducts;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  products.isEmpty
                      ? Expanded(
                        child: Center(child: Text("${AppStrings.noProducts}")),
                      )
                      : Expanded(
                        child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return CheckOutProductCard(
                              product: products[index],
                              onPlus: () {
                                cubit.increaseProductQuantity(
                                  products[index].productId ?? 0,
                                );
                              },
                              onMinus: () {
                                cubit.decreaseProductQuantity(
                                  products[index].productId ?? 0,
                                );
                              },
                              onDelete: () {
                                cubit.removeProduct(
                                  products[index].productId ?? 0,
                                );
                              },
                            );
                          },
                        ),
                      ),
                  Column(
                    spacing: 10,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${AppStrings.total} :",
                            style: AppTextStyle.medium20.copyWith(
                              color: ColorManager.white80,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${cubit.total} ",
                            style: AppTextStyle.medium20.copyWith(
                              color: ColorManager.oliveGreen,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyButton(
                              label: AppStrings.checkOut,
                              onPressed: () {
                                if (products.isEmpty) {
                                  toastMessage(
                                    message: AppStrings.yourOrderIsEmpty,
                                    tybeMessage: TybeMessage.negative,
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PaymentPage(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
