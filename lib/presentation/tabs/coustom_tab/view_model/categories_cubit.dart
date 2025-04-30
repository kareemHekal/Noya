// ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/categories_response.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:noya_app/domain/usecases/get_categories_list_usecase.dart';

part 'categories_states.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesStates> {
  GetCategoriesListUseCase categoriesUsecase;

  @factoryMethod
  CategoriesCubit(this.categoriesUsecase) : super(Initial());

  List<Product> selectedProducts = [];
  int itemsCount = 0;
  num total = 0;
  int selectedIndex = 0;
  static CategoriesCubit get(context) => BlocProvider.of(context);

  getCategories() async {
    emit(GetCategoriesLoadingState());
    final result = await categoriesUsecase.invoke();
    switch (result) {
      case SuccessApiResult():
        emit(GetCategoriesSuccessState(categories: result.data ?? []));
        break;
      case ErrorApiResult():
        emit(GetCategoriesErrorState(message: result.exception.toString()));
        break;
    }
  }
}
