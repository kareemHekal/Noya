// ignore_for_file: must_be_immutable

part of 'product_card_cubit.dart';

@immutable
sealed class ProductCardState {}

final class Initial extends ProductCardState {}

final class GetProductCardStateSuccessState extends ProductCardState {
  Product? product;

  GetProductCardStateSuccessState({required this.product});
}

final class GetProductCardLoadingState extends ProductCardState {}

final class GetProductCardErrorState extends ProductCardState {
  String? message;

  GetProductCardErrorState({required this.message});
}


