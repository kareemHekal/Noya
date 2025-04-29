// ignore_for_file: must_be_immutable

part of 'bundle_cubit.dart';

@immutable
sealed class BundleState {}

final class Initial extends BundleState {}

final class GetBundlesSuccessState extends BundleState {
  List<BundleResponse> bundles;

  GetBundlesSuccessState({required this.bundles});
}

final class GetBundlesLoadingState extends BundleState {}

final class GetBundlesErrorState extends BundleState {
  String? message;

  GetBundlesErrorState({required this.message});
}


