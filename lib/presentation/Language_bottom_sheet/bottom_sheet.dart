import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/config.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'Wigets/custom_divider.dart';
import 'Wigets/language_widget.dart';
import 'package:animation_list/animation_list.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);

    // Get the current theme
    final currentTheme = Theme.of(context);

    // Set the background color based on the theme
    final backgroundColor = currentTheme.brightness == Brightness.dark
        ? ColorManager.deepCharcoalWithGreenHint // Dark mode background color
        : ColorManager.white; // Light mode background color

    return Container(
      height: Config.screenHight! * 0.25,
      decoration: BoxDecoration(
        color: backgroundColor, // Dynamic background color
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(alignment: Alignment.center, child: CustomDivider()),
            Text(
              AppStrings.changeLanguage,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ,
            ),
            Expanded(
              child: AnimationList(
                duration: 1000,
                reBounceDepth: 10.0,
                children: [
                  LanguageSelectionItem(
                    label: AppStrings.english,
                    isSelected: context.locale == const Locale('en'),
                    onTap: () {
                      context.setLocale(const Locale('en'));
                      Navigator.pop(context);
                    },
                  ),
                  LanguageSelectionItem(
                    label: AppStrings.arabic,
                    isSelected: context.locale == const Locale('ar'),
                    onTap: () {
                      context.setLocale(const Locale('ar'));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
