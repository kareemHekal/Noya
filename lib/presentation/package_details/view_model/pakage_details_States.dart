// ignore_for_file: must_be_immutable

part of 'pakage_details_cubit.dart';


@immutable
sealed class PackageDetailsState {}

final class Initial extends PackageDetailsState {}

class ProductAddedState extends PackageDetailsState {
  final Product product;
  ProductAddedState(this.product);
}

class ProductRemovedState extends PackageDetailsState {
  final Product product;
  ProductRemovedState(this.product);
}

class ProductQuantityUpdatedState extends PackageDetailsState {
  final Product product;
  ProductQuantityUpdatedState(this.product);
}
