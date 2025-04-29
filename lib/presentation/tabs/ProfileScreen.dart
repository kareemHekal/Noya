import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/provider.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/profile_card.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/routes_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/core/utils/text_style_manager.dart';
import 'package:noya_app/data/models/user%20model.dart';
import 'package:noya_app/presentation/Language_bottom_sheet/bottom_sheet.dart';
import 'package:noya_app/presentation/base_url_changer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  Widget build(BuildContext context) {
    var dataprovider = Provider.of<DataProvider>(context);
    Usermodel? usermodel = dataprovider.usermodel;
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Padding(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      usermodel?.name ?? "User",
                      style: AppTextStyle.medium20,
                    ),
                    Text(
                      usermodel?.email ?? "User",
                      style: AppTextStyle.medium16.copyWith(
                        color: ColorManager.white80,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ProfileCard(label: AppStrings.myOrders, onPressed: () {}),
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
      ),
    );
  }
}
