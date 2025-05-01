// ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/data/models/product.dart';

part 'check_out_stats.dart';

@injectable
class CheckOutCubit extends Cubit<CheckOutStates> {
  @factoryMethod
  CheckOutCubit() : super(Initial());

  List<Product> checkOutProducts = [];

  int get itemsCount {
    num sum = 0;
    for (var product in checkOutProducts) {
      sum += product.quantity ?? 0;
    }
    return sum.toInt();
  }

  num get total {
    num sum = 0;
    for (var product in checkOutProducts) {
      sum += (product.quantity ?? 1) * (product.price ?? 0);
    }
    return sum;
  }

  static CheckOutCubit get(context) => BlocProvider.of(context);

  init(List<Product> checkOutProducts) {
    this.checkOutProducts = checkOutProducts;
  }

  removeProduct(num? productId) {
    checkOutProducts.removeWhere((p) => p.productId == productId);
    emit(CheckOutUpdatedState());
  }

  increaseProductQuantity(num productId) {
    final index = checkOutProducts.indexWhere((p) => p.productId == productId);
    if (index != -1) {
      final existingProduct = checkOutProducts[index];
      final updatedProduct = Product(
        category: existingProduct.category,
        categoryId: existingProduct.categoryId,
        stock: existingProduct.stock,
        productId: productId,
        productName: existingProduct.productName,
        description: existingProduct.description,
        imageUrl: existingProduct.imageUrl,
        price: existingProduct.price,
        quantity: (existingProduct.quantity ?? 0) + 1,
      );
      checkOutProducts[index] = updatedProduct;
      emit(CheckOutUpdatedState());
    }
  }

  decreaseProductQuantity(num productId) {
    final index = checkOutProducts.indexWhere((p) => p.productId == productId);

    if (index != -1) {
      final existingProduct = checkOutProducts[index];
      final newQuantity = (existingProduct.quantity ?? 1) - 1;

      if (newQuantity > 0) {
        final updatedProduct = Product(
          category: existingProduct.category,
          categoryId: existingProduct.categoryId,
          stock: existingProduct.stock,
          productId: existingProduct.productId,
          productName: existingProduct.productName,
          description: existingProduct.description,
          imageUrl: existingProduct.imageUrl,
          price: existingProduct.price,
          quantity: newQuantity,
        );
        checkOutProducts[index] = updatedProduct;
        emit(CheckOutUpdatedState());
      } else {
        checkOutProducts.removeAt(index);
        emit(CheckOutUpdatedState());
      }
    }
  }
}
