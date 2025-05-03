// ignore_for_file: must_be_immutable

part of 'materials_cubit.dart';


@immutable
sealed class MaterialsStates {}

final class Initial extends MaterialsStates {}

final class MaterialsUpdatedState extends MaterialsStates {}


final class GetMaterialsSuccessState extends MaterialsStates {
  List<MaterialModel> materials;

  GetMaterialsSuccessState({required this.materials});
}

final class GetMaterialsLoadingState extends MaterialsStates {}

final class GetMaterialsErrorState extends MaterialsStates {
  String? message;

  GetMaterialsErrorState({required this.message});
}
