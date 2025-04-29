import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/tab_item.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final Function(int) onTabChanged;
  final int selectedIndex;
  final TabController controller;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    required this.selectedIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.start,
      onTap: onTabChanged,
      dividerHeight: 0,
      indicatorWeight: 0,
      controller: controller,
      physics: const BouncingScrollPhysics(),
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      indicator: const BoxDecoration(),
      tabs:
          tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final title = entry.value;
            return Tab(
              child: TabItem(label: title, isSelected: selectedIndex == index),
            );
          }).toList(),
    );
  }
}
