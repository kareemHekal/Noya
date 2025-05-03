import 'package:animation_list/animation_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/di/di.dart';
import 'package:noya_app/presentation/tabs/home/also_avalibale_card.dart';
import 'package:noya_app/presentation/tabs/home/home_card.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/presentation/workers/contractors_page.dart';
import 'package:noya_app/presentation/materials/materials_page.dart';
import 'package:noya_app/presentation/materials/view_model/materials_cubit.dart';
import 'package:noya_app/presentation/workers/view_model/workers_cubit.dart';

class HomeScreen extends StatelessWidget {
  final Function(int index) onTabSelected;

  const HomeScreen({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: [
                  Image.asset("assets/images/1.jpg", fit: BoxFit.cover),
                  Image.asset("assets/images/2.jpg", fit: BoxFit.cover),
                  Image.asset("assets/images/3.jpg", fit: BoxFit.cover),
                ],
                options: CarouselOptions(
                  height: 300,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 1.0,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 300,
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.oliveGreen.withOpacity(0.9),
                        ColorManager.oliveGreen.withOpacity(0.4),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.titleNoya,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          AppStrings.subtitleInteriorDesign,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          AppStrings.subtitleSmartSolutions,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(500),
                      topRight: Radius.circular(500),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimationList(
                  duration: 1000,
                  reBounceDepth: 10.0,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.sectionTitleCompleteSolutions,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            textAlign: TextAlign.center,
                            AppStrings.sectionSubtitleCompleteSolutions,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    HomeCard(
                      onPressed: () {
                        onTabSelected(1);
                      },
                      icon: const Icon(
                        Icons.inventory_2_outlined,
                        color: ColorManager.white,
                      ),
                      label: AppStrings.buttonViewPackages,
                      description: AppStrings.descriptionViewPackages,
                      color: ColorManager.pistachio,
                    ),
                    HomeCard(
                      onPressed: () {
                        onTabSelected(3);
                      },
                      icon: const Icon(Icons.phone, color: ColorManager.white),
                      label: AppStrings.buttonRequestConsultation,
                      description: AppStrings.descriptionRequestConsultation,
                      color: ColorManager.mutedSageGreen,
                    ),
                    HomeCard(
                      onPressed: () {
                        onTabSelected(2);
                      },
                      icon: const Icon(Icons.layers, color: ColorManager.white),
                      label: AppStrings.buttonBuildCustomPackage,
                      description: AppStrings.descriptionBuildCustomPackage,
                      color: ColorManager.oliveGreen,
                    ),
                    Text(AppStrings.alsoAvailableTitle),
                    Row(
                      children: [
                        Expanded(
                          child: AlsoAvaliable(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BlocProvider(
                                        create: (context) => getIt<WorkersCubit>(),
                                        // Pass your WorkersUsecase instance here),
                                        child: const WorkersScreen(),
                                      ),
                                ),
                              );
                            },
                            label: AppStrings.contractorsLabel,
                            description: AppStrings.contractorsDescription,
                          ),
                        ),

                        Expanded(
                          child: AlsoAvaliable(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BlocProvider(
                                        create:
                                            (context) =>
                                                getIt<MaterialsCubit>(),
                                        child: const MaterialsScreen(),
                                      ),
                                ),
                              );
                            },

                            label: AppStrings.materialsLabel,
                            description: AppStrings.materialsDescription,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
