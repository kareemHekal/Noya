import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/custom_tab_bar_widget.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/core/utils/text_style_manager.dart';

class CoustomOrder extends StatefulWidget {
  const CoustomOrder({super.key});

  @override
  State<CoustomOrder> createState() => _CoustomOrderState();
}

class _CoustomOrderState extends State<CoustomOrder>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  List<String> categories = [
    "Beauty",
    "Healthcare",
    "Fitness",
    "Nutrition",
    "Mental Wellness",
    "Skincare",
    "Haircare",
    "Consulting",
    "Custom Orders",
    "Packages",
    "Lifestyle",
    "Therapy",
    "Medical",
    "Personal Care",
    "Fashion",
    "Technology",
    "Home Services",
    "Education",
  ];

  int itemsCount = 0;
  num total = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          AppStrings.builYourOwnPackage,
          style: AppTextStyle.medium20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$itemsCount ${AppStrings.itemsSelected}",
                          style: AppTextStyle.regular16,
                        ),
                        Text(
                          "${AppStrings.total}: \$$total ",
                          style: AppTextStyle.regular25,
                        ),
                      ],
                    ),
                    const Spacer(),
                    MyButton(
                      label: AppStrings.checkOut,
                      onPressed: itemsCount == 0 ? null : () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: CustomTabBar(
                        tabs: categories,
                        onTabChanged: (int index) {
                          _tabController.animateTo(index);
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        selectedIndex: _selectedIndex,
                        controller: _tabController,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // You can add tab content here if needed
            Expanded(
              child: Center(
                child: Text(
                  'Selected Category: ${categories[_selectedIndex]}',
                  style: AppTextStyle.medium20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
