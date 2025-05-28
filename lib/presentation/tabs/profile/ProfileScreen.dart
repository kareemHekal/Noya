import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/provider.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/presentation/tabs/profile/profile_card.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/routes_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/core/utils/text_style_manager.dart';
import 'package:noya_app/presentation/Language_bottom_sheet/bottom_sheet.dart';
import 'package:noya_app/presentation/base_url_changer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<DataProvider>(context, listen: false).initUser(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BaseUrlScreen()),
            );
          },
          icon: const Icon(Icons.settings_input_antenna, color: Colors.black),
        ),
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(AppStrings.profileLabel),
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, _) {
          final user = dataProvider.userModel;
          if (user == null) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.oliveGreen),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  spacing: 20,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      child: Icon(
                        Icons.person_2_outlined,
                        color: ColorManager.oliveGreen,
                        size: 30,
                      ),
                      backgroundColor: ColorManager.lightSand,
                    ),
                    Column(
                      spacing: 2,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            user.name,
                            style: AppTextStyle.medium20,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            user.email,
                            style: AppTextStyle.medium16.copyWith(
                              color: ColorManager.white80,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            user.phoneNumber ??
                                AppStrings.thisAccountDoesNotHavePhoneNumber,
                            style: AppTextStyle.medium16.copyWith(
                              color: ColorManager.white80,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            user.userAddress ??
                                AppStrings.thisAccountDoesNotHaveAddress,
                            style: AppTextStyle.medium16.copyWith(
                              color: ColorManager.white80,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(AppStrings.theme, style: AppTextStyle.medium20),
                      const Spacer(),
                      Switch(
                        activeColor: ColorManager.mutedSageGreen,
                        // when active
                        inactiveThumbColor: ColorManager.mutedSageGreen,
                        // thumb when inactive
                        inactiveTrackColor: ColorManager.lightSand,
                        // track when inactive
                        value: dataProvider.isDarkMode,
                        onChanged: (_) => dataProvider.toggleTheme(),
                      ),
                    ],
                  ),
                ),
                ProfileCard(
                  label: AppStrings.language,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const LanguageBottomSheet(),
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        label: AppStrings.logout,
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteManager.loginScreen,
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
