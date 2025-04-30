  // ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:injectable/injectable.dart';
  import 'package:flutter/material.dart';
  import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/string_manager.dart';
  import 'package:noya_app/data/models/categories_response.dart';
  import 'package:noya_app/data/models/product.dart';
  import 'package:noya_app/domain/usecases/get_categories_list_usecase.dart';

  part 'categories_states.dart';

  @injectable
  class CategoriesCubit extends Cubit<CategoriesStates> {
    GetCategoriesListUseCase categoriesUsecase;
     List<CategoriesResponse> categories=[];

    @factoryMethod
    CategoriesCubit(this.categoriesUsecase) : super(Initial());

    List<Product> selectedProducts = [];
    int get itemsCount => selectedProducts.length;
    num get total {
      num sum = 0;
      for (var product in selectedProducts) {
        sum += (product.quantity ?? 1) * (product.price ?? 0);
      }
      return sum;
    }
    int selectedIndex = 0;
    static CategoriesCubit get(context) => BlocProvider.of(context);

    getCategories() async {
      emit(GetCategoriesLoadingState());
      final result = await categoriesUsecase.invoke();
      switch (result) {
        case SuccessApiResult():
          emit(GetCategoriesSuccessState(categories: result.data ?? []));
          categories = result.data ?? [];
          break;
        case ErrorApiResult():
          emit(GetCategoriesErrorState(message: result.exception.toString()));
          break;
      }
    }

    bool isProductSelected(num? productId) {
      return selectedProducts.any((product) => product.productId == productId);
    }


    addProduct(Product product) {
      final exists = selectedProducts.any((p) => p.productId == product.productId);
      if (!exists) {
        selectedProducts.add(product);
        emit(CategoriesUpdatedState());
      } else {
        toastMessage(message: AppStrings.itsAlreadyAdded, tybeMessage: TybeMessage.negative);
      }
    }


    removeProduct(Product product) {
      selectedProducts.removeWhere((p) => p.productId == product.productId);
      emit(CategoriesUpdatedState());
    }





    increaseProductQuantity(num productId) {
      final index = selectedProducts.indexWhere((p) => p.productId == productId);
      if (index != -1) {
        final existingProduct = selectedProducts[index];
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
        selectedProducts[index] = updatedProduct;
        emit(CategoriesUpdatedState());
      }
    }

    decreaseProductQuantity(num productId) {
      final index = selectedProducts.indexWhere((p) => p.productId == productId);

      if (index != -1) {
        final existingProduct = selectedProducts[index];
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
          selectedProducts[index] = updatedProduct;
          emit(CategoriesUpdatedState());
        }
        else {
          selectedProducts.removeAt(index);
          emit(CategoriesUpdatedState());

        }
      }
    }

    Product? getProductById(num productId) {
      try {
        return selectedProducts.firstWhere((p) => p.productId == productId);
      } catch (e) {
        return null;
      }
    }


  }
