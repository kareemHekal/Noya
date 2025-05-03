// ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/bundle_response.dart';
import 'package:noya_app/domain/usecases/get_bundle_list_usecase.dart';
import 'bundle_intent.dart';

part 'bundle_state.dart';

@injectable
class BundleCubit extends Cubit<BundleState> {
  GetBundleListUseCase bundlesUsecase ;
  @factoryMethod

  BundleCubit(this.bundlesUsecase) : super(Initial());

  void doIntent(BundleIntent intent) {
    switch (intent) {
      case GetBundleListIntent():
        _getBundles(intent: intent);
        break;
    }
  }

  static BundleCubit get(context) => BlocProvider.of(context);

  _getBundles({required GetBundleListIntent intent}) async {
    emit(GetBundlesLoadingState());
    final result = await bundlesUsecase.invoke();
    switch (result) {
      case SuccessApiResult():
        emit(GetBundlesSuccessState(bundles: result.data ?? []));
        break;
      case ErrorApiResult():
        emit(GetBundlesErrorState(message: result.exception.toString()));
        break;
    }
  }
}
