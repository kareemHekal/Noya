// ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/WorkerModel.dart';
import 'package:noya_app/domain/usecases/get_workers_list_usecase.dart';

part 'workers_states.dart';

@injectable
class WorkersCubit extends Cubit<WorkersStates> {
  GetWorkersListUsecase workersUsecase;
  List<WorkerModel> workers = [];

  @factoryMethod
  WorkersCubit(this.workersUsecase) : super(Initial());

  static WorkersCubit get(context) => BlocProvider.of(context);

  getWorkers() async {
    emit(GetWorkersLoadingState());
    final result = await workersUsecase.invoke();
    switch (result) {
      case SuccessApiResult():
        emit(GetWorkersSuccessState(workers: result.data ?? []));
        workers = result.data ?? [];
        break;
      case ErrorApiResult():
        emit(GetWorkersErrorState(message: result.exception.toString()));
        break;
    }
  }
}
