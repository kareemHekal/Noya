// ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/material_model.dart';
import 'package:noya_app/domain/usecases/get_materials_list_usecase.dart';

part 'materials_states.dart';

@injectable
class MaterialsCubit extends Cubit<MaterialsStates> {
  GetMaterialsListUseCase materialsUsecase;
  List<MaterialModel> materials = [];

  @factoryMethod
  MaterialsCubit(this.materialsUsecase) : super(Initial());

  static MaterialsCubit get(context) => BlocProvider.of(context);

  getMaterials() async {
    emit(GetMaterialsLoadingState());
    final result = await materialsUsecase.invoke();
    switch (result) {
      case SuccessApiResult():
        emit(GetMaterialsSuccessState(materials: result.data ?? []));
        materials = result.data ?? [];
        break;
      case ErrorApiResult():
        emit(GetMaterialsErrorState(message: result.exception.toString()));
        break;
    }
  }
}
