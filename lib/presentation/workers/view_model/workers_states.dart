// ignore_for_file: must_be_immutable

part of 'workers_cubit.dart';


@immutable
sealed class WorkersStates {}

final class Initial extends WorkersStates {}

final class WorkersUpdatedState extends WorkersStates {}


final class GetWorkersSuccessState extends WorkersStates {
  List<WorkerModel> workers;

  GetWorkersSuccessState({required this.workers});
}

final class GetWorkersLoadingState extends WorkersStates {}

final class GetWorkersErrorState extends WorkersStates {
  String? message;

  GetWorkersErrorState({required this.message});
}
