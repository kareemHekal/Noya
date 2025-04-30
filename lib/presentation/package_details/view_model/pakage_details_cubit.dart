// ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/data/models/product.dart';

part 'pakage_details_States.dart';

@injectable
class PackageDetailsCubit extends Cubit<PackageDetailsState> {
  @factoryMethod
  PackageDetailsCubit() : super(Initial());

  List<Product> products = [];

  static PackageDetailsCubit get(context) => BlocProvider.of(context);

  addProductIfNotExists(Product product) {
    final index = products.indexWhere((p) => p.productId == product.productId);

    if (index == -1) {
      final newProduct = Product(
        productId: product.productId,
        productName: product.productName,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        quantity: product.quantity ?? 1,
      );
      products.add(newProduct);
      emit(ProductAddedState(newProduct));
    }
  }

  increaseProductQuantity(num productId) {
    final index = products.indexWhere((p) => p.productId == productId);

    if (index != -1) {
      final existingProduct = products[index];
      final updatedProduct = Product(
        category: existingProduct.category,
        categoryId: existingProduct.categoryId,
        stock: existingProduct.stock,
        productId: existingProduct.productId,
        productName: existingProduct.productName,
        description: existingProduct.description,
        imageUrl: existingProduct.imageUrl,
        price: existingProduct.price,
        quantity: (existingProduct.quantity ?? 0) + 1,
      );
      products[index] = updatedProduct;
      emit(ProductQuantityUpdatedState(updatedProduct));
    }
  }

  decreaseProductQuantity(num productId) {
    final index = products.indexWhere((p) => p.productId == productId);

    if (index != -1) {
      final existingProduct = products[index];
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
        products[index] = updatedProduct;
        emit(ProductQuantityUpdatedState(updatedProduct));
      } else {
        products.removeAt(index);
        emit(ProductRemovedState(existingProduct));
      }
    }
  }
  Product? getProductById(num productId) {
    try {
      return products.firstWhere((p) => p.productId == productId);
    } catch (e) {
      return null;
    }
  }

}
