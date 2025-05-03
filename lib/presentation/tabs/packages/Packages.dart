import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/di/di.dart';
import 'package:noya_app/presentation/tabs/packages/package_card.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:animation_list/animation_list.dart';
import 'package:noya_app/presentation/package_details/view_model/pakage_details_cubit.dart';
import 'package:noya_app/presentation/tabs/packages/view_model/cubit/bundle_cubit.dart';
import 'package:shimmer/shimmer.dart';

import 'view_model/cubit/bundle_intent.dart';

class Packages extends StatelessWidget {
  const Packages({super.key});

  @override
  Widget build(BuildContext context) {
    final packageCubit = getIt<PackageDetailsCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(AppStrings.homePackages),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (_) =>
          getIt<BundleCubit>()
            ..doIntent(GetBundleListIntent()),
          child: BlocListener<BundleCubit, BundleState>(
            listener: (context, state) {
              if (state is GetBundlesErrorState) {
                return toastMessage(
                  message: state.message.toString(),
                  tybeMessage: TybeMessage.negative,
                );
              }
            },
            child: BlocBuilder<BundleCubit, BundleState>(
              builder: (context, state) {
                if (state is GetBundlesLoadingState) {
                  return ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is GetBundlesSuccessState) {
                  return AnimationList(
                    duration: 800,
                    reBounceDepth: 20,
                    animationDirection: AnimationDirection.vertical,
                    opacityRange: Tween<double>(begin: 0.0, end: 1.0),
                    children: state.bundles.map((bundle) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child:
                      BlocProvider<PackageDetailsCubit>(
                        create: (_) => getIt<PackageDetailsCubit>(),
                        child: PackageDetails(
                          packageDetailsCubit: packageCubit,
                          bundleResponse: bundle,
                        ),
                      ),

                      );
                    }).toList(),
                  );
                }
                else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
