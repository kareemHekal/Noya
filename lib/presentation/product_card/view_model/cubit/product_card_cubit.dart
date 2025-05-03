// ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:noya_app/domain/usecases/get_product_by_id_usecase.dart';
import 'product_card_intent.dart';

part 'product_card_state.dart';

@injectable
class ProductByIdCubit extends Cubit<ProductCardState> {
  GetProductByIdUsecase usecase ;
  @factoryMethod

  ProductByIdCubit(this.usecase) : super(Initial());

  void doIntent(ProductCardIntent intent) {
    switch (intent) {
      case GetProductCardIntent():
        _getProductById(intent: intent);
        break;
    }
  }

  static ProductByIdCubit get(context) => BlocProvider.of(context);

  _getProductById({required GetProductCardIntent intent}) async {
    emit(GetProductCardLoadingState());
    final result = await usecase.invoke(productId: intent.productId);
    switch (result) {
      case SuccessApiResult():
        emit(GetProductCardStateSuccessState(product: result.data));
        break;
      case ErrorApiResult():
        emit(GetProductCardErrorState(message: result.exception.toString()));
        break;
    }
  }
}
