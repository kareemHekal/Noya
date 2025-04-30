// ignore_for_file: must_be_immutable

part of 'categories_cubit.dart';


@immutable
sealed class CategoriesStates {}

final class Initial extends CategoriesStates {}

final class GetCategoriesSuccessState extends CategoriesStates {
  List<CategoriesResponse> categories;

  GetCategoriesSuccessState({required this.categories});
}

final class GetCategoriesLoadingState extends CategoriesStates {}

final class GetCategoriesErrorState extends CategoriesStates {
  String? message;

  GetCategoriesErrorState({required this.message});
}
